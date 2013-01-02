//
//  Photos.h
//  Places
//
//  Created by Pat Boyle on 12/25/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Places, Tags;

@interface Photos : NSManagedObject

@property (nonatomic, retain) NSString * unique;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSSet *hasTags;
@property (nonatomic, retain) Places *atPlace;
@end

@interface Photos (CoreDataGeneratedAccessors)

- (void)addHasTagsObject:(Tags *)value;
- (void)removeHasTagsObject:(Tags *)value;
- (void)addHasTags:(NSSet *)values;
- (void)removeHasTags:(NSSet *)values;

@end
