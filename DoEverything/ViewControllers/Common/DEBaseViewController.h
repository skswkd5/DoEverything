//
//  DEBaseViewController.h
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 16..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DEDiskInfo.h"
#import "DEMultimediaInfo.h"

@interface DEBaseViewController : UIViewController

@property (nonatomic, strong) DEDiskInfo *diskInfo;
@property (nonatomic, strong) DEMultimediaInfo *mediaInfo;

- (void)initializingData;
@end
