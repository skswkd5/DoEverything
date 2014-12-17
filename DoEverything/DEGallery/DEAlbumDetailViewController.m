//
//  DEAlbumDetailViewController.m
//  DoEverything
//
//  Created by 김지선 on 2014. 12. 17..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEAlbumDetailViewController.h"
#import "DEAlbumDetailCollectionViewCell.h"

@interface DEAlbumDetailViewController ()

@property (nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrData;

@end

@implementation DEAlbumDetailViewController

//TSAssetsViewController 참조할것!!!
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.selectedAlbum[@"TotalCount"] intValue])
    {
        self.arrData = [[NSMutableArray alloc] init];
        int count = [self.selectedAlbum[@"TotalCount"] intValue];
        for (int i=0; i < count; i ++ )
        {
            NSString *text = [NSString stringWithFormat:@"-%d-", i];
            [self.arrData addObject:text];
        }
    }
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"AlbumCollectionCell"];
    self.collectionView.allowsMultipleSelection = YES;
    
    [self setViewControllers];
    
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



- (void)setViewControllers
{
    //컨트롤들 정리하기
//    [self.collectionView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(5.f, 5.f, 5.f, 1.f);
    layout.minimumLineSpacing = 10.0f;
    layout.minimumInteritemSpacing = 10.0f;
    layout.itemSize = CGSizeMake(70.0f, 70.0f);
    
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];

    
}


#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.selectedAlbum[@"TotalCount"] integerValue];
//    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return [self.selectedAlbum[@"TotalCount"] integerValue];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumCollectionCell" forIndexPath:indexPath];
    DEAlbumDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumCollectionCell" forIndexPath:indexPath];
    
    int iColor = indexPath.row %2;
    
    switch (iColor) {
        case 0:
            cell.backgroundColor = [UIColor magentaColor];
            break;
            
        case 1:
            cell.backgroundColor = [UIColor lightGrayColor];
            break;
            
        default:
            cell.backgroundColor = [UIColor clearColor];
            break;
    }
    NSString *tmp = self.arrData[indexPath.row];
//    cell.textString = tmp;
//    [cell setTextString:self.arrData[indexPath.row]];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.selectedBackgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    
    return cell;
}

/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Deselect item
}


#pragma mark – UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
////    NSString *searchTerm = self.searches[indexPath.section];
////    FlickrPhoto *photo = self.searchResults[searchTerm][indexPath.row];
//    
//    CGSize cellSize = CGSizeMake(100, 100);
//    return cellSize;
//}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(1, 1, 1, 1);
//}

@end
