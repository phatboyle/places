//
//  ImageViewController.m
//  Places
//
//  Created by Boyle, Patrick on 10/13/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import "ImageViewController.h"
#import "FlickrFetcher.h"
#import "DiskCache.h"
#import "VacationHelper.h"
#import "Photo+Flickr.h"


@interface ImageViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIManagedDocument* vacationDatabase;
@end

@implementation ImageViewController
@synthesize scrollView;
@synthesize imageView;
@synthesize photoDict;
@synthesize vacationDatabase = _vacationDatabase;
@synthesize coreDataPhoto = _coreDataPhoto;


-(void)clearRecentList {
    // for testing only
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSMutableArray *photosList = [[settings arrayForKey:@"key.recentphotos"] mutableCopy];
    [photosList removeAllObjects];
    [settings setObject:photosList forKey:@"key.recentphotos"];
    [settings synchronize];
}

-(void)updateRecentList {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSMutableArray *photosList = [[settings arrayForKey:@"key.recentphotos"] mutableCopy];
    NSLog(@"getting NSUserDefaults photoList count %d", [photosList count]);
    
    if (!photosList) {
        photosList = [NSMutableArray array];
    }
    
    
    while ([photosList count] > 5) {
        [photosList removeLastObject];
    }
    
    if ([self photoDict] != nil){
        [photosList addObject:[self photoDict]];
        [settings setObject:photosList forKey:@"key.recentphotos"];
        [settings synchronize];
    }
    
}
-(void)updateCache: (NSData *) image{
    [DiskCache storeData:[photoDict objectForKey:@"id"]:image];
    
}
- (IBAction)visitPressed:(id)sender {
    self.vacationDatabase = [VacationHelper getActiveVacation];
    [self useDocument];
    [Photo photoWithFlickrInfo:photoDict inManagedObjectContext:self.vacationDatabase.managedObjectContext];
    NSLog(@"db: %@", self.vacationDatabase.managedObjectModel);

}
- (IBAction)deleteDbPressed:(id)sender {
    self.vacationDatabase = [VacationHelper getActiveVacation];
    [self useDocument];
    [self.vacationDatabase closeWithCompletionHandler:^(BOOL success){
       // add completion handler here
        NSLog(@"needs completion handler");
    }];
    [VacationHelper deleteActiveVacation];

}

-(void)useDocument
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.vacationDatabase.fileURL path]]){
        [self.vacationDatabase saveToURL:self.vacationDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
         
        }];
        
    } else if (self.vacationDatabase.documentState == UIDocumentStateClosed){
        [self.vacationDatabase openWithCompletionHandler:^(BOOL success){
        }];
        
        NSLog(@"useDocument: opened database");
        
        
    } else if (self.vacationDatabase.documentState == UIDocumentStateNormal){
        NSLog(@"useDocument: db state normal");
    }
}




-(void)setImage:(NSDictionary *)photoD withTitle:(NSString *)title
{
    self.photoDict=photoD;
    self.title = title;
}
-(void)setCoreDataImage:(Photo *)photo
{
    self.coreDataPhoto = photo;
}

-(void)loadPhoto
{
    NSString *title = @"Photo";
    NSString *photoID;
    NSData* image = nil;
    
    if (self.photoDict) {
        title = nil;
        photoID = [[self.photoDict objectForKey:FLICKR_PHOTO_ID] copy];
        image = [DiskCache fetchData:photoID];
        if (!image){
            image = [NSData dataWithContentsOfURL:[FlickrFetcher urlForPhoto:photoDict format:FlickrPhotoFormatLarge] ];
        }
    }
    if (self.coreDataPhoto) {
        title = nil;
        photoID = [self.coreDataPhoto.unique copy];
        image = [DiskCache fetchData:photoID];
        if(!image){
            image = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.coreDataPhoto.imageURL]];
        }
        
    }
    self.scrollView.delegate = self;
    self.imageView.image = [UIImage imageWithData:image];
    [self updateCache:image];   // understand this
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


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}





@end
