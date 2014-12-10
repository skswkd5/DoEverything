//
//  DEMGradientArcLayer.h
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 10..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEMArcLayer.h"

@interface DEMGradientArcLayer : DEMArcLayer

@property (nonatomic,assign) CGGradientRef gradient;

+ (CGGradientRef)defaultGradient;
@end
