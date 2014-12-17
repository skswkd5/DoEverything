//
//  DEBaseViewController.m
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 16..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEBaseViewController.h"


@interface DEBaseViewController ()


@end

@implementation DEBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [[UIScreen mainScreen] bounds];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark initialization
- (void)initializingData
{
    [self setDiskInfo];
    [self setMediaInfo];
}

- (void)setDiskInfo
{
    _diskInfo = [[DEDiskInfo alloc] init];
    
}

- (void)setMediaInfo
{
    _mediaInfo = [[DEMultimediaInfo alloc] init];
}

@end
