//
//  DEAlbumListViewController.m
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 16..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEAlbumListViewController.h"
#import "DEAlbumDetailViewController.h"


@interface DEAlbumListViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tblList;
@property (nonatomic, strong) NSArray *arrAlbums;
@property (nonatomic, strong) NSNumber *totalMedia;
@property (nonatomic, strong) NSNumber *totalPictures;
@property (nonatomic, strong) NSNumber *totalVideos;

@end

@implementation DEAlbumListViewController

- (void)setMediaData
{
//   _arrAlbums = self.mediaInfo.assetGroups;
//    [self.tblList reloadData];
    
    
    __block int videoCount = 0;
    __block int photoCount = 0;
    __block NSMutableArray *arrGroups = [[NSMutableArray alloc] init];
    
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
        {
            if (group == nil) {
                
                _totalVideos = [NSNumber numberWithInt:videoCount];
                _totalPictures = [NSNumber numberWithInt:photoCount];
                _arrAlbums = [NSArray arrayWithArray:arrGroups];
                [self.tblList reloadData];
                
                return;
            }
            
            NSString *groupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
            NSNumber *Type = [NSNumber numberWithInt:[[group valueForProperty:ALAssetsGroupPropertyType] intValue]];
            NSNumber *total = [NSNumber numberWithInt:group.numberOfAssets];
            
            
            [group setAssetsFilter:[ALAssetsFilter allVideos]];
            int groupVideoCount = group.numberOfAssets;
            int groupImageCount = [total intValue] - groupVideoCount;
            
            videoCount += groupVideoCount;
            photoCount += groupImageCount;
            
            NSDictionary *dicGroup = @{@"AlbumName":groupPropertyName, @"Type":Type,
                                       @"TotalCount":[NSNumber numberWithInt:groupImageCount],
                                       @"ImageCount":[NSNumber numberWithInt:groupImageCount],
                                       @"VideoCount":[NSNumber numberWithInt:groupVideoCount]};
            
            [arrGroups addObject:dicGroup];
            
            NSLog(@"group: %@", group);
            NSLog(@"dicGroup: %@", dicGroup);
            NSLog(@"arrGroups: %@", arrGroups);
            
        };
        void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
            NSLog(@"assetGroupEnumberatorFailure Error!!");
        };
        
        // Enumerate Albums
        [assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                    usingBlock:assetGroupEnumerator
                                  failureBlock:assetGroupEnumberatorFailure];
        
    });
    
}

- (void)viewDidLoad {
    [self setMediaData];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark -UITableView Delegate
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AlbumCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    DEAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
//        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
//        cell = [arr lastObject];
    }
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    NSDictionary *dicAlbumInfo = [self.arrAlbums objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%d)", dicAlbumInfo[@"AlbumName"], [dicAlbumInfo[@"TotalCount"] intValue]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"이미지: %d장   동영상:%d개", [dicAlbumInfo[@"ImageCount"] intValue], [dicAlbumInfo[@"VideoCount"] intValue]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrAlbums.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self performSegueWithIdentifier:@"AlbumDetailViewSegue" sender:[self.arrAlbums objectAtIndex:indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AlbumDetailViewSegue"])
    {
        NSIndexPath *path = [self.tblList indexPathForSelectedRow];
        NSDictionary *albumInfo = [self.arrAlbums objectAtIndex:path.row];
        
        DEAlbumDetailViewController *albumVC = segue.destinationViewController;
        albumVC.selectedAlbum = albumInfo;
    }
}

@end
