//
//  Representative.h
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Representative : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *party;
@property (strong, nonatomic) NSString *district;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *office;
@property (strong, nonatomic) NSString *website;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
