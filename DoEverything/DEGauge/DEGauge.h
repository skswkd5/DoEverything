//
//  DEGauge.h
//  DoEverything
//
//  Created by Jeesun Kim on 2014. 12. 5..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DEGNeedleView.h"

@interface DEGauge : UIView

@property (nonatomic) DEGNeedleView *needleView;
@property (nonatomic,assign) float maxValue;
@property (nonatomic,assign) float minValue;
@property (nonatomic,assign) float value;
@property (nonatomic,assign) float startAngle;
@property (nonatomic,assign) float endAngle;
@property (nonatomic,assign) float arcThickness;
@property (nonatomic) UIColor *backgroundArcFillColor;
@property (nonatomic) UIColor *backgroundArcStrokeColor;
@property (nonatomic) UIColor *fillArcFillColor;
@property (nonatomic) UIColor *fillArcStrokeColor;
@property (nonatomic) CGGradientRef fillGradient;
@property (nonatomic) CGGradientRef backgroundGradient;

- (void)setValue:(float)value animated:(BOOL)animated;
- (void)setStartAngle:(float)startAngle animated:(BOOL)animted;
- (void)setEndAngle:(float)endAngle animated:(BOOL)animated;

@end
