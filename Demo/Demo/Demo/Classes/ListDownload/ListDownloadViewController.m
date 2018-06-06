//
//  ListDownloadViewController.m
//  Demo
//
//  Created by Son Pham on 5/24/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "ListDownloadViewController.h"
#import "DataDto.h"
#import "Download_Manager.h"
#import "DownloadTableViewCell.h"
#import "ObjectDto.h"
#import "ListImageDownload.h"
#import "AppDelegate.h"
#import "DataCore+CoreDataClass.h"
#import "CoreDataManager.h"
#import "GroupDataCore+CoreDataClass.h"
#import "DataCore+CoreDataClass.h"

@import MagicalRecord;


typedef NS_ENUM(NSInteger, StatusDownload) {
    StatusDefault = 0,
    StatusDownloadQueue,
    StatusDownLoading,
    StatusDownloadfinish,
};



@interface ListDownloadViewController () <UITableViewDelegate, UITableViewDataSource, DownloadTableViewCellDelegate, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *progressTotal;
@property (nonatomic, strong) IBOutlet UITableView* tbvContent;
@property (nonatomic, strong) NSFetchedResultsController* fetchResultsController;

@property (nonatomic, strong) NSMutableArray *arrDownload;
@property (nonatomic, strong) NSMutableArray *arrObj;
@property (nonatomic, strong) NSMutableArray *arrObjQueue;
@property (nonatomic, strong) NSMutableArray *arrObjDownloading;
@property (nonatomic, assign) NSInteger maxCurentDownLoad;
@property (nonatomic, assign) BOOL isStart;

@end



@implementation ListDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self loadData];
}

- (void)initData {
    _isStart = YES;
    _maxCurentDownLoad = 1;
    _arrDownload = [[NSMutableArray alloc] init];
    _arrObjQueue = [[NSMutableArray alloc] init];
    _arrObjDownloading = [[NSMutableArray alloc] init];
    _arrObj = [[NSMutableArray alloc] init];
}

- (void)loadData {
    
    _fetchResultsController = [GroupDataCore fetchAllGroupAndDelegate:self inContext:[NSManagedObjectContext MR_defaultContext]];
    
    if (_fetchResultsController.fetchedObjects.count > 0) {
        [self loadDataFromCoreData];
    } else {
        [self createDataObjectCoreData];
        [self loadDataFromCoreData];
    }
    
    [_tbvContent reloadData];
}

- (void)loadDataFromCoreData {
    for (int i = 0 ; i < _fetchResultsController.fetchedObjects.count ; i++) {
        _arrDownload = [[NSMutableArray alloc] init];
        GroupDataCore *group = [GroupDataCore findGroupWithID:i inContext:[NSManagedObjectContext MR_defaultContext]];
        ObjectDto *obj = [[ObjectDto alloc] initObjectDtoWithName:group.name groupId:group.gid andStatus:group.status];
        
        for (int j =0 ; j < group.downloadDataCore.count; j++) {
            NSString * url = @"http://1.bp.blogspot.com/-mRJKdjhDCpM/VyibnmXS_2I/AAAAAAAOGrI/8ykMQB8f1W0/s0/bt3551-hiep-khach-giang-ho-truyentranhtuan-com-chap-500-trang-000.png";
            DataCore *dataCore = group.downloadDataCore[j];
            DataDto *data = [[DataDto alloc] initDataDtoWith:url FileName:dataCore.fileName cid:dataCore.cid GroupId:dataCore.groupId andStatus:dataCore.status];
            [_arrDownload addObject:data];
        }
        
        obj.listData = _arrDownload;
        [obj configProgress];
        [_arrObj addObject:obj];
    }
}

