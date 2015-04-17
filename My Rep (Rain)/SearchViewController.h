//
//  SearchViewController.h
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM (NSInteger, Type) {
    TypeZip,
    TypeState,
    TypeName,
    TypeCurrentLocation
};

@interface SearchViewController : UIViewController

@property (assign, nonatomic) Type type;

-(void)updateWithSearchType:(Type)searchType;

@end

