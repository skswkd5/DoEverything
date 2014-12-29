//
//  DEMultimediaInfo.m
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 15..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEMultimediaInfo.h"
#import "GroupLibrary_CoreData.h"
#import "Asset_CoreData.h"


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
                
                [group setAssetsFilter:[ALAssetsFilter allVideos]];
                int groupVideoCount = group.numberOfAssets;
                int groupImageCount = [total intValue] - groupVideoCount;
                
                videoCount += groupVideoCount;
                photoCount += groupImageCount;

                NSDictionary *dicGroup = @{@"groupName":groupPropertyName, @"type":Type,
                                           @"totalAsset":total,
                                           @"totalImage":[NSNumber numberWithInt:groupImageCount],
                                           @"totalVideo":[NSNumber numberWithInt:groupVideoCount],
                                           @"groupId":perID, @"url":url
                                           };
                NSLog(@"dicGroup: %@", dicGroup);
                [arrGroups addObject:dicGroup];
                
                [group setAssetsFilter:[ALAssetsFilter allAssets]];
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
    else
    {
        //이미 한번 구성 했다면 Update를 해준다.
    }
    
}

- (void)setAssetInfo:(ALAssetsGroup *)tmpGroup AlbumInfo:(NSDictionary *)dicInfo
{
    __block ALAssetsGroup *group = tmpGroup;
    __block long long totalSize = 0;
    __block long long totalIamge = 0;
    __block long long totalVideo = 0;
    
    [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop){
    
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
        //사진 한장씩 넣기
        if(asset == nil)
        {
            return;
        }
        else
        {
            NSURL *assetUrl = [asset valueForProperty:ALAssetPropertyAssetURL];
            NSDate *date = [asset valueForProperty:ALAssetPropertyDate];
            NSNumber *duration = [asset valueForProperty:ALAssetPropertyDuration];
            NSString *location = [asset valueForProperty:ALAssetPropertyLocation];
            NSNumber *orientation = [asset valueForProperty:ALAssetPropertyOrientation];
            NSString *type = [asset valueForProperty:ALAssetPropertyType];
            NSURL *url = [asset valueForProperty:ALAssetPropertyURLs];
            NSArray *urls = [asset valueForProperty:ALAssetPropertyURLs];
            
            NSLog(@" assetUrl: %@", assetUrl);
            NSLog(@" date: %@", date);
            NSLog(@" duration: %@", duration);
            NSLog(@" location: %@", location);
            NSLog(@" orientation: %@", orientation);
            NSLog(@" type: %@", type);
            NSLog(@" url: %@", url);
            NSLog(@" urls: %@", urls);
            
            [dic setObject:[dicInfo objectForKey:@"groupId"] forKey:@"groupId"];
            [dic setObject:assetUrl forKey:@"assetUrl"];
            [dic setObject:date forKey:@"date"];
            [dic setObject:[orientation stringValue] forKey:@"orientation"];
            [dic setObject:type forKey:@"type"];
            [dic setObject:url forKey:@"url"];
            
            ALAssetRepresentation *representation = [asset defaultRepresentation];

            NSString *uti = [representation UTI];
            CGSize dimensions = [representation dimensions];
            long long size = [representation size];
            
//            [dic setObject:[dimensions.width stringValue] forKey:@"width"];
//            [dic setObject:dimensions.height forKey:@"height"];

//            CGImage *fullImg = [representation fullResolutionImage];
//            CGImageRef *fullScreenImg = [representation fullScreenImage];
            
            NSURL *url2 = [representation url];
            NSDictionary *meta = [representation metadata];
            
            ALAssetOrientation orientation2 = [representation orientation];
            float scale = [representation scale];
            
            
            NSLog(@"  uti:%@", uti);
            NSLog(@"  size:%lld", size);
            NSLog(@"url2 :%@", url2);
            NSLog(@"meta  :%@", meta);
            NSLog(@"orientation2  :%ld", orientation2);
            NSLog(@"scale  :%f", scale);
            
            
            NSString *fileName = [representation filename];
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
            NSString *fullPath = [NSString stringWithFormat:@"%@/%@", path, fileName];
            
            NSLog(@"fileName  :%@", fileName);
            NSLog(@"path  :%@", path);
            NSLog(@"fullPath  :%@", fullPath);
            
            [dic setObject:fileName forKey:@"fileName"];
            [dic setObject:path forKey:@"path"];
            [dic setObject:fullPath forKey:@"fullPath"];
            
          
            if ([asset valueForProperty:ALAssetPropertyType] == ALAssetTypePhoto) {
                //이미지 일때
                UIImage *image = [UIImage imageWithCGImage:representation.fullScreenImage];
                NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(image, 1.0)];
                NSInteger imageSize = imageData.length/1024/1024;
                NSLog(@" imageSize: %ldMB", (long)imageSize);
                
                totalIamge += imageSize;
                
            }
            else if([asset valueForProperty:ALAssetPropertyType] == ALAssetTypeVideo)
            {
                //비디오 일때
                Byte *buffer = (Byte*)malloc(representation.size);
                NSUInteger buffered = [representation getBytes:buffer fromOffset:0.0 length:representation.size error:nil];
                NSLog(@"buffered: %lu", (unsigned long)buffered);
            
                NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
                NSInteger videoSize = data.length/1024/1024;
                NSLog(@" imageSize: %ldMB", (long)videoSize);
                
                totalVideo += videoSize;
            }
            else
            {
                //알려지지 않은.. ㅠ.ㅠ
            }
            
            //용량체크
            NSDictionary* fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:fullPath error:NULL];
            if (fileAttributes != nil)
            {
                NSString* fileSize = [fileAttributes objectForKey:NSFileSize];
                NSLog(@"fileSize -> %d", [fileSize intValue]);
            }
            
        }
        
    }];

}

