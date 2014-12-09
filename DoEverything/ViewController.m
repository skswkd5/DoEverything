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


@interface ViewController ()

@property (nonatomic, strong) IBOutlet UIButton *btnDisk;
@property (nonatomic, strong) IBOutlet UIButton *btnMemory;
@property (nonatomic, strong) IBOutlet UIButton *btnPhotos;
@property (nonatomic, strong) IBOutlet UIButton *btnVideos;

@property (nonatomic, strong) IBOutlet UILabel *lblTotal;
@property (nonatomic, strong) IBOutlet UILabel *lblUsed;

@property (nonatomic, strong) NSDictionary *spaceInfo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:255/255.0 green:240/255.0 blue:237/255.0 alpha:1]];
    
    float total = [DEGetValues disSpace];
    uint64_t total2 = [DEGetValues getFreeDiskSpace];
    
//    uint64_t totalPhotos = [DEGetValues getSpaceForPhotos];
//    uint64_t totalMovies = [DEGetValues getSpaceForVideos];
    long long totalSpace = [DEGetValues totalDiskSpace];
    long long freeSpace = [DEGetValues freeDiskSpace];
    
    NSString *totalWithUnit = [DEGetValues memoryFormatter:totalSpace];
    NSString *freeWithUnit = [DEGetValues memoryFormatter:freeSpace];
    
    _spaceInfo = @{@"Total": [NSNumber numberWithLongLong:totalSpace], @"Free":[NSNumber numberWithLongLong:freeSpace]
                   , @"TotalWithUnit": totalWithUnit, @"FreeWithUnit": freeWithUnit};
    
    NSLog(@"spaceInfo: %@", _spaceInfo);
    
//    [DEGetValues report_memory];
    [self showGauge];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)ShowDiskStatus
{
    UIView *pieView = [[UIView alloc] initWithFrame:CGRectMake(10, 30, 150, 150)];
    [pieView setBackgroundColor:[UIColor colorWithRed:217/255 green:255 blue:255 alpha:1]];
    
}

- (void)showGauge
{
    DEGauge *bigGauge = [[DEGauge alloc] initWithFrame:CGRectMake(10, 70, 200, 120)];
    bigGauge.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:217/255 green:236/255 blue:235/255 alpha:1];
    bigGauge.backgroundArcFillColor = [UIColor purpleColor];// [UIColor colorWithRed:243/255 green:239/255 blue:232/255 alpha:1];
    bigGauge.backgroundArcStrokeColor = [UIColor purpleColor];//[UIColor colorWithRed:243/255 green:239/255 blue:232/255 alpha:1];
    bigGauge.fillArcFillColor = [UIColor grayColor];//[UIColor colorWithRed:217/255 green:236/255 blue:235/255 alpha:1];
    bigGauge.fillArcStrokeColor = [UIColor grayColor];//[UIColor colorWithRed:217/255 green:236/255 blue:235/255 alpha:1];
    bigGauge.startAngle = 0;
    bigGauge.endAngle = 180;
    bigGauge.value = 0;
    [self.view addSubview:bigGauge];
    
    float free = [_spaceInfo[@"Free"] floatValue];// longLongValue];
    float total = [_spaceInfo[@"Total"] floatValue];
    
    float gagueValue = (total-free) / total *100;
    NSLog(@"###  gagueValue: %f", gagueValue);
    
    [bigGauge setValue:gagueValue animated:YES];
}



@end
