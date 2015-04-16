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

@interface SearchViewController () <UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) NSArray *reps;
@end

@implementation SearchViewController

-(void)updateWithSearchType:(Type)searchType {
    self.type = searchType;
    switch (searchType) {
        case TypeZip:
            [self.searchButton setTitle: @"Search Zip" forState:UIControlStateNormal];
            break;
        case TypeState:
            [self.searchButton setTitle: @"Search State" forState:UIControlStateNormal];
            break;
        case TypeName:
            [self.searchButton setTitle: @"Search Name" forState:UIControlStateNormal];
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - TextField Delegate 

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        [textField resignFirstResponder];
        return YES;
    } else {
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
