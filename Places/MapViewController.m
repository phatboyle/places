//
//  MapViewController.m
//  Places
//
//  Created by Boyle, Patrick on 12/16/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation MapViewController

@synthesize annotations = _annotations;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)updateMapView
{
    if (self.mapView.annotations){[self.mapView removeAnnotations:self.mapView.annotations];}
    if (self.annotations) {[self.mapView addAnnotations:self.annotations];}
}

- (void)setAnnotations:(NSArray*) annotations
{
    _annotations = annotations;
    [self updateMapView];
}
@end
