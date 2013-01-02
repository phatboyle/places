//
//  Places+Create.h
//  Places
//
//  Created by Pat Boyle on 12/25/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import "Place.h"

@interface Place (Create)
+ (Place*) placeFromPhoto:(NSString*) place inManagedObjectContext: (NSManagedObjectContext*) context;

@end
