//
//  DEAlbumTableViewCell.h
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 18..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DEAlbumTableViewCell;

@protocol DEAlbumTableCellDelegate <NSObject>

@end


@interface DEAlbumTableViewCell : UITableViewCell

@property (nonatomic, readonly, getter = isCellSelected) BOOL cellSelected;

@property (nonatomic, weak) id<DEAlbumTableCellDelegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setAssets:(NSArray *)assetList;
- (void)markAsSelected:(BOOL)selected;
    
@end
