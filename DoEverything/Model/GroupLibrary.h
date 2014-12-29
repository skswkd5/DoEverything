//
//  GroupLibrary.h
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 29..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Assets;

@interface GroupLibrary : NSManagedObject

@property (nonatomic, retain) NSString * groupName;
@property (nonatomic, retain) NSString * groupId;
@property (nonatomic, retain) NSString * posterImage;
@property (nonatomic, retain) NSNumber * totalAsset;
@property (nonatomic, retain) NSNumber * totalImage;
@property (nonatomic, retain) NSNumber * totalSize;
@property (nonatomic, retain) NSNumber * totalVideo;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) Assets *group_library;

@end
