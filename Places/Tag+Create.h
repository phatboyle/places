//
//  Tags+Create.h
//  Places
//
//  Created by Pat Boyle on 12/25/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import "Tag.h"

@interface Tag (Create)

+ (NSSet*)tagsWithFlickrInfo:(NSString *) tag
        inManagedObjectContext:(NSManagedObjectContext *)context;

@end
