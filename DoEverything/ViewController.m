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
#import "DEMGaugeView.h"


@interface ViewController ()

@property (nonatomic, strong) IBOutlet UIButton *btnDisk;
@property (nonatomic, strong) IBOutlet UIButton *btnMemory;
@property (nonatomic, strong) IBOutlet UIButton *btnPhotos;
@property (nonatomic, strong) IBOutlet UIButton *btnVideos;

@property (nonatomic, strong) IBOutlet UILabel *lblTotal;
@property (nonatomic, strong) IBOutlet UILabel *lblUsed;

@property (nonatomic, strong) NSDictionary *spaceInfo;

@property (nonatomic, strong) DEMGaugeView *myGauge;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1]];
    
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
//    [self showGauge];
    [self showMyGauge];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showMyGauge
{
    UIColor *cForBackground = [UIColor colorWithRed:253/255.0 green:174/255.0 blue:56/255.0 alpha:1];
    UIColor *cForArc = [UIColor colorWithRed:243/255.0 green:115/255.0 blue:33/255.0 alpha:1];
    
    self.myGauge = [[DEMGaugeView alloc] initWithFrame:CGRectMake(10, 70, 150, 150)];
    self.myGauge.backgroundColor = [UIColor lightGrayColor];
    self.myGauge.backgroundArcFillColor = cForBackground;
    self.myGauge.backgroundArcStrokeColor = cForBackground;
    self.myGauge.fillArcFillColor =  cForArc;
    self.myGauge.fillArcStrokeColor = cForArc;
    self.myGauge.startAngle = 0;
    self.myGauge.endAngle = 180;
    self.myGauge.value = 10;
    [self.view addSubview:self.myGauge];
  
    
}

- (IBAction)showUsedDisk:(id)sender
{
    NSLog(@"######## 시작!!");
    
    [self.myGauge setValue:0 animated:YES];
    
    float free = [_spaceInfo[@"Free"] floatValue];// longLongValue];
    float total = [_spaceInfo[@"Total"] floatValue];
    
    float gagueValue = (total-free) / total *100;
    NSLog(@"###  gagueValue: %f", gagueValue);
    
    [self.myGauge setValue:gagueValue animated:YES];

}

- (void)ShowDiskStatus
{
    UIView *pieView = [[UIView alloc] initWithFrame:CGRectMake(10, 30, 150, 150)];
    [pieView setBackgroundColor:[UIColor colorWithRed:217/255 green:255 blue:255 alpha:1]];
    
}

- (void)showGauge
{
//    UIColor *cForBackground = [UIColor colorWithRed:253/255.0 green:111/255.0 blue:113/255.0 alpha:1];
//    UIColor *cForArc = [UIColor colorWithRed:192/255.0 green:68/255.0 blue:71/255.0 alpha:1];

    UIColor *cForBackground = [UIColor colorWithRed:253/255.0 green:174/255.0 blue:56/255.0 alpha:1];
    UIColor *cForArc = [UIColor colorWithRed:243/255.0 green:115/255.0 blue:33/255.0 alpha:1];
    
    DEGauge *bigGauge = [[DEGauge alloc] initWithFrame:CGRectMake(10, 70, 200, 120)];
    bigGauge.backgroundColor = [UIColor clearColor];
    bigGauge.backgroundArcFillColor = cForBackground;
    bigGauge.backgroundArcStrokeColor = cForBackground;
    bigGauge.fillArcFillColor =  cForArc;
    bigGauge.fillArcStrokeColor = cForArc;
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
