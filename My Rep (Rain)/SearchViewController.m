//
//  SearchViewController.m
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "SearchViewController.h"
#import "HomeViewController.h"
#import "DetailViewController.h"
#import "Representative.h"
#import "RepresentativesController.h"

@interface SearchViewController () <UITableViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocation *userCurrentLocation;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic) NSArray *reps;
@end

@implementation SearchViewController

-(void)updateWithSearchType:(Type)searchType {
    self.type = searchType;
    self.reps = nil;
    [self.tableView reloadData];
    if (self.type == TypeCurrentLocation) {
        [self determineUsersCurrentLocation];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *typesArray = @[@"Search By Zip", @"Search By State", @"Search By Name", @"Current Location"];
    self.title = typesArray[self.type];
    self.searchTextField.placeholder = [NSString stringWithFormat:@"Enter %@", typesArray[self.type]];
    [self.cancelButton setHidden:YES];
    [self.tableView reloadData];
}

- (IBAction)cancelButtonPressed:(id)sender {
    self.searchTextField.text = @"";
    [self.searchTextField resignFirstResponder];
    [self.cancelButton setHidden:YES];
}

#pragma mark - CLLocation

-(void)determineUsersCurrentLocation {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 200;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations  {
    self.userCurrentLocation = [locations firstObject];
    [self.locationManager stopUpdatingLocation];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:self.userCurrentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
//          NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
            NSString *zipcode = [[NSString alloc]initWithString:placemark.postalCode];
            
//          Hit API with zip from current location
            [[RepresentativesController sharedInstance] searchRepWithInfo:zipcode searchType:TypeZip completion:^(BOOL success) {
                if (success) {
                    self.reps = [RepresentativesController sharedInstance].repsArray;
                    [self.tableView reloadData];
                } else {
                    NSLog(@"error");
                }
            }];
        } else {
            NSLog(@"Geocode failed with error %@", error); // Error handling must required
        }
    }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", &error);
}

#pragma mark TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TextField Delegate 

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.cancelButton setHidden:NO];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    //Return if no text
    if ([textField.text isEqualToString:@""]) {
        [textField resignFirstResponder];
        [self.cancelButton setHidden:YES];
        return YES;
    } else {
        [self.cancelButton setHidden:YES];
        
        //Hit API With TextField Text
        [[RepresentativesController sharedInstance] searchRepWithInfo:self.searchTextField.text searchType:self.type completion:^(BOOL success) {
            if (success) {
                self.reps = [RepresentativesController sharedInstance].repsArray;
                [self.tableView reloadData];
            } else {
                NSLog(@"error");
            }
        }];
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
}

-(void)presentFailureAlert {
    UIAlertController *failAlert = [UIAlertController alertControllerWithTitle:@"Search Unsuccessful" message:@"Check your search and try again" preferredStyle:UIAlertControllerStyleAlert];
    
    [failAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:failAlert animated:YES completion:nil];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [[segue destinationViewController] updateWithRepresentative:self.reps[indexPath.row]];
    }
}



@end
