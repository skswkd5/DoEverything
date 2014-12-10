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


NSString * const startAngleMyKey = @"startAngle";
NSString * const endAngleMyKey = @"endAngle";

@interface DEGArcLayer()


@end
@implementation DEGArcLayer

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    NSLog(@"%s: key - %@", __FUNCTION__, key);
    
    if ( [key isEqualToString:startAngleMyKey] ||
        [key isEqualToString:endAngleMyKey] )
    {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (id)initWithLayer:(id)layer
{
    NSLog(@"%s", __FUNCTION__);
    
    self = [super initWithLayer:layer];
    if ( self )
    {
        if ( [layer isKindOfClass:[DEGArcLayer class]] )
        {
            DEGArcLayer *otherLayer = (DEGArcLayer*)layer;
            self.startAngle = otherLayer.startAngle;
            self.endAngle = otherLayer.endAngle;
            self.fillColor = otherLayer.fillColor;
            self.arcThickness = otherLayer.arcThickness;
            self.strokeColor = otherLayer.strokeColor;
            self.strokeWidth = otherLayer.strokeWidth;
        }
    }
    return self;
}

#pragma mark - Public
- (CGPoint)pointForArcEdge:(ArcEdge)edge andArcSide:(ArcSide)side
{
    NSLog(@"%s", __FUNCTION__);
    
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
    NSLog(@"%s", __FUNCTION__);
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:key];
    anim.fromValue = [[self presentationLayer] valueForKey:key];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anim.duration = 0.5;
    
    return anim;
}

#pragma mark - Protected
- (void)drawArcInContext:(CGContextRef)ctx
{
    NSLog(@"%s", __FUNCTION__);
    
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
    NSLog(@"%s: event - %@", __FUNCTION__, event);
    
    if ( [event isEqualToString:startAngleMyKey] ||
        [event isEqualToString:endAngleMyKey] )
    {
        return [self makeAnimationForKey:event];
    }
    return [super actionForKey:event];
}

- (void)drawInContext:(CGContextRef)ctx
{
    NSLog(@"%s", __FUNCTION__);
    
    if ( self.startAngle < self.endAngle )
    {
        [self drawArcInContext:ctx];
        CGContextClosePath(ctx);

        // Color it
        CGContextSetFillColorWithColor(ctx, [self.fillColor CGColor]);
        CGContextSetStrokeColorWithColor(ctx, [self.strokeColor CGColor]);
        CGContextSetLineWidth(ctx, self.strokeWidth);
        
        CGContextDrawPath(ctx, kCGPathFillStroke);
    }
}


@end
