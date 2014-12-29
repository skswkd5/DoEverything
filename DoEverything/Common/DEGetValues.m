//
//  DEGetValues.m
//  DoEverything
//
//  Created by 김지선 on 2014. 11. 27..
//  Copyright (c) 2014년 skswkd. All rights reserved.
//

#import "DEGetValues.h"

#import <sys/param.h>
#import <sys/mount.h>
#import <mach/mach.h>


#define MB (1024*1024)
#define GB (MB*1024)

@implementation DEGetValues

+ (float)disSpace
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    struct statfs tStats;
    statfs([[paths lastObject] cString], &tStats);
    float total_space = (float)(tStats.f_blocks * tStats.f_bsize);
    
    return total_space ;
}

+ (uint64_t)getFreeDiskSpace
{
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error:&error];
    
    if(dictionary)
    {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
        
        NSLog(@"Disk Capacity of %llu MiB with %llu Mib Free memory available.", ((totalSpace/1024ll)/1024ll), ((totalFreeSpace/1024ll)/1024ll));
        
    }
    else
    {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code= %ld", [error domain], (long)[error code])  ;
    }
    
    return totalFreeSpace;
}


+ (uint64_t)getSpaceForPhotos
{
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    
    NSError *error = nil;
    NSArray *paths0 = NSSearchPathForDirectoriesInDomains(NSPicturesDirectory, NSUserDomainMask, YES);
    NSArray *paths01 = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    NSArray *paths03 = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSArray *paths04 = NSSearchPathForDirectoriesInDomains(NSAutosavedInformationDirectory, NSUserDomainMask, YES);
    NSArray *paths05 = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSArray *paths06 = NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, YES);
    NSArray *paths07 = NSSearchPathForDirectoriesInDomains(NSMoviesDirectory, NSUserDomainMask, YES);
    NSArray *paths08 = NSSearchPathForDirectoriesInDomains(NSMusicDirectory, NSUserDomainMask, YES);
    NSArray *paths09 = NSSearchPathForDirectoriesInDomains(NSSharedPublicDirectory, NSUserDomainMask, YES);
    NSArray *paths010 = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES);
    NSArray *paths011 = NSSearchPathForDirectoriesInDomains(NSAllApplicationsDirectory, NSUserDomainMask, YES);
    NSArray *paths012 = NSSearchPathForDirectoriesInDomains(NSAllLibrariesDirectory, NSUserDomainMask, YES);
    NSArray *paths013 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSLog(@"paths0: %@", paths0);
    NSLog(@"paths01: %@", paths01);
    NSLog(@"paths03: %@", paths03);
    NSLog(@"paths04: %@", paths04);
    NSLog(@"paths05: %@", paths05);
    NSLog(@"paths06: %@", paths06);
    NSLog(@"paths07: %@", paths07);
    NSLog(@"paths08: %@", paths08);
    NSLog(@"paths09: %@", paths09);
    NSLog(@"paths010: %@", paths010);
    NSLog(@"paths011: %@", paths011);
    NSLog(@"paths012: %@", paths012);
    NSLog(@"paths013: %@", paths013);
    

    NSArray *paths11 = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSLocalDomainMask, YES);
    NSArray *paths12 = NSSearchPathForDirectoriesInDomains(NSUserDirectory, NSLocalDomainMask, YES);
    NSArray *paths13 = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSLocalDomainMask, YES);
    NSArray *paths15 = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSLocalDomainMask, YES);
    NSArray *paths110 = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSLocalDomainMask, YES);
    NSArray *paths111 = NSSearchPathForDirectoriesInDomains(NSAllApplicationsDirectory, NSLocalDomainMask, YES);
    NSArray *paths112 = NSSearchPathForDirectoriesInDomains(NSAllLibrariesDirectory, NSLocalDomainMask, YES);
    
    NSLog(@"paths11: %@", paths11);
    NSLog(@"paths12: %@", paths12);
    NSLog(@"paths13: %@", paths13);
    NSLog(@"paths15: %@", paths15);
    NSLog(@"paths110: %@", paths110);
    NSLog(@"paths111: %@", paths111);
    NSLog(@"paths112: %@", paths112);
    
    NSDictionary *dic0_0 = [[NSFileManager defaultManager] attributesOfItemAtPath:[paths0 lastObject] error:&error];
    NSArray *dic0_1 = [[NSFileManager defaultManager] componentsToDisplayForPath:[paths0 lastObject]];
    NSArray *dic0_2 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[paths0 lastObject] error:&error];
    NSArray *dic0_3 = [[NSFileManager defaultManager] subpathsAtPath:[paths0 lastObject]];
    
    NSLog(@"0-0 for paths0: %@", dic0_0 == nil? @"nil":dic0_0);
    NSLog(@"0-1 for paths0: %@", dic0_1 == nil? @"nil":dic0_1);
    NSLog(@"0-2 for paths0: %@", dic0_2 == nil? @"nil":dic0_2);
    NSLog(@"0-3 for paths0: %@", dic0_3 == nil? @"nil":dic0_3);
    
    NSDictionary *dic01_0 = [[NSFileManager defaultManager] attributesOfItemAtPath:[paths01 lastObject] error:&error];
    NSArray *dic01_1 = [[NSFileManager defaultManager] componentsToDisplayForPath:[paths01 lastObject]];
    NSArray *dic01_2 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[paths01 lastObject] error:&error];
    NSArray *dic01_3 = [[NSFileManager defaultManager] subpathsAtPath:[paths01 lastObject]];
    
    NSLog(@"1-0 for paths0: %@", dic01_0);
    NSLog(@"1-1 for paths0: %@", dic01_1);
    NSLog(@"1-2 for paths0: %@", dic01_2);
    NSLog(@"1-3 for paths0: %@", dic01_3);
    
    NSDictionary *dic02_0 = [[NSFileManager defaultManager] attributesOfItemAtPath:[paths03 lastObject] error:&error];
    NSArray *dic02_1 = [[NSFileManager defaultManager] componentsToDisplayForPath:[paths03 lastObject]];
    NSArray *dic02_2 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[paths03 lastObject] error:&error];
    NSArray *dic02_3 = [[NSFileManager defaultManager] subpathsAtPath:[paths03 lastObject]];

    
    NSLog(@"02-0 for paths0: %@", dic02_0);
    NSLog(@"02-1 for paths0: %@", dic02_1);
    NSLog(@"02-2 for paths0: %@", dic02_2);
    NSLog(@"02-3 for paths0: %@", dic02_3);
    
    
    NSDictionary *dic04_0 = [[NSFileManager defaultManager] attributesOfItemAtPath:[paths04 lastObject] error:&error];
    NSArray *dic04_1 = [[NSFileManager defaultManager] componentsToDisplayForPath:[paths04 lastObject]];
    NSArray *dic04_2 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[paths04 lastObject] error:&error];
    NSArray *dic04_3 = [[NSFileManager defaultManager] subpathsAtPath:[paths04 lastObject]];
    
    
    NSLog(@"04-0 for paths0: %@", dic04_0);
    NSLog(@"04-1 for paths0: %@", dic04_1);
    NSLog(@"04-2 for paths0: %@", dic04_2);
    NSLog(@"04-3 for paths0: %@", dic04_3);
    
    
    NSDictionary *dictionary01 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths01 lastObject] error:&error];
    NSDictionary *dictionary03 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths03 lastObject] error:&error];
    NSDictionary *dictionary04 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths04 lastObject] error:&error];
    NSDictionary *dictionary05 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths05 lastObject] error:&error];
    NSDictionary *dictionary06 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths06 lastObject] error:&error];
    NSDictionary *dictionary07 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths07 lastObject] error:&error];
    NSDictionary *dictionary08 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths08 lastObject] error:&error];
    NSDictionary *dictionary09 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths09 lastObject] error:&error];
    NSDictionary *dictionary010 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths010 lastObject] error:&error];
    NSDictionary *dictionary011 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths011 firstObject] error:&error];
    NSDictionary *dictionary012 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths012 lastObject] error:&error];
    NSDictionary *dictionary013 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths013 lastObject] error:&error];
    
    NSLog(@"dictionary01: %@", dictionary01 == nil? @"nil":dictionary01);
    NSLog(@"dictionary03: %@", dictionary03 == nil? @"nil":dictionary03);
    NSLog(@"dictionary04: %@", dictionary04 == nil? @"nil":dictionary04);
    NSLog(@"dictionary05: %@", dictionary05 == nil? @"nil":dictionary05);
    NSLog(@"dictionary06: %@", dictionary06 == nil? @"nil":dictionary06);
    NSLog(@"dictionary07: %@", dictionary07 == nil? @"nil":dictionary07);
    NSLog(@"dictionary08: %@", dictionary08 == nil? @"nil":dictionary08);
    NSLog(@"dictionary09: %@", dictionary09 == nil? @"nil":dictionary09);
    NSLog(@"dictionary010: %@", dictionary010 == nil? @"nil":dictionary010);
    NSLog(@"dictionary011: %@", dictionary011 == nil? @"nil":dictionary011);
    NSLog(@"dictionary012: %@", dictionary012 == nil? @"nil":dictionary012);
    NSLog(@"dictionary013: %@", dictionary013 == nil? @"nil":dictionary013);
    
    NSDictionary *dictionary11 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths11 lastObject] error:&error];
    NSDictionary *dictionary12 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths12 lastObject] error:&error];
    NSDictionary *dictionary13 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths13 lastObject] error:&error];
    NSDictionary *dictionary15 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths15 lastObject] error:&error];
    NSDictionary *dictionary110 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths110 lastObject] error:&error];
    NSDictionary *dictionary111 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths111 lastObject] error:&error];
    NSDictionary *dictionary112 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths112 firstObject] error:&error];
    NSDictionary *dictionary112_1 = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths112 lastObject] error:&error];
    
    NSLog(@"dictionary11: %@", dictionary11 == nil? @"nil":dictionary11);
    NSLog(@"dictionary12: %@", dictionary12 == nil? @"nil":dictionary12);
    NSLog(@"dictionary13: %@", dictionary13 == nil? @"nil":dictionary13);
    NSLog(@"dictionary15: %@", dictionary15 == nil? @"nil":dictionary15);
    NSLog(@"dictionary110: %@", dictionary110 == nil? @"nil":dictionary110);
    NSLog(@"dictionary111: %@", dictionary111 == nil? @"nil":dictionary111);
    NSLog(@"dictionary112: %@", dictionary112 == nil? @"nil":dictionary112);
    NSLog(@"dictionary112_1: %@", dictionary112 == nil? @"nil":dictionary112_1);
    
    if(dictionary11)
    {
        NSNumber *fileSystemSizeInBytes = [dictionary11 objectForKey:NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary11 objectForKey:NSFileSystemFreeSize];
        
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
        
        NSLog(@"dictionary11(/Applications) - systemSize: %@", [self memoryFormatter:totalSpace]);
        
    }
    else
    {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code= %ld", [error domain], (long)[error code])  ;
    }
    
    if(dictionary15)
    {
        NSNumber *fileSystemSizeInBytes = [dictionary15 objectForKey:NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary15 objectForKey:NSFileSystemFreeSize];
        
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
        
        NSLog(@"dictionary15(/Library/Application Support) - systemSize:  %@", [self memoryFormatter:totalSpace]);
        
    }
    else
    {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code= %ld", [error domain], (long)[error code])  ;
    }
    
    if(dictionary112)
    {
        NSNumber *fileSystemSizeInBytes = [dictionary112 objectForKey:NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary112 objectForKey:NSFileSystemFreeSize];
        
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
        
        NSLog(@"dictionary112(/Library) - systemSize:  %@", [self memoryFormatter:totalSpace]);
        
    }
    else
    {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code= %ld", [error domain], (long)[error code])  ;
    }
    
    if(dictionary112_1)
    {
        NSNumber *fileSystemSizeInBytes = [dictionary112_1 objectForKey:NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary112_1 objectForKey:NSFileSystemFreeSize];
        
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
        
        NSLog(@"dictionary112(/Developer) - systemSize:  %@", [self memoryFormatter:totalSpace]);
        
    }
    else
    {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code= %ld", [error domain], (long)[error code])  ;
    }

    
    
