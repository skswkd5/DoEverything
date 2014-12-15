//
//  DEGetValues.h
//  DoEverything
//
//  Created by 김지선 on 2014. 11. 27..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DEGetValues : NSObject


+ (float)disSpace;
+ (uint64_t)getFreeDiskSpace;

+ (uint64_t)getSpaceForPhotos;
+ (uint64_t)getSpaceForVideos;

+ (NSString *)memoryFormatter:(long long)diskSpace;
+ (long long)totalDiskSpace;
+ (long long)freeDiskSpace;
+ (long long)usedDiskSpace;

+ (NSNumber *)totalDiskSize;
+ (NSNumber *)freeDiskSize;

+ (void)report_memory;
//+ (CGFloat)totalDiskSpaceInBytes;
//+ (CGFloat)freeDiskSpaceInBytes ;
//+ (CGFloat)usedDiskSpaceInBytes;

+ (void)getMultimediaInfo;

@end
