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
#import "Colors.h"
#import "NSString+USStateMap.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *partylabel;
@property (weak, nonatomic) IBOutlet UILabel *districtLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *officeButton;
@property (weak, nonatomic) IBOutlet UIButton *websiteButton;

@end

@implementation DetailViewController

-(void)updateWithRepresentative: (Representative *)rep {
    self.rep = rep;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

-(void)configureView {
    self.title = self.rep.name;
    self.nameLabel.text = self.rep.name;
    self.stateLabel.text = [self.rep.state stateFullNameFromAbbreviation];
    self.districtLabel.text = self.rep.district;
    self.addressLabel.text = self.rep.office;
    NSLog(@"Before: %@, After: %@", self.rep.state, [self.rep.state stateFullNameFromAbbreviation]);
    
    if ([self.rep.party isEqualToString:@"D"]) {
        self.partylabel.text = @"Democrat";
        [self changetoPartyColor:DemocratBlue];
        [self changeToDemocrat];
    } else if ([self.rep.party isEqualToString:@"R"]){
        self.partylabel.text = @"Republican";
    } else if ([self.rep.party isEqualToString:@"L"]) {
        self.partylabel.text = @"Libertarian";
        [self changetoPartyColor:LibYellow];
    } else if ([self.rep.party isEqualToString:@"I"]) {
        self.partylabel.text = @"Independent";
        [self changetoPartyColor:[UIColor purpleColor]];
    }
}

-(void)changetoPartyColor:(UIColor *)color {
    //Labels
    self.nameLabel.textColor = color;
    self.stateLabel.textColor = color;
    self.partylabel.textColor = color;
    self.districtLabel.textColor = color;
    self.addressLabel.textColor = color;
}

-(void)changeToDemocrat {
    
    //Buttons
    [self.callButton setImage:[UIImage imageNamed:@"callBlue.png"] forState:UIControlStateNormal];
    [self.officeButton setImage:[UIImage imageNamed:@"locationBlue.png"] forState:UIControlStateNormal];
    [self.websiteButton setImage:[UIImage imageNamed:@"siteBlue.png"] forState:UIControlStateNormal];
}

-(IBAction)callButtonPressed:(id)sender {
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:self.rep.phoneNumber];
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
