//
//  DEGGradientArcLayer.h
//  DoEverything
//
//  Created by Jeesun Kim on 2014. 12. 8..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "DEGArcLayerSubclass.h"

@interface DEGGradientArcLayer : DEGArcLayer

@property (nonatomic,assign) CGGradientRef gradient;

+ (CGGradientRef)defaultGradient;

@end