//    if(dictionary)
//    {
//        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemSize];
//        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
//        
//        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
//        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
//        
//        NSLog(@"Photos: Disk Capacity  of %llu MiB with %llu Mib Free memory available.", ((totalSpace/1024ll)/1024ll), ((totalFreeSpace/1024ll)/1024ll));
//        
//    }
//    else
//    {
//        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code= %ld", [error domain], (long)[error code])  ;
//    }

    
    return totalFreeSpace;
}


+ (uint64_t)getSpaceForVideos
{
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSMoviesDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error:&error];
    
    if(dictionary)
    {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
        
        NSLog(@"Movies: Disk Capacity  of %llu MiB with %llu Mib Free memory available.", ((totalSpace/1024ll)/1024ll), ((totalFreeSpace/1024ll)/1024ll));
        
    }
    else
    {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code= %ld", [error domain], (long)[error code])  ;
    }
    
    return totalFreeSpace;
}


#pragma mark - Formatter

+ (NSString *)memoryFormatter:(long long)diskSpace {
    NSString *formatted;
    double bytes = 1.0 * diskSpace;
    double megabytes = bytes / MB;
    double gigabytes = bytes / GB;
    if (gigabytes >= 1.0)
        formatted = [NSString stringWithFormat:@"%.2f GB", gigabytes];
    else if (megabytes >= 1.0)
        formatted = [NSString stringWithFormat:@"%.2f MB", megabytes];
    else
        formatted = [NSString stringWithFormat:@"%.2f bytes", bytes];
    
    return formatted;
}

