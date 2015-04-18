//
//  AppearanceController.m
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "AppearanceController.h"
#import "Colors.h"

@implementation AppearanceController

+(void)setupAppearance {
    //Navigation Bars
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setOpaque:YES];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:22], NSFontAttributeName, nil]];
    
    //Navigation Bar Items
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:16]} forState:UIControlStateNormal];
}
@end
