//
//  MapViewViewController.m
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "MapViewViewController.h"
#import "MyAnnotation.h"

@interface MapViewViewController ()

@property (strong, nonatomic) NSArray *resultsArray;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (assign, nonatomic) CLLocationCoordinate2D officeLocation;

@end

@implementation MapViewViewController

-(void)updateWithRep:(Representative *)rep {
    self.rep = rep;
    [self performGeocode];
    
}
-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.rep.name;
}

-(void)performGeocode {
    NSString *addressString = self.rep.office;
    self.geocoder = [CLGeocoder new];
    [self.geocoder geocodeAddressString:addressString completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error) {
            self.resultsArray = placemarks;
            CLPlacemark *placeMark = self.resultsArray[0];
            self.officeLocation = placeMark.location.coordinate;
        [self setupMapView];
        }
        else {
            [self presentFailureAlert];
            return;
        }
    }];
}

-(void)setupMapView {
    MKCoordinateRegion region;
    region.center = self.officeLocation;
    float spanX = 0.008;
    float spanY = 0.008;
    region.span = MKCoordinateSpanMake(spanX, spanY);
    [self.mapView setRegion:region animated:YES];
    [self displayAnnotation];
}

-(void)displayAnnotation {
    MyAnnotation *annotation = [MyAnnotation new];

    annotation.coordinate = self.officeLocation;
    annotation.title = self.rep.name;
    annotation.subtitle = self.rep.office;
    [self.mapView addAnnotation:annotation];
}

-(void)presentFailureAlert {
    UIAlertController *failAlert = [UIAlertController alertControllerWithTitle:@"Address Not Found" message:@"Check your connection and try again" preferredStyle:UIAlertControllerStyleAlert];
    
    [failAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:failAlert animated:YES completion:nil];
}

@end
