//
//  DetailViewController.m
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "DetailViewController.h"

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

- (void)configureView {
    self.nameLabel.text = self.rep.name;
    self.stateLabel.text = self.rep.state;
    self.partylabel.text = self.rep.party;
    if ([self.rep.party isEqualToString:@"R"]) {
        self.view.backgroundColor = [UIColor redColor];
    } else if ([self.rep.party isEqualToString:@"I"]){
        self.view.backgroundColor = [UIColor yellowColor];
    } else {
        self.view.backgroundColor = [UIColor blueColor];
    }
    self.districtLabel.text = self.rep.district;
    self.addressLabel.text = self.rep.office;
    
}
- (IBAction)callButtonPressed:(id)sender {
    NSString *phoneNumber = [@"tel://" stringByAppendingString:self.rep.phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
