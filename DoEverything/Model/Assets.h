//
//  Assets.h
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 29..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GroupLibrary;

@interface Assets : NSManagedObject

@property (nonatomic, retain) NSString * assetUrl;
@property (nonatomic, retain) NSNumber * byte;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * groupId;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * meta;
@property (nonatomic, retain) NSString * scale;
@property (nonatomic, retain) NSString * size;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * orientation;
@property (nonatomic, retain) NSString * fullPath;
@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) GroupLibrary *asset_list;

@end
