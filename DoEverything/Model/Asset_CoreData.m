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
    [assets setValue:[asset[@"assetUrl"] absoluteString] forKey:@"assetUrl"];
    [assets setValue:asset[@"date"] forKey:@"date"];
    [assets setValue:[asset[@"url"] absoluteString] forKey:@"url"];
    [assets setValue:[asset[@"AssetUrl"] absoluteString] forKey:@"assetUrl"];
    [assets setValue:asset[@"groupId"] forKey:@"groupId"];
    [assets setValue:asset[@"byte"] forKey:@"byte"];
    [assets setValue:asset[@"location"] forKey:@"location"];
    [assets setValue:asset[@"meta"] forKey:@"meta"];
    [assets setValue:asset[@"scale"] forKey:@"scale"];
    [assets setValue:asset[@"size"] forKey:@"size"];
    [assets setValue:asset[@"type"] forKey:@"type"];
    [assets setValue:asset[@"width"] forKey:@"width"];
    [assets setValue:asset[@"height"] forKey:@"height"];
    [assets setValue:asset[@"duration"] forKey:@"duration"];
    [assets setValue:asset[@"orientation"] forKey:@"orientation"];
    [assets setValue:asset[@"fileName"] forKey:@"fileName"];
    [assets setValue:asset[@"path"] forKey:@"path"];
    [assets setValue:asset[@"fullPath"] forKey:@"fullPath"];
    
    NSError *error = nil;
    
    if(![context save:&error])
    {
        NSLog(@"Can't save!! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    
    return YES;
    
}

@end
