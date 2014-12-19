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
@property (nonatomic, strong) NSMutableArray *assetList;

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
    self.assetList = [[NSMutableArray alloc] init];
    
}

- (void)showImages
{
    if (self.assetList.count == 0) {
        return;
    }
    for (int i=0; i <self.assetList.count; i++) {
        CGFloat xOffset = 5.0f;
        CGFloat yOffset = 5.0f;
        
        CGFloat width = 71;
        CGFloat height = 71;
        
        int row = i /self.cntImgInCell;
        int column = i %self.cntImgInCell;
        
        CGRect imgFrame = CGRectMake(xOffset + ((width + xOffset) *column), yOffset + ((height + yOffset) * row), width, height);
//        NSLog(@"index: %d UIImageView Frame: %@", i, NSStringFromCGRect(imgFrame));
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:imgFrame];
        ALAsset *tmpAsset = self.assetList[i];
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
    __block NSMutableArray *tmpAsset = [[NSMutableArray alloc] init];
    
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
//                                               self.assetList = [NSArray arrayWithArray:tmpAsset];
                                               NSLog(@"self.assetsList.count: %d", self.assetList.count);
                                               NSLog(@"assetsLis: %@", self.assetList);
//                                               [self showImages];
                                               [self assetTableReload:tmpAsset];
                                               NSLog(@"assetsLis: %@", self.assetList);
                                               return;
                                           }
                                           else
                                           {
                                               //사진 넣기
                                               [tmpAsset addObject:asset];
                                               [self.assetList addObject:asset];
                                           }
                                       }];
                                       
                                       return;
                                   }
                               }
                           }
                         failureBlock:^(NSError *error){
                             NSLog(@"Error in load assets!!");
                         }];
    });

}


#pragma mark - local Function
- (NSArray *)rangeOfAssetsForRow:(NSIndexPath*)path
{
    long index = path.row * self.cntImgInCell;
    long length = MIN(self.cntImgInCell, (self.assetList.count - index));

    
//    NSArray *arr = [[NSArray alloc] initWithArray:[self.assetsList subarrayWithRange:NSMakeRange(index, length)]];
//    NSLog(@"arr: %@", arr);
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(int i = index; i < index + length; i++)
    {
        NSLog(@"self.assetsList: %@", self.assetList[i]);

        ALAsset *asset = self.assetList[i];
        NSLog(@"asset: %@", asset);
        [arr addObject:asset];
    }
    NSLog(@"arr: %@", arr);
    return arr;
}

#pragma mark - Table view data source
- (void)assetTableReload:(NSArray *)tmpAsset
{
    NSLog(@"%s", __FUNCTION__);
     NSLog(@"tmpAsset: %@", tmpAsset);
//    self.assetList = tmpAsset;
     NSLog(@"assetsLis: %@", self.assetList);
    [self.tblAsset reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 81;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.assetList.count) {
        NSInteger count = [self.selectedAlbum[@"TotalCount"] integerValue];
        NSInteger row = count/self.cntImgInCell;
        
        if (count % self.cntImgInCell > 0) {
            row += 1;
        }
        NSLog(@"row: %d", row)  ;
        return row;
    }
    else
        return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%s", __FUNCTION__);
    
    static NSString *cellIndentifier = @"AlbumTableDetailCell";
    DEAlbumTableViewCell *cell = (DEAlbumTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[DEAlbumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    NSArray *assetsForRow = [self rangeOfAssetsForRow:indexPath];
    NSLog(@"indexPath.row: %d assetsForRow:%@", indexPath.row, assetsForRow);
    [cell setAssets:assetsForRow];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    NSLog(@"didSelectRowAtIndexPath: %d", indexPath.row);
//    
//}


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
