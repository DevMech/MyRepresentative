//
//  Representative.m
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "Representative.h"

@implementation Representative

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.state = dictionary[@"state"];
        self.party = dictionary[@"party"];
        self.district = dictionary[@"district"];
        self.phoneNumber = dictionary[@"phone"];
        self.office = dictionary[@"office"];
        self.website = dictionary[@"link"];
    }
    return self;
}
@end