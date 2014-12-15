//
//  DEDiskInfo.h
//  DoEverything
//
//  Created by Jeesun Kim on 2014. 12. 9..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DEDiskInfo : NSObject


@property (nonatomic, strong) NSString *totalWithUnit;
@property (nonatomic, strong) NSString *freeWithUnit;
@property (nonatomic, strong) NSString *usedWithUnit;

@property (nonatomic, strong) NSNumber *totalSpaceInBytes;
@property (nonatomic, strong) NSNumber *freeSpaceInBytes;
@property (nonatomic, strong) NSNumber *usedSpaceInBytes;

@property (nonatomic, strong) NSString *totalPercent;
@property (nonatomic, strong) NSString *freePercent;
@property (nonatomic, strong) NSString *usedPercent;

@end
