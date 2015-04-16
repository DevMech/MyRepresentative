//
//  SearchTableViewDataSource.m
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "SearchTableViewDataSource.h"

@implementation SearchTableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Representative *rep = self.reps[indexPath.row];
    cell.textLabel.text = rep.name;
    cell.detailTextLabel.text = [rep.state stringByAppendingString:[NSString stringWithFormat:@" - %@",rep.party]];
    return cell;
}
@end
