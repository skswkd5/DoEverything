//
//  DEMacro.h
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 16..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#ifndef DoEverything_DEMacro_h
#define DoEverything_DEMacro_h







#pragma mark - Singletone

#define MediaInfo [DEMultimediaInfo sharedDEMultimediaInfo]
#define AppDelegate ((OFAppDelegate *)[UIApplication sharedApplication].delegate)


#pragma mark - MainScreen

#define MainScreenBounds	[UIScreen mainScreen].bounds
#define MainScreenWidth		[UIScreen mainScreen].bounds.size.width
#define MainScreenHeight	[UIScreen mainScreen].bounds.size.height
#define GREATER_THAN_IPHONE_5 MainScreenHeight == 568 || MainScreenWidth == 568 ? YES : NO;

#endif
