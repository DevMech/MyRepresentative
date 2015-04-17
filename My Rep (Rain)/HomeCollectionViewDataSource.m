//
//  CollectionViewDataSource.m
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "HomeCollectionViewDataSource.h"
#import "HomeCollectionViewCell.h"

static NSString *cellID = @"cellID";

@implementation HomeCollectionViewDataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell *cell = (HomeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    UIImage *image = [UIImage imageNamed:[self icons][indexPath.row]];
    cell.icon.image = image;
    cell.searchTypeLabel.text = [self footerLabels][indexPath.row];

    return cell; 
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

-(NSArray *)icons {
    return @[@"zip.png", @"stateBlue.png", @"name.png", @"locationBlue.png"];
}

-(NSArray *)footerLabels {
    return @[@"Zip Code", @"State", @"Last Name", @"Current Location"];
}

@end
