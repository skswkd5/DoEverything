//
//  DEGArcLayerSubclass.h
//  DoEverything
//
//  Created by Jeesun Kim on 2014. 12. 8..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#ifndef DoEverything_DEGArcLayerSubclass_h
#define DoEverything_DEGArcLayerSubclass_h


#import "DEGArcLayer.h"

@interface DEGArcLayer (SubclassInfo)
- (void)drawArcInContext:(CGContextRef)ctx;
@end

#endif
