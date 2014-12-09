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
    NSLog(@"%s", __FUNCTION__);
    _needleColor = [UIColor colorWithRed:74/255.0 green:125/255.0 blue:135/255.0 alpha:1];
}

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"%s", __FUNCTION__);
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
    //바늘 그려주기
    NSLog(@"%s", __FUNCTION__);
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    CGContextSetFillColorWithColor(context, _needleColor.CGColor);
    CGContextSetStrokeColorWithColor(context, _needleColor.CGColor);
    
    CGRect circleRect = CGRectMake(0, height-width, width, width);
    CGContextFillEllipseInRect(context, circleRect);            //색 채우기
    NSLog(@"CircleRect: %@", NSStringFromCGRect(circleRect));
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, height-width/2);
    CGPathAddLineToPoint(path, NULL, width/2, 0);
    CGPathAddLineToPoint(path, NULL, width, height-width/2);
    CGPathAddLineToPoint(path, NULL, 0, height-width/2);
    CGPathCloseSubpath(path);
    
    NSLog(@"Path1: %d, %f", 0, height-width/2);
    NSLog(@"Path2: %f, %d", width/2, 0);
    NSLog(@"Path3: %f, %f", width, height-width/2);
    NSLog(@"Path4: %d, %f", 0, height-width/2);

    CGContextAddPath(context, path);
    CGContextFillPath(context);
}

- (void)setNeedleColor:(UIColor *)needleColor
{
    NSLog(@"%s", __FUNCTION__);
    if ( _needleColor != needleColor )
    {
        _needleColor = needleColor;
        [self setNeedsDisplay];
    }
}


@end
