//
//  DEMultimediaInfo.m
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 15..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEMultimediaInfo.h"

@implementation DEMultimediaInfo

+ (void)getMultimediaInfo
{
    __block int videoCount = 0;
    __block int photoCount = 0;
    
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
        {
            if (group == nil) {
                // enumeration complete
                return;
            }

            NSString *groupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
            NSUInteger Type = [[group valueForProperty:ALAssetsGroupPropertyType] intValue];
            
            int total = group.numberOfAssets;
            [group setAssetsFilter:[ALAssetsFilter allVideos]];
            int groupVideoCount = group.numberOfAssets;
            
            videoCount += groupVideoCount;
            photoCount += total - groupVideoCount;
            
            NSLog(@"group: %@", group);
            NSLog(@"group PropertyName: %@ type: %d", groupPropertyName, Type);
            NSLog(@"groupVideoCount : %d", groupVideoCount);
            NSLog(@"groupPhotoCount : %d", total - groupVideoCount);
            
            NSLog(@"\ntotal videoCount = %d", videoCount);
            NSLog(@"total photoCount = %d", photoCount);
            
//            if (group == nil) {
//                   return;
//            }
//            
//           // added fix for camera albums order
//           NSString *sGroupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
//           NSUInteger nType = [[group valueForProperty:ALAssetsGroupPropertyType] intValue];
//           
//           if ([[sGroupPropertyName lowercaseString] isEqualToString:@"camera roll"] && nType == ALAssetsGroupSavedPhotos) {
//               [self.assetGroups insertObject:group atIndex:0];
//               //								   [self.assetGroups insertObject:group atIndex:0];// = group;
//               //self.assetGroup = group;//[self performSelectorOnMainThread:@selector(preparePhotos) withObject:nil waitUntilDone:YES];
//               // [self performSelectorInBackground:@selector(preparePhotos) withObject:nil];
//               [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
//           }
//           //							   else {
//           //								   [self.assetGroups addObject:group];
//           //							   }
//           
//           // Reload albums
//           //[self performSelectorOnMainThread:@selector(preparePhotos) withObject:nil waitUntilDone:YES];
//            
//           };
        };
        void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
        };
        
        // Enumerate Albums
        [assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                    usingBlock:assetGroupEnumerator
                                  failureBlock:assetGroupEnumberatorFailure];

        });
    

}

@end
