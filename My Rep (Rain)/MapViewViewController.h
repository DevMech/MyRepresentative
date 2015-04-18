//
//  MapViewViewController.h
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Representative.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewViewController : UIViewController

@property (strong, nonatomic) Representative *rep;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

-(void)updateWithRep:(Representative *)rep;

@end
