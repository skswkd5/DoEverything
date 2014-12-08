//
//  DEGArcLayer.m
//  DoEverything
//
//  Created by Jeesun Kim on 2014. 12. 8..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//


#import "DEGArcLayer.h"

#define M_PI   3.14159265358979323846264338327950288
#define DEGREES_TO_RADIANS(angle) (angle * (M_PI/180))


NSString * const startAngleKey = @"startAngle";
NSString * const endAngleKey = @"endAngle";

@interface DEGArcLayer()

//@property (nonatomic,assign) UIColor *fillColor;
//@property (nonatomic,assign) UIColor *strokeColor;

@end
@implementation DEGArcLayer

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ( [key isEqualToString:startAngleKey] ||
        [key isEqualToString:endAngleKey] )
    {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (id)initWithLayer:(id)layer
{
    self = [super initWithLayer:layer];
    if ( self )
    {
        if ( [layer isKindOfClass:[DEGArcLayer class]] )
        {
            DEGArcLayer *otherLayer = (DEGArcLayer*)layer;
            self.startAngle = otherLayer.startAngle;
            self.endAngle = otherLayer.endAngle;
//            self.fillColor = otherLayer.fillColor;
            self.arcThickness = otherLayer.arcThickness;
//            self.strokeColor = otherLayer.strokeColor;
            self.strokeWidth = otherLayer.strokeWidth;
        }
    }
    return self;
}

#pragma mark - Public
- (CGPoint)pointForArcEdge:(ArcEdge)edge andArcSide:(ArcSide)side
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat radius = width/2;
    if ( edge == ArcEdgeInner )
    {
        radius -= self.arcThickness;
    }
    
    CGFloat angle = self.startAngle;
    if ( side == ArcSideEnd )
    {
        angle = self.endAngle;
    }
    
    CGFloat x = width/2 + radius * cosf(angle);
    CGFloat y = height + radius * sinf(angle);
    
    return CGPointMake(x,y);
}

#pragma mark - Private
- (CABasicAnimation*)makeAnimationForKey:(NSString *)key
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:key];
    anim.fromValue = [[self presentationLayer] valueForKey:key];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anim.duration = 0.5;
    
    return anim;
}

#pragma mark - Protected
- (void)drawArcInContext:(CGContextRef)ctx
{
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height);
    CGFloat radius = self.bounds.size.width/2;
    
    CGContextBeginPath(ctx);
    
    // outer arc
    CGContextAddArc(ctx, center.x, center.y, radius, self.startAngle, self.endAngle, NO);
    
    // line down to the inner arc
    CGPoint innerArchEnd = [self pointForArcEdge:ArcEdgeInner andArcSide:ArcSideEnd];
    CGContextAddLineToPoint(ctx, innerArchEnd.x, innerArchEnd.y);
    
    // inner arc
    CGContextAddArc(ctx, center.x, center.y, radius-self.arcThickness, self.endAngle, self.startAngle, YES);
    
    // final connection back up to outer arc
    CGPoint outerArcStart = [self pointForArcEdge:ArcEdgeOuter andArcSide:ArcSideBegining];
    CGContextAddLineToPoint(ctx, outerArcStart.x, outerArcStart.y);
}

- (id<CAAction>)actionForKey:(NSString *)event
{
    if ( [event isEqualToString:startAngleKey] ||
        [event isEqualToString:endAngleKey] )
    {
        return [self makeAnimationForKey:event];
    }
    return [super actionForKey:event];
}

- (void)drawInContext:(CGContextRef)ctx
{
    if ( self.startAngle < self.endAngle )
    {
        [self drawArcInContext:ctx];
        CGContextClosePath(ctx);

        // Color it
//        CGContextSetFillColorWithColor(ctx, self.fillColor.CGColor);
//        CGContextSetStrokeColorWithColor(ctx, self.strokeColor.CGColor);
//        CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
//        CGContextSetStrokeColorWithColor(ctx, [UIColor purpleColor].CGColor);
        CGContextSetLineWidth(ctx, self.strokeWidth);
        
        CGContextDrawPath(ctx, kCGPathFillStroke);
    }
}


@end
