//  NSString+USStateMap.m
//
//  Created by Norman Harebottle III on 3/14/13.
//  Copyright (c) 2013 Norman Harebottle III. All rights reserved.

#import "NSString+USStateMap.h"

@implementation NSString (USStateMap)

static NSDictionary *stateAbbreviationsMap = nil;
- (NSDictionary *)stateAbbreviationsMap 
{
    if (stateAbbreviationsMap == nil) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"USStateAbbreviations" ofType:@"plist"];
        stateAbbreviationsMap = [[NSDictionary alloc] initWithContentsOfFile:plist];
    }
    return stateAbbreviationsMap;
}

- (NSString *)stateAbbreviationFromFullName 
{
    return [self.stateAbbreviationsMap objectForKey:self.uppercaseString];
}

- (NSString *)stateFullNameFromAbbreviation
{
    NSString *upperAbbr = [self uppercaseString];
    
    __block NSString *fullName;
    [self.stateAbbreviationsMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if([upperAbbr isEqualToString:(NSString *)obj]) {
            fullName = (NSString *)key;
            *stop = YES;
        }
    }];
    return fullName;

}
@end
