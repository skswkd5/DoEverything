//
//  DEAlbumDetailViewController.h
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 17..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DEBaseViewController.h"


@interface DEAlbumDetailViewController :DEBaseViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>



- (void)configureWithAlbumInfo:(NSDictionary *)selectedAlbum;

@end
