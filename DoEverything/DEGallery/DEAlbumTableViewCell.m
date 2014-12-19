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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
        [self addGestureRecognizer:tapRecognizer];
        
        NSMutableArray *tmpViewArray = [[NSMutableArray alloc] init];
        _imageViewArray = tmpViewArray;
        
        NSArray *tmpArray = [[NSArray alloc] init];
        _rowAssets = tmpArray;
        
    }
    
    return self;
}


- (void)layoutSubviews
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"_rowAssets.count:%d", _rowAssets.count);
    
    CGFloat startX = 10.0f;
    CGRect frame = CGRectMake(startX, 5, 71, 71);
    
    for (int i = 0; i < [_rowAssets count]; ++i) {
        
        UIView *cellView = [[UIView alloc] initWithFrame:frame];
        cellView.tag = i;
        cellView.backgroundColor = [UIColor magentaColor];
        [self.contentView addSubview:cellView];
        
        //Cell 이하 view
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cellView.frame.size.width, cellView.frame.size.height)];
        imageView.tag = 1000;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:cellView.frame];
        btn.backgroundColor = [UIColor clearColor];
        [cellView insertSubview:btn atIndex:0];
        
        ALAsset *asset = _rowAssets[i];
        imageView.image = [[UIImage alloc] initWithCGImage:asset.thumbnail];
        [cellView addSubview:imageView];
        
        UIImageView *checkImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
        checkImg.image = [UIImage imageNamed:@"checkmark"];
        checkImg.tag = 2000;
        [cellView addSubview:checkImg];
        
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
    NSLog(@"rowAssets.count:%d", self.rowAssets.count);
}


- (void)cellTapped:(UITapGestureRecognizer *)tapRecognizer
{
    CGPoint point = [tapRecognizer locationInView:self];
    
    CGFloat startX = 10.0f;
    CGRect frame = CGRectMake(startX, 5, 71, 71);

    for (int i = 0; i < [_rowAssets count]; ++i) {
        if (CGRectContainsPoint(frame, point)) {
            
            UIView *cellView = (UIView *)[self.contentView viewWithTag:i];
            
            UIImageView *checkImg = (UIImageView*)[cellView viewWithTag:2000];
            if (checkImg != nil) {
                BOOL iSelect = checkImg.hidden;
                checkImg.hidden = !iSelect;
            }
            break;
        }
        
        frame.origin.x = frame.origin.x + frame.size.width + 5;
    }
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
     NSLog(@"###(void)setSelected:(BOOL)selected animated:(BOOL)animated###");
}

@end
