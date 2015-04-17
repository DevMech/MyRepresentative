//
//  DetailViewController.m
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "DetailViewController.h"
#import "WebSiteViewController.h"
#import "MapViewViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *partylabel;
@property (weak, nonatomic) IBOutlet UILabel *districtLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)updateWithRepresentative: (Representative *)rep {
    self.rep = rep;
    [self configureView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)configureView {
    self.title = self.rep.name;
    self.nameLabel.text = self.rep.name;
    self.stateLabel.text = self.rep.state;
    self.partylabel.text = self.rep.party;
    if ([self.rep.party isEqualToString:@"R"]) {

    } else if ([self.rep.party isEqualToString:@"I"]){
        
    } else {
        
    }
    self.districtLabel.text = self.rep.district;
    self.addressLabel.text = self.rep.office;
    
}
- (IBAction)callButtonPressed:(id)sender {
    NSString *phoneNumber = [@"tel://" stringByAppendingString:self.rep.phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"site"]) {
        WebSiteViewController *webSiteViewController = [segue destinationViewController];
        [webSiteViewController updateWithRep:self.rep];
    }
    else if ([segue.identifier isEqualToString:@"map"]) {
        MapViewViewController *mapViewController = [segue destinationViewController];
        [mapViewController updateWithRep:self.rep];
    }
}



@end
