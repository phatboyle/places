//
//  Places.h
//  Places
//
//  Created by Pat Boyle on 12/25/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photos;

@interface Places : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *photo;
@end

@interface Places (CoreDataGeneratedAccessors)

- (void)addPhotoObject:(Photos *)value;
- (void)removePhotoObject:(Photos *)value;
- (void)addPhoto:(NSSet *)values;
- (void)removePhoto:(NSSet *)values;

@end
