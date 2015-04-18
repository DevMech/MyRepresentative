//
//  DetailViewController.h
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Representative.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Representative *rep;

- (void)updateWithRepresentative: (Representative *)rep;

@end

