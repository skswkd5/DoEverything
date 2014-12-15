//
//  DEDiskInfo.m
//  DoEverything
//
//  Created by Jeesun Kim on 2014. 12. 9..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEDiskInfo.h"
#import "DEGetValues.h"
#import "DEMultimediaInfo.h"

@implementation DEDiskInfo

- (id)init
{
    self = [super init];
    if(self) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    [self getDiskSpaceInfo];
    
}

#pragma mark - Disk Info
- (double)getPercentValue:(long long)longValue totalValue:(long long)total
{
    double doubleValue = 1.0 * longValue;
    double totalValue = 1.0 * total;
    double percentValue = doubleValue/totalValue * 100;
    return percentValue;
}

- (void)getDiskSpaceInfo
{
    _totalSpaceInBytes = [DEGetValues totalDiskSize];
    long long total  = [_totalSpaceInBytes longLongValue];
    _totalWithUnit = [DEGetValues memoryFormatter:total];
    _totalPercent  = @"100";
    
    
    _freeSpaceInBytes = [DEGetValues freeDiskSize];
    long long free  = [_freeSpaceInBytes longLongValue];
    _freeWithUnit = [DEGetValues memoryFormatter:free];
    double freeP = [self getPercentValue:free totalValue:total];
    _freePercent = [[NSString alloc] initWithFormat:@"%.2f", freeP];
    
    _usedSpaceInBytes = [[NSNumber alloc] initWithLongLong:(total - free)];
    long long used = total - free;
    _usedWithUnit = [DEGetValues memoryFormatter:used];
    double  usedP = [self getPercentValue:used totalValue:total];
    _usedPercent = [[NSString alloc] initWithFormat:@"%.2f", usedP];
    
    [DEMultimediaInfo getMultimediaInfo];

    
}



@end
