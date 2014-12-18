//
//  DEAlbumTableViewCell.m
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 18..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEAlbumTableViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface DEAlbumTableViewCell()

@property (nonatomic, strong) NSArray *rowAssets;

@property (nonatomic, strong) NSMutableArray *imageViewArray;

@end


@implementation DEAlbumTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    NSLog(@"%s", __FUNCTION__);
    
    CGFloat startX = 10.0f;
    CGRect frame = CGRectMake(startX, 9, 71, 71);
    
    for (int i = 0; i < [_rowAssets count]; ++i) {
        UIImageView *imageView = [_imageViewArray objectAtIndex:i];
        imageView.backgroundColor = [UIColor magentaColor];
        [imageView setFrame:frame];
        [self.contentView addSubview:imageView];
        
//        UIImageView *overlayView = [_overlayViewArray objectAtIndex:i];
//        [overlayView setFrame:frame];
//        [self.contentView addSubview:overlayView];
        
//        UIView *maskView = [_maskViewArray objectAtIndex:i];
//        [maskView setFrame:CGRectMake(frame.origin.x-1, frame.origin.y-1, frame.size.width+2, frame.size.height+2)];
        
        frame.origin.x = frame.origin.x + frame.size.width + 5;
    }
    
}

- (void)setAssets:(NSArray *)assetList
{
    NSLog(@"%s", __FUNCTION__);
    
    self.rowAssets = assetList;
    for (UIImageView *view in _imageViewArray){
        [view removeFromSuperview];
    }

    for (int i=0; i < self.rowAssets.count; i++) {
        
        ALAsset *asset = [self.rowAssets objectAtIndex:i];
        if (i < self.imageViewArray.count) {
            //이미 만들어진 UIImageView 재활용하기
            UIImageView *imgView = [self.imageViewArray objectAtIndex:i];
            imgView.image = [UIImage imageWithCGImage:asset.thumbnail];
        }
        else{
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:asset.thumbnail]];
            [self.imageViewArray addObject:imgView];
        }
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
