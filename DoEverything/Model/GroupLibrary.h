//
//  GroupLibrary.h
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 19..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GroupLibrary : NSManagedObject

@property (nonatomic, retain) NSNumber * groupId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * persistentID;
@property (nonatomic, retain) NSString * posterImage;
@property (nonatomic, retain) NSNumber * assetNumber;
@property (nonatomic, retain) NSNumber * totalAsset;
@property (nonatomic, retain) NSNumber * totalVideo;
@property (nonatomic, retain) NSNumber * totalImage;
@property (nonatomic, retain) NSNumber * totalSize;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSManagedObject *group_library;

@end
