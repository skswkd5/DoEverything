//
//  ViewController.m
//  DoEverything
//
//  Created by 김지선 on 2014. 11. 27..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "ViewController.h"
#import "DEGetValues.h"
#import "DEGauge.h"
#import "DEDiskInfo.h"
#import "DEMGaugeView.h"
#import "DEMultimediaInfo.h"
#import "DEAlbumListViewController.h"


@interface ViewController ()

@property (nonatomic, strong) IBOutlet UIButton *btnAll;
@property (nonatomic, strong) IBOutlet UIButton *btnPhotos;
@property (nonatomic, strong) IBOutlet UIButton *btnVideos;
@property (nonatomic, strong) IBOutlet UIButton *btnLogs;
@property (nonatomic, strong) IBOutlet UIButton *btnSetting;

@property (nonatomic, strong) IBOutlet DEMGaugeView *myGauge;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1]];
    [self initializingData];
    
    [self setUIControllers];
    [self showMyGauge];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(displayMyGuageGraph)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


- (void)setUIControllers
{
    CGFloat screenWith = self.view.bounds.size.width;
    CGFloat screenHeight = self.view.bounds.size.height;
    
    self.myGauge.frame = CGRectMake(10, 10, 200, 100);
    
    CGFloat btnWidth = (screenWith - 40)/ 3;
    CGFloat btnHeight = 100;
    
    self.btnAll.frame = CGRectMake(10, self.myGauge.frame.origin.y + self.myGauge.frame.size.height + 10, btnWidth, btnHeight);
    self.btnPhotos.frame = CGRectMake(10 + btnWidth + 10, self.btnAll.frame.origin.y, btnWidth, btnHeight);
    self.btnVideos.frame = CGRectMake(10 + btnWidth + 10 + btnWidth + 10, self.btnAll.frame.origin.y, btnWidth, btnHeight);
    

    [self.btnAll setBackgroundImage:[[UIImage imageNamed:@"btn_tutorial_n"]
                                      resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateNormal];
    [self.btnPhotos setBackgroundImage:[[UIImage imageNamed:@"btn_tutorial_n"]
                                        resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateNormal];
    [self.btnVideos setBackgroundImage:[[UIImage imageNamed:@"btn_tutorial_n"]
                                        resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateNormal];
    
    [self.btnAll setBackgroundImage:[[UIImage imageNamed:@"btn_tutorial_p"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateHighlighted];
    [self.btnPhotos setBackgroundImage:[[UIImage imageNamed:@"btn_tutorial_p"]
                                        resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateHighlighted];
    [self.btnVideos setBackgroundImage:[[UIImage imageNamed:@"btn_tutorial_p"]
                                        resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateHighlighted];
    
    
    btnWidth = (screenWith - 30)/ 2;
    btnHeight = 100;
    
    self.btnLogs.frame = CGRectMake(10, self.btnAll.frame.origin.y + self.btnAll.frame.size.height + 10, btnWidth, btnHeight);
    self.btnSetting.frame = CGRectMake(10 + btnWidth + 10, self.btnLogs.frame.origin.y, btnWidth, btnHeight);
    
    [self.btnLogs setBackgroundImage:[[UIImage imageNamed:@"btn_red01_n"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateNormal];
    [self.btnSetting setBackgroundImage:[[UIImage imageNamed:@"btn_red01_n"]
                                        resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateNormal];
   
    [self.btnLogs setBackgroundImage:[[UIImage imageNamed:@"btn_red01_p"]
                                        resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateHighlighted];
    [self.btnSetting setBackgroundImage:[[UIImage imageNamed:@"btn_red01_p"]
                                        resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateHighlighted];

    if(self.mediaInfo.assetGroups.count > 0)
    {
        NSMutableString *strBtnTitle = [[NSMutableString alloc] initWithString:self.btnAll.titleLabel.text];
        NSString *detailedInfo = [NSString stringWithFormat:@"\n 앨범수: %d \n이미지수: %d \n동영상:%d",
                                  self.mediaInfo.assetGroups.count,
                                  [self.mediaInfo.numberOfAllPictures intValue],
                                  [self.mediaInfo.numberOfAllMovies intValue]];
        [strBtnTitle appendString:detailedInfo];
        NSLog(@"버튼 타이틀: %@", strBtnTitle);
        
        self.btnAll.titleLabel.text = strBtnTitle;
    }
    
    [self.view setNeedsDisplay];
    
}

#pragma mark Local Functions
- (void)showMyGauge
{
    UIColor *cForBackground = [UIColor colorWithRed:253/255.0 green:174/255.0 blue:56/255.0 alpha:1];
    UIColor *cForArc = [UIColor colorWithRed:243/255.0 green:115/255.0 blue:33/255.0 alpha:1];
    
    self.myGauge.backgroundColor = [UIColor clearColor];
    self.myGauge.backgroundArcFillColor = cForBackground;
    self.myGauge.backgroundArcStrokeColor = cForBackground;
    self.myGauge.fillArcFillColor =  cForArc;
    self.myGauge.fillArcStrokeColor = cForArc;
    self.myGauge.startAngle = 0;
    self.myGauge.endAngle = 180;
    self.myGauge.value = 0;
}

- (void)displayMyGuageGraph
{
    //Disk 정보
    float usedValue = [self.diskInfo.usedPercent floatValue];
    for (float i =0; i < usedValue; i++) {
        [self.myGauge setValue:i animated:YES];
    }
}

#pragma mark IBAction Functions




@end
