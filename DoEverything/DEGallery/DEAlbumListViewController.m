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


@interface DEAlbumListViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tblList;
@property (nonatomic, strong) NSArray *arrAlbums;
@property (nonatomic, strong) NSNumber *totalMedia;
@property (nonatomic, strong) NSNumber *totalPictures;
@property (nonatomic, strong) NSNumber *totalVideos;
@property (nonatomic, strong) NSArray *albumsFromCoreData;
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
            NSString *url = (NSString *)[group valueForProperty:ALAssetsGroupPropertyURL];
            NSString *persistentID = (NSString *)[group valueForProperty:ALAssetsGroupPropertyPersistentID];
            
            [group setAssetsFilter:[ALAssetsFilter allVideos]];
            int groupVideoCount = group.numberOfAssets;
            int groupImageCount = [total intValue] - groupVideoCount;
            
            videoCount += groupVideoCount;
            photoCount += groupImageCount;
            
            NSDictionary *dicGroup = @{@"AlbumName":groupPropertyName, @"Type":Type,
                                       @"Url":url, @"persistentId": persistentID,
                                       @"TotalCount":[NSNumber numberWithInt:groupImageCount],
                                       @"ImageCount":[NSNumber numberWithInt:groupImageCount],
                                       @"VideoCount":[NSNumber numberWithInt:groupVideoCount],
                                       @"Library":group};
            
            [self saveGroupPropertyToCoreData:dicGroup];
            [arrGroups addObject:dicGroup];
            
//            NSLog(@"group: %@", group);
//            NSLog(@"dicGroup: %@", dicGroup);
//            NSLog(@"arrGroups: %@", arrGroups);
            
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