- (void)createDataObjectCoreData {
    
    for (int i = 0 ; i< 3 ; i ++) {

        // Create GroupData
        GroupDataCore *group = [GroupDataCore findGroupWithID:i inContext:[NSManagedObjectContext MR_defaultContext]];
        if (!group) {
            group = [GroupDataCore MR_createEntity];
            group.status  = StatusDefault;
            group.name = [NSString stringWithFormat:@"group%d",i];
            group.gid = i;
        }
        
        for (int j = 0; j < 10; j++) {
            
            //Create DataCore
            NSString *strFileName = [NSString stringWithFormat:@"test%d",i*1000+j];
            if (![DataCore isHasDataCoreWithName:strFileName inContext:[NSManagedObjectContext MR_defaultContext]]) {
                DataCore * dataCore = [DataCore MR_createEntity];
                dataCore.cid = j;
                dataCore.fileName = strFileName;
                dataCore.status = StatusDefault;
                dataCore.groupId = i;
                [group addDownloadDataCoreObject:dataCore];
                //[group insertObject:dataCore inDownloadDataCoreAtIndex:j];
            }
        }
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pauseSelected:(id)sender {
    [[Download_Manager sharedDownManager] pause];
}

- (IBAction)startSelected:(id)sender {
    if (_isStart) {
        [self preDownLoad];
    } else {
        [[Download_Manager sharedDownManager] resume];
    }
    _isStart = NO;
}

- (void)preDownLoad {
    
    for (int i = 0 ; i < _maxCurentDownLoad ; i ++ ) {
        for (int j = 0 ; j < _arrObj.count ; j++ ) {
            ObjectDto *dto = _arrObj[j];
            if (dto.statusDownload != StatusDownloadfinish) {
                dto.statusDownload = StatusDownLoading;
                [_arrObjDownloading addObject:dto];
                break;
            }
        }
    }
    
    
    for (int i = 0 ; i < _arrObj.count ; i++) {
        ObjectDto *dto = _arrObj[i];
        if (dto.statusDownload == StatusDefault) {
            dto.statusDownload = StatusDownloadQueue;
            [_arrObjQueue addObject:dto];
        }
    }
    
    for (ObjectDto *dto in _arrObjDownloading) {
        for (DataDto *data in dto.listData) {
            [[Download_Manager sharedDownManager] addEventDownload:data];
        }
    }
    
    [_tbvContent reloadData];

}


#pragma mark - UITableviewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrObj.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DownloadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DownloadTableViewCell"];
    ObjectDto *data = _arrObj[indexPath.row];
    [cell updateStatus:data.statusDownload];
    cell.lblName.text = data.groupName;
    [cell initUIWithData:data];
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListImageDownload *vc = [storyboard instantiateViewControllerWithIdentifier:@"ListImageDownload"];
    if (_arrObj.count > 0 ) {
        vc.objData = _arrObj[indexPath.row];
    }

    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - TableViewCellDelegate

- (void)updateStatus:(ObjectDto *)obj {
    for (ObjectDto *dto in _arrObj) {
        if (dto.groupId == obj.groupId ) {
            dto.statusDownload = obj.statusDownload;
            [self updateObject:dto withStatus:dto.statusDownload];
        }
    }
    if (obj.statusDownload == StatusDownloadfinish) {
        [_arrObjDownloading removeObject:obj];
        if (_arrObjQueue.count > 0) {
            [_arrObjDownloading addObject:_arrObjQueue.firstObject];
            [_arrObjQueue removeObjectAtIndex:0];
        }
        if (_arrObjDownloading.count > 0) {
            for (ObjectDto *dto in _arrObjDownloading) {
                for (DataDto *data in dto.listData) {
                    [[Download_Manager sharedDownManager] addEventDownload:data];
                }
                dto.statusDownload = StatusDownLoading;
                [self updateObject:dto withStatus:dto.statusDownload];
            }
        }
    }
    [_tbvContent reloadData];
}

- (void)updateObject:(ObjectDto *)obj withStatus:(NSInteger)status {
    GroupDataCore *groupData = [GroupDataCore findGroupWithID:obj.groupId inContext:[NSManagedObjectContext MR_defaultContext]];
    
    if (groupData) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *context) {
            
             groupData.status = status;
            
        } completion:^(BOOL contextDidSave, NSError *error) {
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }];
    }
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    //[[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


@end
    
