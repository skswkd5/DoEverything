//
//  DEAlbumTableViewController.m
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 18..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEAlbumTableViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "DEAlbumTableViewCell.h"

@interface DEAlbumTableViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tblAsset;
@property (nonatomic, strong) NSDictionary *selectedAlbum;
@property (nonatomic, strong) NSArray *assetsList;

@property (nonatomic) NSInteger cntImgInCell;
@end

@implementation DEAlbumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializing];
    [self showImages];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializing
{
    self.cntImgInCell = 4;
    
}

- (void)showImages
{
    if (self.assetsList.count == 0) {
        return;
    }
    for (int i=0; i <self.assetsList.count; i++) {
        CGFloat xOffset = 5.0f;
        CGFloat yOffset = 5.0f;
        
        CGFloat width = 71;
        CGFloat height = 71;
        
        int row = i /4;
        int column = i %4;
        
        CGRect imgFrame = CGRectMake(xOffset + ((width + xOffset) *column), yOffset + ((height + yOffset) * row), width, height);
        NSLog(@"index: %d UIImageView Frame: %@", i, NSStringFromCGRect(imgFrame));
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:imgFrame];
        ALAsset *tmpAsset = self.assetsList[i];
        imgView.image = [UIImage imageWithCGImage:tmpAsset.thumbnail];
        [self.view addSubview:imgView];
        
//        NSDateFormatter *dateFormatter = [NSDateFormatter new];
//        dateFormatter.dateFormat = @"y:MM:dd HH:mm:ss";
//        NSLog(@"MetaData: %@", [[tmpAsset defaultRepresentation] metadata]);
//        NSDate *date = [dateFormatter dateFromString:[[[[tmpAsset defaultRepresentation] metadata] objectForKey:@"{Exif}"] objectForKey:@"DateTimeOriginal"]];
//        NSLog(@"date: %@", date);

        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"y:MM:dd HH:mm:ss";
        NSDate *date = [tmpAsset valueForProperty:ALAssetPropertyDate];
        NSLog(@"date: %@", date);
        
    }
}

#pragma mark - Initialization
- (void)configureWithAlbumInfo:(NSDictionary *)selectedAlbum;
{
    _selectedAlbum = selectedAlbum;
    self.navigationItem.title = self.selectedAlbum[@"AlbumName"];
    [self performSelectorInBackground:@selector(fetchSelectedGroupAssts) withObject:nil];
}

- (void)fetchSelectedGroupAssts
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    NSMutableArray *tmpAsset = [[NSMutableArray alloc] init];
    
    NSString *albumName = self.selectedAlbum[@"AlbumName"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:^(ALAssetsGroup *group, BOOL *stop){
                               
                               if(group == nil)
                                   return;
                               
                               else{
                                   NSString *tmpGroup = [group valueForProperty:ALAssetsGroupPropertyName];
                                   if([albumName isEqualToString:tmpGroup])
                                   {
                                       [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop){
                                          //사진 한장씩 넣기
                                           if(asset == nil)
                                           {
                                               self.assetsList = [NSArray arrayWithArray:tmpAsset];
                                               NSLog(@"self.assetsList.count: %d", self.assetsList.count);
//                                               [self showImages];
                                               [self.tblAsset reloadData];
                                               return;
                                           }
                                           else
                                           {
                                               //사진 넣기
                                               [tmpAsset addObject:asset];
                                           }
                                       }];
                                   }
                               }
                           }
                         failureBlock:^(NSError *error){
                             NSLog(@"Error in load assets!!");
                         }];
    });
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //테이블 리로드
//        [self.tblAsset reloadData];
//        long section = [self numberOfSectionsInTableView:self.tableView] - 1;
//        long row = [self tableView:self.tableView numberOfRowsInSection:section] - 1;
//        if (section >= 0 && row >= 0) {
//            NSIndexPath *ip = [NSIndexPath indexPathForRow:row
//                                                 inSection:section];
//            [self.tableView scrollToRowAtIndexPath:ip
//                                  atScrollPosition:UITableViewScrollPositionBottom
//                                          animated:NO];
//        }
//        
//        [self.navigationItem setTitle:self.singleSelection ? @"Pick Photo" : @"Pick Photos"];
    });
    
    
}
#pragma mark - local Function
- (NSArray *)rangeOfAssetsForRow:(NSIndexPath*)path
{
    long index = path.row * 4;
    long length = MIN(4, (self.assetsList.count - index));
    
//    NSArray *arr = [self.assetsList subarrayWithRange:NSMakeRange(index, length)];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(int i = index; i<length; i++)
    {
        [arr addObject:self.assetsList[i]];
    }
    return arr;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.assetsList.count) {
        NSInteger count = [self.selectedAlbum[@"TotalCount"] integerValue];
        NSInteger row = ceil(count/self.cntImgInCell);
        if (row == 0) {
            row = 1;
        }
        return row;
    }
    else
        return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentifier = @"AlbumTableDetailCell";
    DEAlbumTableViewCell *cell = (DEAlbumTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[DEAlbumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    NSArray *assetsForRow = [self rangeOfAssetsForRow:indexPath];
    [cell setAssets:assetsForRow];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
