//
//  DEMGradientArcLayer.m
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 10..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEMGradientArcLayer.h"

@implementation DEMGradientArcLayer

+ (CGGradientRef)defaultGradient
{
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { .23,.56,.75,1.0,  // Start color
        .48,.71,.84,1.0 }; // End color
    CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef myGradient = CGGradientCreateWithColorComponents (myColorspace, components, locations, num_locations);
    return myGradient;
}

- (id)initWithLayer:(id)layer
{
    NSLog(@"%s", __FUNCTION__);
    self = [super initWithLayer:layer];
    if ( self )
    {
        if ( [layer isKindOfClass:[DEMGradientArcLayer class]] )
        {
            DEMGradientArcLayer *otherLayer = (DEMGradientArcLayer*)layer;
            self.gradient = otherLayer.gradient;
        }
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx
{
    NSLog(@"%s", __FUNCTION__);
    // if there is a gradient defined, draw it. Otherwise have super do the drawing
    if ( self.gradient )
    {
        if ( self.startAngle < self.endAngle )
        {
            NSLog(@"### 그리기");
            CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height);
            CGFloat radius = self.bounds.size.width/2;
            
            [self drawArcInContext:ctx];
            CGContextClip(ctx);
            CGContextDrawRadialGradient(ctx, _gradient, center, radius-self.arcThickness, center, radius, 0);
        }
    }
    else
    {
        [super drawInContext:ctx];
    }
}

- (void)setGradient:(CGGradientRef)gradient
{
    NSLog(@"%s", __FUNCTION__);
    _gradient = gradient;
    [self setNeedsDisplay];
}


@end
