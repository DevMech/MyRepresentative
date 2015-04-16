//
//  SearchTableViewDataSource.m
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "SearchTableViewDataSource.h"
#import "Representative.h"
#import "RepresentativesController.h"

@implementation SearchTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([RepresentativesController sharedInstance].repsArray.count == 0) {
        return 0;
    } else {
    return [RepresentativesController sharedInstance].repsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *repsArray = [RepresentativesController sharedInstance].repsArray;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Representative *rep = repsArray[indexPath.row];
    cell.textLabel.text = rep.name;
    cell.detailTextLabel.text = [rep.state stringByAppendingString:[NSString stringWithFormat:@" - %@",rep.party]];
    return cell;
}
@end
