//
//  SearchViewController.m
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "SearchViewController.h"
#import "DetailViewController.h"
#import "Representative.h"
#import "RepresentativesController.h"

@interface SearchViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) NSString *searchString;
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

- (IBAction)searchButtonPressed:(id)sender {
    [[RepresentativesController sharedInstance] searchRepWithZip:self.searchTextField.text completion:^(BOOL success) {
        if (success) {
            self.reps = [RepresentativesController sharedInstance].repsArray;
            [self.tableView reloadData];
        } else {
            NSLog(@"error");
        }
    }];
}



#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [[segue destinationViewController] updateWithRepresentative:self.reps[indexPath.row]];
    }
}



@end