#pragma mark - Methods

+ (long long)totalDiskSpace:(NSNumber *)size
{
    long long space = [size longLongValue];
    return space;
}

+ (long long)freeDiskSpace:(NSNumber *)size
{
    long long freeSpace = [size longLongValue];
    return freeSpace;
}

+ (NSNumber *)totalDiskSize {
    NSNumber *space = [[[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil] objectForKey:NSFileSystemSize];
    return space;
}

+ (NSNumber *)freeDiskSize {
    NSNumber *freeSpace = [[[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil] objectForKey:NSFileSystemFreeSize];
    return freeSpace;
}


//+ (CGFloat)totalDiskSpaceInBytes {
//    long long space = [[[[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil] objectForKey:NSFileSystemSize] longLongValue];
//    return space;
//}
//
//+ (CGFloat)freeDiskSpaceInBytes {
//    long long freeSpace = [[[[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil] objectForKey:NSFileSystemFreeSize] longLongValue];
//    return freeSpace;
//}
//
//+ (CGFloat)usedDiskSpaceInBytes {
//    long long usedSpace = [self totalDiskSpaceInBytes] - [self freeDiskSpaceInBytes];
//    return usedSpace;
//}



+ (void)displayFileInfoAtPath
{
//    NSArray *arrDictionary = @[NSApplicationDirectory,
//                               NSDemoApplicationDirectory,
//                               NSDeveloperApplicationDirectory,
//                               NSAdminApplicationDirectory,
//                               NSLibraryDirectory,
//                               NSDeveloperDirectory,
//                               NSUserDirectory,
//                               NSDocumentationDirectory,
//                               NSDocumentDirectory,
//                               NSCoreServiceDirectory,
//                               NSAutosavedInformationDirectory,
//                               NSDesktopDirectory,
//                               NSCachesDirectory,
//                               NSApplicationSupportDirectory,
//                               NSDownloadsDirectory,
//                               NSInputMethodsDirectory,
//                               NSMoviesDirectory,
//                               NSMusicDirectory,
//                               NSPicturesDirectory,
//                               NSPrinterDescriptionDirectory ,
//                               NSSharedPublicDirectory,
//                               NSPreferencePanesDirectory,
//                               NSApplicationScriptsDirectory,
//                               NSItemReplacementDirectory,
//                               NSAllApplicationsDirectory,
//                               NSAllLibrariesDirectory,
//                               NSTrashDirectory
//                               ];
    
}


+ (void)report_memory {
    
    static unsigned last_resident_size=0;
    static unsigned greatest = 0;
    static unsigned last_greatest = 0;
    
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(),
                                   TASK_BASIC_INFO,
                                   (task_info_t)&info,
                                   &size);
    if( kerr == KERN_SUCCESS ) {
        int diff = (int)info.resident_size - (int)last_resident_size;
        unsigned latest = info.resident_size;
        if( latest > greatest   )   greatest = latest;  // track greatest mem usage
        int greatest_diff = greatest - last_greatest;
        int latest_greatest_diff = latest - greatest;
        NSLog(@"Mem: %10lu (%10d) : %10d :   greatest: %10u (%d)", info.resident_size, diff,
              latest_greatest_diff,
              greatest, greatest_diff  );
    } else {
        NSLog(@"Error with task_info(): %s", mach_error_string(kerr));
    }
    last_resident_size = info.resident_size;
    last_greatest = greatest;
}




@end

