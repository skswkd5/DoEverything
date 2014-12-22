//
//  DEMultimediaInfo.m
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 15..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEMultimediaInfo.h"
#import "GroupLibrary_CoreData.h"


@interface DEMultimediaInfo()

@end

@implementation DEMultimediaInfo


static DEMultimediaInfo *sharedDEMultimediaInfo = nil;

+ (DEMultimediaInfo *)sharedDEMultimediaInfo
{
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedDEMultimediaInfo = [[self alloc] init];
    });
    
    return sharedDEMultimediaInfo;
}

- (id)init
{
    self = [super init];
    if(self) {
        [self setMultimediaInfo];
    }
    return self;
}


- (void)setMultimediaInfo
{
    __block int videoCount = 0;
    __block int photoCount = 0;
    __block int index = 0;
    __block NSMutableArray *arrGroups = [[NSMutableArray alloc] init];
    
    NSArray *result = [GroupLibrary_CoreData selectAllGroupLibrary];
    if (result.count <= 0)
    {
        ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc]init];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
            {
                if (group == nil) {
                    
                    _numberOfAllMovies = [NSNumber numberWithInt:videoCount];
                    _numberOfAllPictures = [NSNumber numberWithInt:photoCount];
                    _assetGroups = [NSArray arrayWithArray:arrGroups];
                    
                    return;
                }
                
                NSString *groupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
                NSNumber *Type = [NSNumber numberWithInt:[[group valueForProperty:ALAssetsGroupPropertyType] intValue]];
                NSNumber *total = [NSNumber numberWithInteger:group.numberOfAssets];
                NSString *perID = [group valueForProperty:ALAssetsGroupPropertyPersistentID];
                NSURL *url = [group valueForProperty:ALAssetsGroupPropertyURL];
                NSLog(@"NumberOfAssets: %ld", [group numberOfAssets]);
                
                [group setAssetsFilter:[ALAssetsFilter allVideos]];
                int groupVideoCount = group.numberOfAssets;
                int groupImageCount = [total intValue] - groupVideoCount;
                
                videoCount += groupVideoCount;
                photoCount += groupImageCount;
                
                NSDictionary *dicGroup = @{@"id":[NSNumber numberWithInt:++index],
                                           @"AlbumName":groupPropertyName, @"Type":Type,
                                           @"TotalCount":total,
                                           @"ImageCount":[NSNumber numberWithInt:groupImageCount],
                                           @"VideoCount":[NSNumber numberWithInt:groupVideoCount],
                                           @"PersisId":perID, @"url":url//,@"posterImg":[group posterImage]]
                                           };
                
                [arrGroups addObject:dicGroup];
                
                if([GroupLibrary_CoreData insertGroupLibraryToCoreData:dicGroup])
                {
                    [self setAssetInfo:group AlbumInfo:dicGroup];
                };
                
                
            };
            void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
                NSLog(@"assetGroupEnumberatorFailure Error!!");
            };
            
            // Enumerate Albums
            [assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                        usingBlock:assetGroupEnumerator
                                      failureBlock:assetGroupEnumberatorFailure];
            
        });
        
    }
    
}

- (void)setAssetInfo:(ALAssetsGroup *)group AlbumInfo:(NSDictionary *)dicInfo
{
    __block NSMutableArray *tmpAsset = [[NSMutableArray alloc] init];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
           [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop){
               //사진 한장씩 넣기
               if(asset == nil)
               {
               }
               else
               {
                   
               }
           }];
        
    });
}



@end
