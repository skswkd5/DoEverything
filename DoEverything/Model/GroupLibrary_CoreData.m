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
    
//    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [self managedObjectContext];// [appDelegate managedObjectContext];
    NSManagedObject *newGroup = [NSEntityDescription insertNewObjectForEntityForName:@"GroupLibrary" inManagedObjectContext:context];
    [newGroup setValue:group[@"AlbumName"] forKey:@"name"];
    [newGroup setValue:group[@"Type"] forKey:@"type"];
    [newGroup setValue:[group[@"url"] absoluteString] forKey:@"url"];
    [newGroup setValue:group[@"PersisId"] forKey:@"persistentID"];
    [newGroup setValue:group[@"TotalCount"] forKey:@"totalAsset"];
    [newGroup setValue:group[@"TotalImage"] forKey:@"totalImage"];
    [newGroup setValue:group[@"TotalVideo"] forKey:@"totalVideo"];
    
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
        NSString *attributeName = @"name";
        NSString *attributeValue = group[@"AlbumName"];
        
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
            tmp.name = group[@"AlbumName"];
            tmp.type = group[@"Type"];
            tmp.url = group[@"url"];
            tmp.persistentID = group[@"PersisId"];
            tmp.totalAsset = group[@"TotalCount"];
            tmp.totalImage = group[@"TotalImage"];
            tmp.totalImage = group[@"TotalVideo"];
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
