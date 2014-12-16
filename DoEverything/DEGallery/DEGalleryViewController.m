//
//  DEGalleryViewController.m
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 15..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEGalleryViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface DEGalleryViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tblAlbums;
@property (nonatomic, strong) ALAssetsLibrary *assetLibrary;
@property (nonatomic, strong) NSMutableArray *assets;

@end

@implementation DEGalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self loadAssetLibrary];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadAssetLibrary
{
    //기기에 있는 앨범 정보를 읽어온다
    _assetLibrary = [[ALAssetsLibrary alloc] init];
    _assets = [[NSMutableArray alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
        NSMutableArray *assetURLDictionaries = [[NSMutableArray alloc] init];
        
        void(^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop){
          
            if(result != nil)
            {
                NSLog(@"result: %@", result);
                if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto])
                {
                    [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                    NSURL *url = result.defaultRepresentation.url;

                    [_assetLibrary assetForURL:url
                                   resultBlock:^(ALAsset *asset){
                                       
                                       NSLog(@"asset: %@", asset);
                                       
                                       if(asset)
                                       {
                                           [_assets addObject:asset];
                                           if(_assets.count == 1)
                                           {
                                               //Added first asset so reload data
//                                               [self.tblAlbums performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                               NSLog(@"####  테이블에 데이터 넣기");
                                           }
                                       }
                                       
                                   }
                                  failureBlock:^(NSError *error){
                                      NSLog(@"operation was not successfull!!");
                                  }
                     
                     ];
                }
            }
        };
        
        //Progress groups
        void(^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop){
          if(group != nil)
          {
              NSLog(@"group: %@", group);
              [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:assetEnumerator];
              [assetGroups addObject:group];
              NSLog(@"### assetGroups: %@", assetGroups);
          }
        };
        
        //Process!
        [self.assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                         usingBlock:assetGroupEnumerator
                                       failureBlock:^(NSError *error){
                                           NSLog(@"There is an error");
                                    }
         ];
        
    });
}


#pragma mark - UITableView


@end
