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



@interface ListDownloadViewController () <UITableViewDelegate, UITableViewDataSource, DownloadTableViewCellDelegate, NSFetchedResultsControllerDelegate> {
    NSMutableArray *_arrDownload;
    NSMutableArray *_arrObj;
    NSMutableArray *_arrObjQueue;
    NSMutableArray *_arrObjDownloading;
    NSInteger maxCurentDownLoad;
    ObjectDto *objDto;
    BOOL isStart;
}

@property (weak, nonatomic) IBOutlet UIProgressView *progressTotal;
@property (nonatomic, strong) IBOutlet UITableView* tbvContent;


@end



@implementation ListDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isStart = YES;
    maxCurentDownLoad = 1;
    _arrDownload = [[NSMutableArray alloc] init];
    _arrObjQueue = [[NSMutableArray alloc] init];
    _arrObjDownloading = [[NSMutableArray alloc] init];
    _arrObj = [[NSMutableArray alloc] init];
    [self initData];
}

- (void)initData {
    
    for (int i = 0; i < 3 ; i++) {
        
        _arrDownload = [[NSMutableArray alloc] init];
        ObjectDto *obj = [[ObjectDto alloc] initObjectDtoWithName:@"group" groupId:i];
        for (int j =0 ; j < 10 ; j++) {
            NSString * url = (j < 11) ?@"http://1.bp.blogspot.com/-mRJKdjhDCpM/VyibnmXS_2I/AAAAAAAOGrI/8ykMQB8f1W0/s0/bt3551-hiep-khach-giang-ho-truyentranhtuan-com-chap-500-trang-000.png" : @"http://ipv4.download.thinkbroadband.com/200MB.zip";
            
            DataDto *data = [[DataDto alloc] initDataDtoWith:url FileName:[NSString stringWithFormat:@"test%d",i*1000+j] cid:[NSNumber numberWithInt:i*100+j] andGroupId:i];
            
            [_arrDownload addObject:data];
        }
        
        obj.listData = _arrDownload;
        [obj configProgress];
        [_arrObj addObject:obj];
    }
    
    [_tbvContent reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pauseSelected:(id)sender {
    [[Download_Manager sharedDownManager] pause];
}

- (IBAction)startSelected:(id)sender {
    if (isStart) {
        [self preDownLoad];
    } else {
        [[Download_Manager sharedDownManager] resume];
    }
    isStart = NO;
}

- (void)preDownLoad {
    
    for (int i = 0 ; i < maxCurentDownLoad ; i ++ ) {
        ObjectDto *dto = _arrObj[i];
        dto.statusDownload = 2;
        [_arrObjDownloading addObject:dto];
    }
    
    for (int i = (int)maxCurentDownLoad ; i < _arrObj.count ; i++) {
        ObjectDto *dto = _arrObj[i];
        dto.statusDownload = 1;
        [_arrObjQueue addObject:dto];
    }
    
    for (ObjectDto *dto in _arrObjDownloading) {
        for (DataDto *data in dto.listData) {
            [[Download_Manager sharedDownManager] addEventDownload:data];
        }
        dto.statusDownload = 2;
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
    [cell initUIWithData:data];
    [cell updateStatus:data.statusDownload];
    cell.lblName.text = [NSString stringWithFormat:@"Group %ld",indexPath.row];
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListImageDownload *vc = [storyboard instantiateViewControllerWithIdentifier:@"ListImageDownload"];
    vc.objData = _arrObj[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - TableViewCellDelegate

- (void)updateStatus:(ObjectDto *)obj {
    for (ObjectDto *dto in _arrObj) {
        if (dto.groupId == obj.groupId ) {
            dto.statusDownload = obj.statusDownload;
        }
    }
    if (obj.statusDownload == 3) {
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
                dto.statusDownload = 2;
            }
        }
    }
    [_tbvContent reloadData];
}

@end
    
