//
//  ObjectDto.m
//  Demo
//
//  Created by Son Pham on 5/24/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "ObjectDto.h"

@implementation ObjectDto

- (instancetype)initObjectDtoWithName:(NSString *)name groupId:(NSInteger )gid {
    self = [super init];
    
    if (self) {
        self.groupId = gid;
        self.progress = [[NSProgress alloc] init];
        self.listData = [[NSMutableArray alloc] init];
        self.progress = [NSProgress progressWithTotalUnitCount:1];
        self.progress.completedUnitCount = 0;
    
    }
    
    return self;
}

- (void)configProgress {
    _progress = [NSProgress progressWithTotalUnitCount:_listData.count];
    for (DataDto *data in _listData) {
        [self.progress addChild:data.downloadSession.progress withPendingUnitCount:1];
    }
}

@end
