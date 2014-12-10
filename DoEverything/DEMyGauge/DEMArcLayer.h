//
//  DEMArcLayer.h
//  DoEverything
//
//  Created by Jeesun Kim on 2014. 12. 9..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef enum {
    ArcEdgeInner = 0,
    ArcEdgeOuter
} ArcEdge;

typedef enum {
    ArcSideBegining = 0,
    ArcSideEnd
} ArcSide;

@interface DEMArcLayer : CALayer

@property (nonatomic,assign) CGFloat startAngle;
@property (nonatomic,assign) CGFloat endAngle;
@property (nonatomic,assign) CGFloat strokeWidth;
@property (nonatomic,assign) CGFloat arcThickness;
@property (nonatomic) UIColor *fillColor;
@property (nonatomic) UIColor *strokeColor;
- (CGPoint)pointForArcEdge:(ArcEdge)edge andArcSide:(ArcSide)side;
- (void)drawArcInContext:(CGContextRef)ctx;
@end
