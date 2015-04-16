//
//  RepresentativesController.h
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/7/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepresentativesController : NSObject

@property (strong, nonatomic) NSArray *repsArray;

+ (RepresentativesController *)sharedInstance;
- (void)searchRepWithZip:(NSString *)zip completion:(void (^)(BOOL success))completion;

@end
