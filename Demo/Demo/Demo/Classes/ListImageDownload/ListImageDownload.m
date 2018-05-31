//
//  ListImageDownload.m
//  Demo
//
//  Created by ThanhSon on 5/25/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "ListImageDownload.h"
#import "DowloadCollectionViewCell.h"
#import "DataDto.h"

@interface ListImageDownload ()

@end

@implementation ListImageDownload

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_objData) {
        [self.collectionView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self.collectionView reloadData];
}


#pragma mark <UICollectionViewDataSource>


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _objData.listData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DowloadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DowloadCollectionViewCell" forIndexPath:indexPath];
    DataDto *data = _objData.listData[indexPath.row];
    [cell updateStatus:data.downloadSession.statusDownload];
    [cell initUIWithData:data];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
