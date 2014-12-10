//
//  DEMGaugeView.m
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 10..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEMGaugeView.h"
#import "DEMArcLayer.h"
#import "DEMGradientArcLayer.h"
#import <QuartzCore/QuartzCore.h>

#define M_PI 3.14159265358979323846264338327950288
#define DEGREES_TO_RADIANS(angle) (angle * (M_PI/180))

#define NEEDLE_BASE_WIDTH_RATIO .04

@interface DEMGaugeView ()
@property (nonatomic) CALayer *containerLayer;
@property (nonatomic) DEMGradientArcLayer *valueArcLayer;
@property (nonatomic) DEMGradientArcLayer *backgroundArcLayer;
@end

@implementation DEMGaugeView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

#pragma mark - Initialization / Construction
- (void)setup
{
    _minValue = 0;
    _maxValue = 100;
    _value = 0;
    
    _startAngle = 40;
    _endAngle = 140;
    
    _arcThickness = 50;
    
    _backgroundArcFillColor = [UIColor whiteColor];
    _backgroundArcStrokeColor = [UIColor brownColor];
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
//    CGFloat needleWidth = width * NEEDLE_BASE_WIDTH_RATIO;
//    _needleView = [[MSNeedleView alloc] initWithFrame:CGRectMake(0,
//                                                                 0,
//                                                                 needleWidth,
//                                                                 width/2+4)];
//    if ( [_needleView respondsToSelector:@selector(contentScaleFactor)] )
//    {
//        _needleView.contentScaleFactor = [[UIScreen mainScreen] scale];
//    }
//    [self addSubview:_needleView];
    
    
    
//    _needleView.layer.anchorPoint = CGPointMake(.5, (height-(needleWidth/2))/height);
//    _needleView.center = CGPointMake(width/2, height-needleWidth/2);
//    [self rotateNeedleByAngle:-90+_startAngle];
    
    _containerLayer = [CALayer layer];
    _containerLayer.frame = CGRectMake(0, 0, width, height);
    [self.layer insertSublayer:_containerLayer atIndex:0];
    [self setupArcLayers];
}

- (void)setupArcLayers
{
    //게이지 이미지 값 세팅하기
    NSLog(@"%s", __FUNCTION__);
    
    _backgroundArcLayer = [DEMGradientArcLayer layer];
    _backgroundArcLayer.strokeColor = _backgroundArcStrokeColor;
    _backgroundArcLayer.fillColor = _backgroundArcFillColor;
    _backgroundArcLayer.gradient = _backgroundGradient;             //경사도
    _backgroundArcLayer.strokeWidth = 1.0;
    _backgroundArcLayer.arcThickness = _arcThickness;
    _backgroundArcLayer.startAngle = DEGREES_TO_RADIANS((_startAngle+180));
    _backgroundArcLayer.endAngle = DEGREES_TO_RADIANS((_endAngle+180));
    _backgroundArcLayer.bounds = _containerLayer.bounds;
    _backgroundArcLayer.anchorPoint = CGPointZero;
    if ( [_backgroundArcLayer respondsToSelector:@selector(contentsScale)] )
    {
        _backgroundArcLayer.contentsScale = [[UIScreen mainScreen] scale];
    }
    [_containerLayer addSublayer:_backgroundArcLayer];
    
    _valueArcLayer = [DEMGradientArcLayer layer];
    _valueArcLayer.strokeColor = _fillArcStrokeColor;
    _valueArcLayer.fillColor = _fillArcFillColor;
    _valueArcLayer.gradient = _fillGradient;
    _valueArcLayer.arcThickness = _arcThickness;
    _valueArcLayer.startAngle = DEGREES_TO_RADIANS((_startAngle+180));
    _valueArcLayer.endAngle = DEGREES_TO_RADIANS((_startAngle+180));
    _valueArcLayer.bounds = _containerLayer.bounds;
    _valueArcLayer.anchorPoint = CGPointZero;

    if ( [_valueArcLayer respondsToSelector:@selector(contentsScale)] )
    {
        _valueArcLayer.contentsScale = [[UIScreen mainScreen] scale];
    }
    [_containerLayer addSublayer:_valueArcLayer];
}


#pragma mark - Private / Protected
//- (void) 
- (void)setValue:(id)value forKey:(NSString *)key animated:(BOOL)animated
{
    NSLog(@"%s key - %@", __FUNCTION__, key );
    
    // half second duration or none depending on animated flag
    float duration = animated ? .9 : 0;
    [UIView animateWithDuration:duration
                          delay:40
                        options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         NSLog(@"Animating!!");
                         [self setValue:value forKey:key];
                     }
                     completion:^(BOOL finished) {
                     }];
}


- (void)rotateNeedleByAngle:(float)angle
{
//    CATransform3D rotatedTransform = self.needleView.layer.transform;
//    rotatedTransform = CATransform3DRotate(rotatedTransform, DEGREES_TO_RADIANS(angle), 0.0f, 0.0f, 1.0f);
//    self.needleView.layer.transform = rotatedTransform;
}

- (void)fillUpToAngle:(float)angle
{
    NSLog(@"%s", __FUNCTION__);
    if ( _valueArcLayer )
    {
        NSLog(@"Animating!!");
        _valueArcLayer.endAngle = DEGREES_TO_RADIANS((angle+180));
    
    
//    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"fillUpToAngle"];
//    animation.duration = 0.7f;
//    animation.fromValue = _valueArcLayer.startAngle
//    animation.toValue = _valueArcLayer.endAngle;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    [_valueArcLayer addAnimation:animation forKey:@"strokeEnd"];
        
    }
    
}

