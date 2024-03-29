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
#import "Colors.h"

@implementation SearchTableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([RepresentativesController sharedInstance].repsArray.count == 0) {
        return 0;
    } else {
    return [RepresentativesController sharedInstance].repsArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *repsArray = [RepresentativesController sharedInstance].repsArray;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Representative *rep = repsArray[indexPath.row];
    
    //Set Cell Background color according to party
    if ([rep.party isEqualToString:@"R"]) {
        cell.backgroundColor = RepublicanRed;
    } else if ([rep.party isEqualToString:@"D"]) {
        cell.backgroundColor = DemocratBlue;
    } else if ([rep.party isEqualToString:@"L"]) {
        cell.backgroundColor = LibYellow;
    } else if ([rep.party isEqualToString:@"I"]) {
        cell.backgroundColor = [UIColor purpleColor];
    }
    cell.textLabel.text = rep.name;
    cell.detailTextLabel.text = [rep.state stringByAppendingString:[NSString stringWithFormat:@" - %@",rep.party]];
    return cell;
}
@end
