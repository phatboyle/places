//
//  Places+Create.m
//  Places
//
//  Created by Pat Boyle on 12/25/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import "Place+Create.h"

@implementation Place (Create)
+(Place*) placeFromPhoto:(NSString *)placeName inManagedObjectContext:(NSManagedObjectContext *)context
{
    Place* place = nil;
    NSFetchRequest *request  = [NSFetchRequest fetchRequestWithEntityName:@"Place"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", place];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSError* error=Nil;
    NSArray* matches = [context executeFetchRequest:request error:&error];
    if (!matches || [matches count]> 1){
        NSLog(@"error in placeFromPhoto %@", error);
    } else if ([matches count ]==0){
        place = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:context];
        place.name = placeName;
    } else {
        place = [matches lastObject];
    }
    return place;

}

@end
