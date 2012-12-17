//
//  MapViewController.h
//  Places
//
//  Created by Boyle, Patrick on 12/16/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol MapViewControllerDelegate <NSObject>
@end

@interface MapViewController : UIViewController

@property (nonatomic, strong) NSArray *annotations;  // of id <MKAnnotations>
@property (nonatomic, weak) id <MapViewControllerDelegate> delegate;

@end

