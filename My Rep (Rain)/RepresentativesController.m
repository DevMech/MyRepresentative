//
//  RepresentativesController.m
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/7/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "RepresentativesController.h"
#import "Representative.h"

@implementation RepresentativesController

+ (RepresentativesController *)sharedInstance {
    static RepresentativesController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [RepresentativesController new];
        
    });
    return sharedInstance;
}

- (void)searchRepWithInfo:(NSString *)info searchType:(NSInteger)searchType completion:(void (^)(BOOL success))completion {
    NSURL *url;
    switch (searchType) {
        case 0:
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http:whoismyrepresentative.com/getall_mems.php?zip=%@&output=json", info]];
            break;
        case 1:
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://whoismyrepresentative.com/getall_reps_bystate.php?state=%@&output=json", info]];
            break;
        case 2:
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://whoismyrepresentative.com/getall_reps_byname.php?name=%@&output=json", info]];
            break;
    }
    NSError *error;
    NSArray *array = [[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:NSJSONReadingAllowFragments error:&error] objectForKey:@"results"];
    
    NSMutableArray *tempRepsList = [NSMutableArray new];
    
    for (NSDictionary *dictionary in array) {
        Representative *rep = [[Representative alloc] initWithDictionary:dictionary];
        [tempRepsList addObject:rep];
    }
    if (array) {
        self.repsArray = tempRepsList;
        completion(YES);
    }
}

@end