- (void)setMediaDataFromCoreData
{
    // Fetch the devices from persistent data store
//    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"GroupLibrary"];
//    self.albumsFromCoreData = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMediaData];
    [self setMediaDataFromCoreData];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self performSegueWithIdentifier:@"AlbumDetailViewSegue" sender:[self.arrAlbums objectAtIndex:indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AlbumDetailViewSegue"])
    {
        NSIndexPath *path = [self.tblList indexPathForSelectedRow];
        NSDictionary *albumInfo = [self.arrAlbums objectAtIndex:path.row];
        
//        DEAlbumDetailViewController *albumVC = segue.destinationViewController;
        DEAlbumTableViewController *albumVC = segue.destinationViewController;
        [albumVC configureWithAlbumInfo:albumInfo];
    }
}

#pragma mark - CoreData
- (void)saveGroupPropertyToCoreData:(NSDictionary *)info
{
    NSDictionary *album = info;
    NSManagedObjectContext *context = [self managedObjectContext];
    
//    NSManagedObject *newAlbum = [NSEntityDescription insertNewObjectForEntityForName:@"GroupLibrary" inManagedObjectContext:context];
//    [newAlbum setValue:album[@"AlbumName"] forKey:@"name"];
//    [newAlbum setValue:album[@"TotalCount"] forKey:@"totalAsset"];
//    [newAlbum setValue:album[@"ImageCount"] forKey:@"totalImage"];
//    [newAlbum setValue:album[@"VideoCount"] forKey:@"totalVideo"];
//    [newAlbum setValue:album[@"Url"] forKey:@"url"];
//    [newAlbum setValue:album[@"Type"] forKey:@"type"];
//    [newAlbum setValue:album[@"persistentId"] forKey:@"persistentID"];
//    
//    NSError *error = nil;
//    // Save the object to persistent store
//    if (![context save:&error]) {
//        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//    }
    
    
//    if(ContactData == nil ||  [ContactData count] == 0){
//#ifdef _DEBUG_ONLY_
//        COLog(@"update_Contact ContactCount = %d",[ContactData count]);
//        return NO;
//#endif
//    }
//#ifdef _DEBUG_ONLY_
//    COLog(@"update_Contact ContactCount = %d",[ContactData count]);
//#endif
//    
//    if( IOS_VERSION_OVER_5 )
//    {
//        ChatOnClientAppDelegate *appDelegate = (ChatOnClientAppDelegate *)[[UIApplication sharedApplication] delegate];
//        
//        NSManagedObjectContext *context = [appDelegate newPrivateManagedObjectContext];
//        
//        __block NSError *error = nil;
//        
//        [context performBlock:^{
//            
//            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//            
//            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Contact" inManagedObjectContext:context];
//            
//            [fetchRequest setEntity:entity];
//            
//            NSSortDescriptor *sortDescriptor = nil;
//            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"originalNumber" ascending:YES];
//            NSArray *sortDescriptors = nil;
//            sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
//            [fetchRequest setSortDescriptors:sortDescriptors];
//            sortDescriptor = nil;
//            sortDescriptors = nil;
//            
//            for(int i=0;i<[ContactData count]; i++){
//                NSPredicate *predicate = nil;
//                NSString *attributeName = @"originalNumber";
//                NSString *attributeValue = [[ContactData objectAtIndex:i]objectForKey:CONTACTS_PHONE_NUMBER];
//                
//                predicate = [NSPredicate predicateWithFormat:@"%K like %@",attributeName,attributeValue];
//                
//                [fetchRequest setPredicate:predicate];
//                
//                [fetchRequest setResultType:NSManagedObjectIDResultType];
//                
//                NSArray * result = [context executeFetchRequest:fetchRequest error:&error];
//                
//                Contact *contact = nil;
//                
//                if([result count] > 0){
//                    contact = (Contact *)[context objectWithID:(NSManagedObjectID *)[result lastObject]];
//                }
//                else{
//                    contact = (Contact *)[NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:context];
//                    contact.originalNumber = [NSString stringWithString:[[ContactData objectAtIndex:i] objectForKey:CONTACTS_PHONE_NUMBER]];
//                    contact.uploadStatus = [NSNumber numberWithInt:1];
//                    contact.phoneNumber = [[[NSString stringWithString:[[ContactData objectAtIndex:i] objectForKey:CONTACTS_PHONE_NUMBER]] componentsSeparatedByCharactersInSet:
//                                            [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
//                    
//                }
//                contact.originalName = [[ContactData objectAtIndex:i] objectForKey:CONTACTS_DISPLAY_NAME];
//                contact.recodID = [NSNumber numberWithLong:[[[ContactData objectAtIndex:i]objectForKey:CONTACTS_PERSON_ID] intValue]];
//            }
//            
//            fetchRequest = nil;
//            
//            error = nil;
//            
//            [context save:&error];
//            
//            if(!error)
//            {
//                [appDelegate saveContext:CONTEXT_SAVE_MODULE_CONTACT_COREDATA saveMode:YES syncMode:NO];
//            }
//        }];
//        
//        return YES;
//    }
//    else
//    {
//        ChatOnClientAppDelegate *appDelegate = (ChatOnClientAppDelegate *)[[UIApplication sharedApplication] delegate];
//        NSManagedObjectContext *context = [appDelegate mainManagedObjectContext];
//        
//        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//        
//        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Contact" inManagedObjectContext:context];
//        
//        [fetchRequest setEntity:entity];
//        
//        NSSortDescriptor *sortDescriptor = nil;
//        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"originalNumber" ascending:YES];
//        NSArray *sortDescriptors = nil;
//        sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
//        [fetchRequest setSortDescriptors:sortDescriptors];
//        sortDescriptor = nil;
//        sortDescriptors = nil;
//        
//        
//        NSError *error = nil;
//        for(int i=0;i<[ContactData count]; i++){
//            NSPredicate *predicate = nil;
//            NSString *attributeName = @"originalNumber";
//            NSString *attributeValue = [[ContactData objectAtIndex:i]objectForKey:CONTACTS_PHONE_NUMBER];
//            
//            predicate = [NSPredicate predicateWithFormat:@"%K like %@",attributeName,attributeValue];
//            
//            [fetchRequest setPredicate:predicate];
//            
//            [fetchRequest setResultType:NSManagedObjectIDResultType];
//            
//            NSArray * result = [context executeFetchRequest:fetchRequest error:&error];
//            
//            Contact *contact = nil;
//            
//            if([result count] > 0){
//                contact = (Contact *)[context objectWithID:(NSManagedObjectID *)[result lastObject]];
//            }
//            else{
//                contact = (Contact *)[NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:context];
//                contact.originalNumber = [NSString stringWithString:[[ContactData objectAtIndex:i] objectForKey:CONTACTS_PHONE_NUMBER]];
//                contact.uploadStatus = [NSNumber numberWithInt:1];
//                contact.phoneNumber = [[[NSString stringWithString:[[ContactData objectAtIndex:i] objectForKey:CONTACTS_PHONE_NUMBER]] componentsSeparatedByCharactersInSet:
//                                        [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
//                
//            }
//            contact.originalName = [[ContactData objectAtIndex:i] objectForKey:CONTACTS_DISPLAY_NAME];
//            contact.recodID = [NSNumber numberWithLong:[[[ContactData objectAtIndex:i]objectForKey:CONTACTS_PERSON_ID] intValue]];
//        }
//        
//        
//        fetchRequest = nil;
//        [context save:&error];
//        
//        
//        
//        if( error ){
//#ifdef _DEBUG_ONLY_
//            COLog(@"update_Contact error : %@",[error localizedDescription]);
//#endif
//            return NO;
//        }
//        else{
//#ifdef _DEBUG_ONLY_
//            COLog(@"Endupdate_Contact");
//#endif
//            return YES;
//        }
//        return NO;
//    }
    
}
- (NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
