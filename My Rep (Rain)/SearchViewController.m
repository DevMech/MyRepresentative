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
#import "NSString+USStateMap.h"

@interface SearchViewController () <UITableViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocation *userCurrentLocation;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) NSArray *reps;
@end

@implementation SearchViewController

-(void)updateWithSearchType:(Type)searchType {
    self.type = searchType;
    [RepresentativesController sharedInstance].repsArray = nil;
    if (self.type == TypeCurrentLocation) {
        [self determineUsersCurrentLocation];
    }
}

-(void)viewDidLoad {
    [super viewDidLoad];
    //Reset Tableview
    [RepresentativesController sharedInstance].repsArray = nil;
    [self.tableView reloadData];
    
    switch (self.type) {
        case TypeZip: {
            self.searchTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            break; }
        case TypeCurrentLocation:
            [self.searchTextField removeFromSuperview];
            break;
        default:
            break;
    }
    NSArray *typesArray = @[@"Search By Zip", @"Search By State", @"Search By Name", @"Current Location"];
    self.title = typesArray[self.type];

    NSArray *placeHolders = @[@"Zip", @"State", @"Name", @"Current Location"];
    self.searchTextField.placeholder = [NSString stringWithFormat:@"Enter %@", placeHolders[self.type]];
    [self.cancelButton setHidden:YES];
}

-(IBAction)cancelButtonPressed:(id)sender {
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
    [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations  {
    self.userCurrentLocation = [locations firstObject];
    [self.locationManager stopUpdatingLocation];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:self.userCurrentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSString *zipcode = [[NSString alloc]initWithString:placemark.postalCode];
            [self runApiSearchInBackgroundWithInfo:zipcode andType:TypeZip];
        } else {
            [self presentFailureAlert];
        }
    }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

-(void)runApiSearchInBackgroundWithInfo:(NSString *)info andType:(NSInteger)type {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        [[RepresentativesController sharedInstance] searchRepWithInfo:info searchType:type completion:^(BOOL success) {
            if (success) {
                self.reps = [RepresentativesController sharedInstance].repsArray;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            } else {
                [self presentFailureAlert];
            }
        }];
    });
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
        //Fixes lingering cells bug
        [RepresentativesController sharedInstance].repsArray = nil;
        [self.cancelButton setHidden:YES];
        
        //Hit API With TextField Text
        NSString *searchString = textField.text;
        
        //Account for full state name searches
        if (searchString.length > 2 && self.type == TypeState) {
            searchString = [textField.text stateAbbreviationFromFullName];
        }
        [self runApiSearchInBackgroundWithInfo:searchString andType:self.type];
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSCharacterSet *nonLetterSet = [[NSCharacterSet letterCharacterSet] invertedSet];
    NSUInteger newLength = [textField.text length] + [string length] - range.length;

    switch (self.type) {
        //Limit to valid Zip code
        case TypeZip: {
            if(newLength > 5 || [string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound){
                return NO;
            } else {
                return YES;
            }
            break; }
        //Limit to Letters only
        case TypeState:{
            if([string rangeOfCharacterFromSet:nonLetterSet].location != NSNotFound){
                return NO;
            } else {
                return YES;
            }
            break; }
        //Limit to Letters only
        case TypeName:{
            if([string rangeOfCharacterFromSet:nonLetterSet].location != NSNotFound){
                return NO;
            } else {
                return YES;
            }
            break; }
        default:
            return YES;
    }
}

-(void)presentFailureAlert {
    UIAlertController *failAlert = [UIAlertController alertControllerWithTitle:@"Search Unsuccessful" message:@"Check your search and try again" preferredStyle:UIAlertControllerStyleAlert];
    
    [failAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:failAlert animated:YES completion:nil];
}

#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [[segue destinationViewController] updateWithRepresentative:self.reps[indexPath.row]];
    }
}

@end
