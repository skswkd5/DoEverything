//
//  DEAlbumDetailCollectionViewCell.m
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 17..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEAlbumDetailCollectionViewCell.h"

@interface DEAlbumDetailCollectionViewCell ()

@property (nonatomic, strong) IBOutlet UILabel *lblTest;

@end

@implementation DEAlbumDetailCollectionViewCell

- (void) setTextString:(NSString *)string
{
    if(_textString != string) {
        _textString = string;
    }
    
    self.lblTest.text = _textString;
}

@end
