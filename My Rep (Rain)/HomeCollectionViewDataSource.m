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
    UIImage *iconImage = [self icons][indexPath.item];
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:iconImage];
    cell.icon = iconImageView;
    cell.searchTypeLabel.text = [self footerLabels][indexPath.row];

    return cell; 
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

-(NSArray *)icons {
    return @[[UIImage imageNamed:@"zipCode"], [UIImage imageNamed:@"states"], [UIImage imageNamed:@"hello"]];
}

-(NSArray *)footerLabels {
    return @[@"Zip Code", @"State", @"Last Name"];
}

@end
