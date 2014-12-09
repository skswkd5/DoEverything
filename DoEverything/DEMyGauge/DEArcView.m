//
//  DEArcView.m
//  DoEverything
//
//  Created by Jeesun Kim on 2014. 12. 9..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEArcView.h"

@implementation DEArcView

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"%s", __FUNCTION__);
    self = [super initWithFrame:frame];
    if (self)
    {

//        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = self.bounds.size.width/2;
    
    CGContextRef context;
    CGContextBeginPath(context);
    
    CGContextAddArc(context, center.x, center.y, radius, 0, 180, NO);
    
//    CGPoint innerArcEnd =
}


@end
