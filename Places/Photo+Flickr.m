//
//  Photo+Flickr.m
//  Places
//
//  Created by Pat Boyle on 12/25/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import "Photo+Flickr.h"
#import "FlickrFetcher.h"
#import "Tag+Create.h"
#import "Place+Create.h"

// insert Photo into the db
// itiniary queries for places
// tags queries for tags with # of Photo in each tag
// query for places (which gives virtual vacation)
// pick a place and get list of Photo

@implementation Photo (Flickr)
+ (Photo *)photoWithFlickrInfo:(NSDictionary *)flickrInfo
        inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSLog(@"%@", [flickrInfo description]);
    Photo *photo = nil;
    // get a list of all photos in the db that have the id of the photo we want to insert
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    // where unique = photoid
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", [flickrInfo objectForKey:FLICKR_PHOTO_ID ]];
    // create sort descriptor to sort results
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSError *error = nil;
    // result set
    NSArray *matches = [context executeFetchRequest:request error:&error];
    if (!matches || [matches count] > 1){
        NSLog(@"error - found multiple matches, or matches was nil");
    } else if ([matches count] == 0){
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo"
                                              inManagedObjectContext:context];
        photo.unique = [flickrInfo objectForKey:FLICKR_PHOTO_ID];
        photo.title = [flickrInfo objectForKey:FLICKR_PHOTO_TITLE];
        photo.subtitle = [flickrInfo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
        photo.imageURL = [[FlickrFetcher urlForPhoto:flickrInfo format:FlickrPhotoFormatLarge] absoluteString];
        photo.tags = [Tag tagsWithFlickrInfo:[flickrInfo objectForKey:FLICKR_TAGS] inManagedObjectContext:context];
        //NSLog(@"%@",[[FlickrFetcher photosInPlace:flickrInfo maxResults:5] description]);
        photo.place = [Place placeFromPhoto:[flickrInfo objectForKey:FLICKR_PHOTO_PLACE_NAME] inManagedObjectContext:context];
        //NSLog(@"%@", [[flickrInfo objectForKey:FLICKR_PHOTO_PLACE_NAME] description]);
        
        //NSLog(@"%@", [photo.place description]);
    } else {
        photo = [matches lastObject];
    }
    return photo;
}

@end
