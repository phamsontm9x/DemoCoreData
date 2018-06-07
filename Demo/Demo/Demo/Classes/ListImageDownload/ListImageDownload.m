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
#import "DataCore+CoreDataClass.h"
#import "CoreDataManager.h"
@import MagicalRecord;



@interface ListImageDownload () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchResultsController;
@property (nonatomic, strong) NSMutableArray *arrData;

@end



@implementation ListImageDownload

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self.collectionView reloadData];
}


#pragma mark - NSFetchedResultsController

- (void)loadData {
    self.fetchResultsController = [DataCore fetchAllDownloadImageWithGroupID:_objData.groupId AndDelegate:self inContext:[NSManagedObjectContext MR_defaultContext]];
    
    if ([self.fetchResultsController.fetchedObjects count] > 0) {
        NSArray *arr = self.fetchResultsController.fetchedObjects;
        _arrData = [[NSMutableArray alloc] initWithArray:arr];
    } else {
        _arrData = [[NSMutableArray alloc] init];
    }
    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DowloadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DowloadCollectionViewCell" forIndexPath:indexPath];
   
    DataCore *dataCore = _arrData[indexPath.row];
    
    if (_objData.listData.count > indexPath.row) {
        [cell initUIWithData:_objData.listData[indexPath.row]];
    }
    [cell updateStatus:dataCore.status];
    [cell setImageWithData:[dataCore dataImage]];

    return cell;
}


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DataCore *dataCore = _arrData[indexPath.row];
    if (![dataCore dataImage]) {
        
    }
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    NSArray *arr = self.fetchResultsController.fetchedObjects;
    _arrData = [[NSMutableArray alloc] initWithArray:arr];
    [self.collectionView reloadData];
}


@end
