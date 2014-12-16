//
//  DEMultimediaInfo.h
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 15..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface DEMultimediaInfo : NSObject

@property (nonatomic, assign) NSArray *assetGroups;
@property (nonatomic, assign) NSNumber *numberOfAllPictures;
@property (nonatomic, assign) NSNumber *numberOfAllMovies;

- (void)setMultimediaInfo;

/**
 *  싱글톤 인스턴스
 *
 *  @return 앱인포 인스턴스
 */
//+ (DEMultimediaInfo *)sharedDEMultimediaInfo;

@end
