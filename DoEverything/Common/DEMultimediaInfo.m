//
//  DEMultimediaInfo.m
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 15..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEMultimediaInfo.h"
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
    __block NSMutableArray *arrGroups = [[NSMutableArray alloc] init];
    
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
            NSNumber *total = [NSNumber numberWithInt:group.numberOfAssets];
            
            
            [group setAssetsFilter:[ALAssetsFilter allVideos]];
            int groupVideoCount = group.numberOfAssets;
            int groupImageCount = [total intValue] - groupVideoCount;
            
            videoCount += groupVideoCount;
            photoCount += groupImageCount;
            
            NSDictionary *dicGroup = @{@"AlbumName":groupPropertyName, @"Type":Type,
                                              @"TotalCount":[NSNumber numberWithInt:groupImageCount],
                                              @"ImageCount":[NSNumber numberWithInt:groupImageCount],
                                              @"VideoCount":[NSNumber numberWithInt:groupVideoCount]};
            
            [arrGroups addObject:dicGroup];
            
            NSLog(@"group: %@", group);
            NSLog(@"dicGroup: %@", dicGroup);
            NSLog(@"arrGroups: %@", arrGroups);
            
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


@end
