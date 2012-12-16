//
//  MapViewController.h
//  Places
//
//  Created by Boyle, Patrick on 12/16/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController

@property (nonatomic, strong) NSArray *annotations;  // of id <MKAnnotations>

@end

