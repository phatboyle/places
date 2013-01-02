//
//  Tag+Create.m
//  Places
//
//  Created by Pat Boyle on 12/25/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import "Tag+Create.h"
#import "Photo.h"
#import "FlickrFetcher.h"


@implementation Tag (Create)
+ (NSSet*)tagsWithFlickrInfo:(NSString *)flickrInfo
    inManagedObjectContext:(NSManagedObjectContext *)context
{
    //NSString* test =[flickrInfo objectForKey:@"FLICKR_TAGS"] ;
    NSArray* tagList = [flickrInfo componentsSeparatedByString:@" "];
    
    if (![tagList count]) return nil;
    Tag *tag = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSRange range;
    NSMutableSet* tags = [NSMutableSet setWithCapacity:[tagList count]];
    NSError *error = nil;
    NSArray* tagsArray = nil;

    for (NSString* tagName in tags){
        tag = nil;
        if (!tagName || [tagName isEqualToString:@""]) continue;
        range = [tagName rangeOfString:@":"];
        if (range.location != NSNotFound) continue;
        error = nil;
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", tag];
        tagsArray = [context executeFetchRequest:request error:&error];
        if (!tagsArray || ([tagsArray count] > 1) || error) {
            NSLog(@"error in tagsWithFlickrInfo %@", error);
        } else if (![tagsArray count]) {
            tag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:context];
            tag.name = tagName;
        }
        else {
            tag = [tagsArray lastObject];
            
        }
        if (tag) [tags addObject:tag];
       }
    return tags;
    
}

@end
