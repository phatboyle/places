//
//  VacationImageViewController.m
//  Places
//
//  Created by Pat Boyle on 1/14/13.
//  Copyright (c) 2013 Pat Boyle. All rights reserved.
//

#import "VacationImageViewController.h"

@interface VacationImageViewController ()

@end

@implementation VacationImageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.delegate = self;
    NSData *image = [self getImageData];
    self.imageView.image = [UIImage imageWithData:image];
    [self updateCache:image];
    self.scrollView.contentSize = self.imageView.image.size;
    self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
    [self updateRecentList];
    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.maximumZoomScale = 2.0;
	float widthRatio = self.view.bounds.size.width / self.imageView.bounds.size.width;
    float heightRatio = self.view.bounds.size.height / self.imageView.bounds.size.height;
    NSLog(@"widthRatio, heightRatio is: %f, %f, %f", widthRatio, heightRatio, MAX(widthRatio, heightRatio));
    self.scrollView.zoomScale = MAX(widthRatio,heightRatio);
}

@end
