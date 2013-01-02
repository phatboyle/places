//
//  Photos+Flickr.h
//  Places
//
//  Created by Pat Boyle on 12/25/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import "Photo.h"

@interface Photo (Flickr)
+ (Photo *)photoWithFlickrInfo: (NSDictionary *)flickrInfo
        inManagedObjectContext:(NSManagedObjectContext *)context;

@end
