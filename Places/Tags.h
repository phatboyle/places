//
//  Tags.h
//  Places
//
//  Created by Pat Boyle on 12/25/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photos;

@interface Tags : NSManagedObject

@property (nonatomic, retain) NSString * tag;
@property (nonatomic, retain) NSSet *photos;
@end

@interface Tags (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Photos *)value;
- (void)removePhotosObject:(Photos *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

@end