//- (void)setAssetInfo:(ALAssetsGroup *)tmpGroup AlbumInfo:(NSDictionary *)dicInfo
//{
//    __block NSMutableArray *tmpAsset = [[NSMutableArray alloc] init];
//    __block ALAssetsGroup *group = tmpGroup;
//
//           [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop){
//               NSLog(@"Assets: %@", asset);
//               //사진 한장씩 넣기
//               if(asset == nil)
//               {
//                   return;
//               }
//               else
//               {
//                   NSURL *assetUrl = [asset valueForProperty:ALAssetPropertyAssetURL];
//                   NSDate *date = [asset valueForProperty:ALAssetPropertyDate];
//                   NSNumber *duration = [asset valueForProperty:ALAssetPropertyDuration];
//                   NSString *location = [asset valueForProperty:ALAssetPropertyLocation];
//                   NSNumber *orientation = [asset valueForProperty:ALAssetPropertyOrientation];
//                   NSString *type = [asset valueForProperty:ALAssetPropertyType];
//                   NSURL *url = [asset valueForProperty:ALAssetPropertyURLs];
//                   
//                   ALAssetRepresentation *representation = [asset valueForProperty:ALAssetPropertyRepresentations];
//                   NSString *uti = [representation UTI];
//                   CGSize dimensions = [representation dimensions];
//                   long long size = [representation size];
//                   
//                   CGImageRef *fullImg = [representation fullResolutionImage];
//                   CGImageRef *fullScreenImg = [representation fullScreenImage];
//                   
//                   NSURL *url2 = [representation url];
//                   NSDictionary *meta = [representation metadata];
//                   
//                   ALAssetOrientation orientation2 = [representation orientation];
//                   float scale = [representation scale];
//                   NSString *fileName = [representation filename];
//                   
////                   [Asset_CoreData insertAssetsToCoreData:dicInfo];
//                   
//               }
//           }];
//}



@end
