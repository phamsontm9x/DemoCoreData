//
//  Download Manager.m
//  Demo
//
//  Created by Son Pham on 5/24/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "Download_Manager.h"



@interface Download_Manager()

@property (nonatomic, strong) NSProgress *progress;
@property (nonatomic, strong) NSMutableArray *queueDownloads;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, assign) NSInteger maxConcurrentOperationCount;
@property (nonatomic, strong) dispatch_queue_t    enqueueOperationQueue;
@property (nonatomic        ) BOOL         isPause;
@property (nonatomic, strong) DataDto *dataTask;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, DataDto*> *listDownload;

@end



@implementation Download_Manager


#pragma mark - Singleton

+ (Download_Manager *)sharedDownManager {
    
    static Download_Manager *sharedDownloadingManager;
    
    static dispatch_once_t done;
    dispatch_once(&done, ^{
        sharedDownloadingManager = [[Download_Manager alloc] init];
    });
    
    return sharedDownloadingManager;
}


#pragma mark - Queue init

- (id)init {
    self = [super init];
    if (self) {
        self.queueDownloads = [[NSMutableArray alloc] init];
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.operationQueue.maxConcurrentOperationCount = 2;
        self.listDownload = [NSMutableDictionary new];
        self.enqueueOperationQueue = dispatch_queue_create("Test", NULL);
    }
    
    return self;
}

- (void)pause {
    _isPause = YES;
    [self.operationQueue setSuspended:_isPause];
}

- (void)resume {
    _isPause = NO;
    [self.operationQueue setSuspended:_isPause];
}

- (void)addEventDownload:(DataDto *)data {
    _dataTask = data;
    [self.listDownload setObject:_dataTask forKey:[NSNumber numberWithInteger:_dataTask.cid]];
    [self addQueue:data];
}

- (void)addQueue:(DataDto*)data{
    
    dispatch_async(self.enqueueOperationQueue, ^{
        
        if (self) {
            Download *download = data.downloadSession;
            
            if (download) {
                download.statusDownload = 1;
                [self.operationQueue addOperation:download];
            }
        }
    });
    
}

- (nullable NSProgress *)downloadProgressForhID:(NSNumber *)cid {
    return [self.listDownload objectForKey:cid].downloadSession.progress;
}

@end
