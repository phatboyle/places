//
//  VacationHelper.m
//  Places
//
//  Created by Pat Boyle on 1/4/13.
//  Copyright (c) 2013 Pat Boyle. All rights reserved.
//

#import "VacationHelper.h"

@interface VacationHelper ()
@property (nonatomic, strong) UIManagedDocument* vacationDatabase;
@end


@implementation VacationHelper
@synthesize  vacationDatabase = _vacationDatabase;

+(UIManagedDocument*)getActiveVacation{
    
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:@"myVacationDatabase"];
    return [[UIManagedDocument alloc] initWithFileURL:url];
    
}

+(void) deleteActiveVacation{
    NSError *error;
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:@"myVacationDatabase"];
    [[NSFileManager defaultManager] removeItemAtURL:url error:&error];
    if (error){
        NSLog(@"%@", error);
    }
    
}

/*
 -(void) createBasicVacation:(UIManagedDocument *) document
 {   // creates a basic vacation with the first 5 photos in the list. (should change this to a specific place)
 dispatch_queue_t fetchQ = dispatch_queue_create("flickr fetcher", NULL);
 dispatch_async(fetchQ, ^(void){
 NSArray* photos = [FlickrFetcher photosInPlace:    maxResults:50];
 [document.managedObjectContext performBlock:^{
 int i=0;
 for (NSDictionary *flickrInfo in photos) {
 NSLog(@"flickrFetched %@", flickrInfo);
 [Photo photoWithFlickrInfo:flickrInfo inManagedObjectContext:document.managedObjectContext];
 i++;
 if (i>5) break;
 }
 [document saveToURL:document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:NULL];
 NSLog(@"managed context %@", document.managedObjectContext);
 }];
 });
 dispatch_release(fetchQ);
 NSLog(@"exiting MyVacationsTableViewController: createBasicVacation");
 }
 */


@end
