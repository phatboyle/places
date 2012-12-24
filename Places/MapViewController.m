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
@synthesize mapView = _mapView;
@synthesize delegate = _delegate;

-(void)setMapView:(MKMapView *)mapView
{
    _mapView = mapView;
    [self updateMapView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
