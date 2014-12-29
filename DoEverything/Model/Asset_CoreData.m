//
//  Asset_CoreData.m
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 22..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "Assets.h"
#import "Asset_CoreData.h"
#import "AppDelegate.h"

@implementation Asset_CoreData

+ (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

+ (BOOL)insertAssetsToCoreData:(NSDictionary *)asset
{
    if(asset == nil)
        return NO;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *assets = [NSEntityDescription insertNewObjectForEntityForName:@"Assets" inManagedObjectContext:context];
    [assets setValue:asset[@"AssetUrl"] forKey:@"assetUrl"];
    [assets setValue:asset[@"Date"] forKey:@"date"];
    [assets setValue:[asset[@"url"] absoluteString] forKey:@"url"];
    [assets setValue:[asset[@"AssetUrl"] absoluteString] forKey:@"assetUrl"];
    [assets setValue:asset[@"GroupId"] forKey:@"groupId"];
    [assets setValue:asset[@"ID"] forKey:@"id"];
    [assets setValue:asset[@"Location"] forKey:@"location"];
    [assets setValue:asset[@"Meta"] forKey:@"meta"];
    [assets setValue:asset[@"Scale"] forKey:@"scale"];
    [assets setValue:asset[@"Size"] forKey:@"size"];
    [assets setValue:asset[@"Type"] forKey:@"type"];
    
    NSError *error = nil;
    
    if(![context save:&error])
    {
        NSLog(@"Can't save!! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    
    return YES;
    
}

@end
