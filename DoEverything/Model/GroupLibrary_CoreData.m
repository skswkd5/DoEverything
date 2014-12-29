//
//  GroupLibrary_CoreData.m
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 22..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//


#import "GroupLibrary.h"
#import "GroupLibrary_CoreData.h"
#import "AppDelegate.h"

@implementation GroupLibrary_CoreData

- (GroupLibrary*)convertFromDictionToGroupLibrary:(NSDictionary*)dic
{
    GroupLibrary *library = nil;
    
    return library;
}

- (NSDictionary*)convertFromGroupLibraryToDiction:(GroupLibrary*)library
{
    NSMutableDictionary *group = [[NSMutableDictionary alloc] init];
    
    return group;
}

+ (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

+ (BOOL)insertGroupLibraryToCoreData:(NSDictionary*)group
{
    if(group == nil)
        return NO;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newGroup = [NSEntityDescription insertNewObjectForEntityForName:@"GroupLibrary" inManagedObjectContext:context];
    [newGroup setValue:group[@"groupName"] forKey:@"groupName"];
    [newGroup setValue:group[@"groupId"] forKey:@"groupId"];
    [newGroup setValue:group[@"type"] forKey:@"type"];
    [newGroup setValue:[group[@"url"] absoluteString] forKey:@"url"];
    [newGroup setValue:group[@"totalAsset"] forKey:@"totalAsset"];
    [newGroup setValue:group[@"totalImage"] forKey:@"totalImage"];
    [newGroup setValue:group[@"totalVideo"] forKey:@"totalVideo"];
    [newGroup setValue:group[@"totalSize"] forKey:@"totalSize"];
    [newGroup setValue:group[@"posterImage"] forKey:@"posterImage"];
    
    NSError *error = nil;
    
    if(![context save:&error])
    {
        NSLog(@"Can't save!! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    
    return YES;
    
}

+ (BOOL)updateGroupLibraryToCoreData:(NSDictionary*)group
{
    if (group == nil) {
        return NO;
    }
    
    //이미 있는 데이터 인지 확인한다.
    NSManagedObjectContext *context = [self managedObjectContext];
    __block NSError *error = nil;
    
    [context performBlock:^{
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"GroupLibrary" inManagedObjectContext:context];
        
        [fetchRequest setEntity:entity];
        
        NSPredicate *predicate = nil;
        NSString *attributeName = @"groupName";
        NSString *attributeValue = group[@"groupName"];
        
        predicate = [NSPredicate predicateWithFormat:@"%K like %@", attributeName, attributeValue];
        [fetchRequest setPredicate:predicate];
        [fetchRequest setResultType:NSManagedObjectIDResultType];
        
        GroupLibrary *tmp = nil;
        
        NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
        if(result.count >0)
        {
            //이미 저장된 그룹(변경내용을 수정한다)
            tmp = (GroupLibrary *)[context objectWithID:(NSManagedObjectID *)[result lastObject]];
        }
        else
        {
            //추가된 그룹을 insert 한다.
//            [self insertGroupLibraryToCoreData:group];
            tmp = (GroupLibrary *)[NSEntityDescription insertNewObjectForEntityForName:@"GroupLibrary" inManagedObjectContext:context];
            tmp.groupName = group[@"groupName"];
            tmp.type = group[@"type"];
            tmp.url = group[@"url"];
            tmp.groupId = group[@"groupId"];
            tmp.totalAsset = group[@"totalAsset"];
            tmp.totalImage = group[@"totalImage"];
            tmp.totalVideo = group[@"totalVideo"];
            tmp.posterImage = group [@"posterImage"];
            tmp.totalSize = group[@"totalSize"];
            
        }
        
        fetchRequest = nil;
        error = nil;
        
        if(![context save:&error])
        {
            NSLog(@"Can't save!! %@ %@", error, [error localizedDescription]);
        }
        
    }];
    
    if(error != nil)
        return NO;
    else
        return YES;
}

+ (NSArray *)selectAllGroupLibrary
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"GroupLibrary" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    
    if (result != nil) {
        
    }
    
    return result;
}




@end
