//
//  DEAlbumListViewController.m
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 16..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEAlbumListViewController.h"
#import "DEAlbumDetailViewController.h"
#import "DEAlbumTableViewController.h"

#import "GroupLibrary.h"
#import "GroupLibrary_CoreData.h"


@interface DEAlbumListViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tblList;
@property (nonatomic, strong) NSArray *arrAlbums;
@property (nonatomic, strong) NSNumber *totalMedia;
@property (nonatomic, strong) NSNumber *totalPictures;
@property (nonatomic, strong) NSNumber *totalVideos;
@property (nonatomic, strong) NSArray *albumsFromCoreData;
@end

@implementation DEAlbumListViewController

- (void)setMediaDataFromCoreData
{
    self.arrAlbums = [GroupLibrary_CoreData selectAllGroupLibrary];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMediaDataFromCoreData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    GroupLibrary *dicAlbumInfo = (GroupLibrary*)[self.arrAlbums objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%d)", dicAlbumInfo.name, [dicAlbumInfo.totalAsset intValue]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"이미지: %d장   동영상:%d개", [dicAlbumInfo.totalImage intValue], [dicAlbumInfo.totalVideo intValue]];
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AlbumDetailViewSegue"])
    {
        NSIndexPath *path = [self.tblList indexPathForSelectedRow];
        GroupLibrary *selected = [self.arrAlbums objectAtIndex:path.row];

        DEAlbumDetailViewController *albumVC = segue.destinationViewController;
//        DEAlbumTableViewController *albumVC = segue.destinationViewController;
        [albumVC configureWithAlbumInfo:selected];
    }
}


@end
