//
//  DiskCache.m
//  Places
//
//  Created by Boyle, Patrick on 10/19/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import "DiskCache.h"

// check dir:  ~/library/application support/iphone simulator


@implementation DiskCache

static NSURL *cacheURL;

+ (NSFileManager*) filemanager {
    NSFileManager* fm = [[NSFileManager alloc] init];
    return fm;
}


+(NSURL *) cachesUrl {
    if (!cacheURL){
        NSArray * cachesArray = [[self filemanager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
        cacheURL = [cachesArray lastObject];
    }
    return cacheURL;
}

+ (NSURL *) getUrlForFile: (NSString *) filename {
    return [NSURL URLWithString:filename relativeToURL:[self cachesUrl]];
}



+(void) storeData: (NSString *) key: (NSData *) data {
    //TODO: if the file is already there then don't write anything
    [self trimCache];
    NSLog(@"%@",[[self getUrlForFile:key]absoluteString]);
    if (![[self filemanager] fileExistsAtPath:[[self getUrlForFile:key] absoluteString] ]){
        [data writeToURL:[self getUrlForFile:key] atomically:YES];
    }
}

+(void) trimCache
{
    // update to just keep the last 5 pictures
    NSArray* URLsCacheArray = [[self filemanager] contentsOfDirectoryAtURL:[self cachesUrl] includingPropertiesForKeys:[NSArray arrayWithObjects:NSURLNameKey, NSURLIsDirectoryKey, NSURLCreationDateKey, NSFileSize, nil] options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    
    if ([URLsCacheArray count]  > 5) {
        [URLsCacheArray sortedArrayUsingComparator:^(id item1, id item2) {
            NSDate* d1 = [[[self filemanager] attributesOfItemAtPath:[item1 path] error:nil] valueForKey:NSFileCreationDate];
            NSDate* d2 = [[[self filemanager] attributesOfItemAtPath:[item2 path] error:nil] valueForKey:NSFileCreationDate];
            
            return [d2 compare:d1];
            
        }];
    }
        // now we have a sorted array
        
    NSMutableArray* URLsArray = [NSMutableArray arrayWithArray:URLsCacheArray];
        
    NSLog(@"found %d files in cache", [URLsArray count]);
    //NSLog(@"list of urls: %@", URLsArray);

    NSURL* url = [URLsArray lastObject];
    NSError* error=nil;
    NSDictionary* fileAttributes= [[self filemanager] attributesOfItemAtPath:url.path error:&error];
    NSLog(@"%@", fileAttributes);
            
    if (error)
    {
       NSLog(@"%@", error);
    }
            
            
    if ([fileAttributes valueForKey:url.path] == NSFileTypeRegular){
        NSError* error=nil;
        [[self filemanager] removeItemAtURL:url error:&error];
        if (error){
            NSLog(@"%@", error);    // this needs to be made safer
        } else {
        [URLsArray removeLastObject];
        }
    }
}
    
    
    



+(NSData *) fetchData:(NSString *)key{
    return [NSData dataWithContentsOfURL:[self getUrlForFile:key]];
    
}

@end
