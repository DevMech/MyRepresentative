//
//  WebSiteViewController.h
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Representative.h"

@interface WebSiteViewController : UIViewController

@property (strong, nonatomic) Representative *rep;

-(void)updateWithRep:(Representative *)rep;


@end
