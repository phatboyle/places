//
//  ImageViewController.h
//  Places
//
//  Created by Boyle, Patrick on 10/13/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo+Flickr.h"

@interface ImageViewController : UIViewController

@property (nonatomic, strong) NSDictionary *photoDict;
@property (nonatomic, strong) Photo *coreDataPhoto;
-(void)setImage:(NSDictionary *)photoD withTitle:(NSString *)title;
-(void)setCoreDataImage:(Photo *) photo;


@end
