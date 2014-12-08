//
//  DEGNeedleView.m
//  DoEverything
//
//  Created by Jeesun Kim on 2014. 12. 8..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEGNeedleView.h"

@implementation DEGNeedleView

- (void)setup
{
    _needleColor = [UIColor blackColor];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    CGContextSetFillColorWithColor(context, _needleColor.CGColor);
    CGContextSetStrokeColorWithColor(context, _needleColor.CGColor);
    
    CGRect circleRect = CGRectMake(0, height-width, width, width);
    CGContextFillEllipseInRect(context, circleRect);
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, height-width/2);
    CGPathAddLineToPoint(path, NULL, width/2, 0);
    CGPathAddLineToPoint(path, NULL, width, height-width/2);
    CGPathAddLineToPoint(path, NULL, 0, height-width/2);
    CGPathCloseSubpath(path);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
}

- (void)setNeedleColor:(UIColor *)needleColor
{
    if ( _needleColor != needleColor )
    {
        _needleColor = needleColor;
        [self setNeedsDisplay];
    }
}


@end
