//
//  Photo.h
//  Places
//
//  Created by Pat Boyle on 12/25/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Place, Tag;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * unique;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSSet *hasTags;
@property (nonatomic, retain) Place *atPlace;
@end

@interface Photo (CoreDataGeneratedAccessors)

- (void)addHasTagsObject:(Tag *)value;
- (void)removeHasTagsObject:(Tag *)value;
- (void)addHasTags:(NSSet *)values;
- (void)removeHasTags:(NSSet *)values;

@end
