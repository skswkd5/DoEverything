//
//  GroupLibrary_CoreData.h
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 22..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface GroupLibrary_CoreData : NSObject

+ (NSManagedObjectContext *)managedObjectContext;
+ (BOOL)insertGroupLibraryToCoreData:(NSDictionary *)group;
+ (BOOL)updateGroupLibraryToCoreData:(NSDictionary*)group;
+ (NSArray *)selectAllGroupLibrary;
@end