- (float)angleForValue:(float)value
{
    NSLog(@"%s", __FUNCTION__);
    float ratio = (value - _minValue) / (_maxValue - _minValue); //값의 비율
    float angle = _startAngle + ((_endAngle - _startAngle) * ratio);    //값을 각도로 환산
    
     NSLog(@"return value: %f", angle);
    return angle;
}

#pragma mark - Setters
- (void)setArcThickness:(float)arcThickness
{
    NSLog(@"%s", __FUNCTION__);
    if ( _arcThickness != arcThickness )
    {
        NSLog(@"arcThickness: %f", arcThickness);
        _arcThickness = arcThickness;
        [self setNeedsDisplay];
    }
}

- (void)setStartAngle:(float)startAngle
{
    NSLog(@"%s", __FUNCTION__);
    if ( _startAngle != startAngle )
    {
        float oldNeedleAngle = [self angleForValue:self.value];
        
        _startAngle = startAngle;
        _backgroundArcLayer.startAngle = DEGREES_TO_RADIANS((_startAngle+180));
        _valueArcLayer.startAngle = DEGREES_TO_RADIANS((_startAngle+180));
        
        float newNeedleAngle = [self angleForValue:self.value];
        float newAngle = newNeedleAngle - oldNeedleAngle;
        [self rotateNeedleByAngle:newAngle];
    }
}

- (void)setEndAngle:(float)endAngle
{
    NSLog(@"%s", __FUNCTION__);
    if ( _endAngle != endAngle )
    {
        float oldNeedleAngle = [self angleForValue:self.value];
        
        _endAngle = endAngle;
        _backgroundArcLayer.endAngle = DEGREES_TO_RADIANS((_endAngle+180));
        _valueArcLayer.endAngle = DEGREES_TO_RADIANS((oldNeedleAngle+180));
        
        float newNeedleAngle = [self angleForValue:self.value];
        float newAngle = newNeedleAngle - oldNeedleAngle;
        [self rotateNeedleByAngle:newAngle];
    }
}

- (void)setMinValue:(float)minValue
{
    NSLog(@"%s", __FUNCTION__);
    if ( _minValue != minValue )
    {
        // don't let the min value be greater than the max value
        minValue = minValue > _maxValue ? _maxValue : minValue;
        _minValue = minValue;
    }
}

- (void)setMaxValue:(float)maxValue
{
    NSLog(@"%s", __FUNCTION__);
    if ( _maxValue != maxValue )
    {
        // don't let the max value be lower then the min value
        maxValue = maxValue < _minValue ? _minValue : maxValue;
        _maxValue = maxValue;
    }
}

- (void)setValue:(float)value
{
    NSLog(@"%s", __FUNCTION__);
    if ( _value != value )
    {
        // setting value above the max value sets to max value
        value = value > _maxValue ? _maxValue : value;
        
        // setting value below the min value set to min value
        value = value < _minValue ? _minValue : value;
        
        float oldValue = _value < _minValue ? _minValue : _value;
        float oldAngle = [self angleForValue:oldValue];
        float newAngle = [self angleForValue:value];
        _value = value;
        
        [self rotateNeedleByAngle:newAngle - oldAngle];
        [self fillUpToAngle:newAngle];
    }
}

- (void)setBackgroundArcFillColor:(UIColor *)backgroundArcFillColor
{
    NSLog(@"%s", __FUNCTION__);
    _backgroundArcLayer.fillColor = backgroundArcFillColor;
}

- (void)setBackgroundArcStrokeColor:(UIColor *)backgroundArcStrokeColor
{
    NSLog(@"%s", __FUNCTION__);
    _backgroundArcLayer.strokeColor = backgroundArcStrokeColor;
}

- (void)setFillArcFillColor:(UIColor *)foregroundArcFillColor
{
    NSLog(@"%s", __FUNCTION__);
    _valueArcLayer.fillColor = foregroundArcFillColor;
}

- (void)setFillArcStrokeColor:(UIColor *)foregroundArcStrokeColor
{
    NSLog(@"%s", __FUNCTION__);
    _valueArcLayer.strokeColor = foregroundArcStrokeColor;
}

- (void)setFillGradient:(CGGradientRef)fillGradient
{
    NSLog(@"%s", __FUNCTION__);
    _valueArcLayer.gradient = fillGradient;
}

- (void)setBackgroundGradient:(CGGradientRef)backgroundGradient
{
    NSLog(@"%s", __FUNCTION__);
    _backgroundArcLayer.gradient = backgroundGradient;
}

#pragma mark - Animated Setters
- (void)setValue:(float)value animated:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);
    [self setValue:@(value) forKey:@"value" animated:animated];
}

- (void)setEndAngle:(float)endAngle animated:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);
    [self setValue:@(endAngle) forKey:@"endAngle" animated:animated];
}

- (void)setStartAngle:(float)startAngle animated:(BOOL)animted
{
    NSLog(@"%s", __FUNCTION__);
    [self setValue:@(startAngle) forKey:@"startAngle" animated:animted];
}


@end
