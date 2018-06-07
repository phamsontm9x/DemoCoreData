//
//  ObjectDto.m
//  Demo
//
//  Created by Son Pham on 5/24/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "ObjectDto.h"


typedef NS_ENUM(NSInteger, StatusDownload) {
    StatusDefault = 0,
    StatusDownloadQueue,
    StatusDownLoading,
    StatusDownloadfinish,
};


@implementation ObjectDto

- (instancetype)initObjectDtoWithName:(NSString *)name groupId:(NSInteger )gid andStatus:(NSInteger)status {
    self = [super init];
    
    if (self) {
        self.statusDownload = status;
        self.groupId = gid;
        self.groupName = name;
        self.progress = [[NSProgress alloc] init];
        self.listData = [[NSMutableArray alloc] init];
        self.progress = [NSProgress progressWithTotalUnitCount:1];
        self.progress.completedUnitCount = 0;
    }
    
    return self;
}

- (void)configProgress {
    if (self.statusDownload != StatusDownloadfinish) {
        _progress = [NSProgress progressWithTotalUnitCount:_listData.count];
        for (DataDto *data in _listData) {
            [self.progress addChild:data.downloadSession.progress withPendingUnitCount:1];
            if (data.statusDownload == StatusDownloadfinish) {
                _progress.completedUnitCount ++;
            }
        }
    } else {
        _progress = [NSProgress progressWithTotalUnitCount:1];
        _progress.completedUnitCount = 1;
    }
}

@end
