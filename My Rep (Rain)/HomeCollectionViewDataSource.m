//
//  CollectionViewDataSource.m
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "HomeCollectionViewDataSource.h"


static NSString *cellID = @"cellID";

@implementation HomeCollectionViewDataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Home *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    UIImage *itemImage = [self icons][indexPath.row];
    UIImageView *itemImageView = [[UIImageView alloc] initWithImage:itemImage];
    cell
    [cell.contentView addSubview:itemImageView];
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
