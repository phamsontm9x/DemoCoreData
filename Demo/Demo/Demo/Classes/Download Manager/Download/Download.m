//
//  Download.m
//  Demo
//
//  Created by Son Pham on 5/24/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "Download.h"
#import "FileProcessController.h"
#import "FileProcessProtocal.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "DataCore+CoreDataClass.h"
#import "CoreDataManager.h"
@import MagicalRecord;



@interface Download () <NSURLSessionDownloadDelegate, NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *fileExt;
@property (atomic, assign) BOOL _executing;
@property (atomic, assign) BOOL _finished;
@property (nonatomic, strong) NSURLSession *session;



@end



@implementation Download

- (instancetype)initWithUrl:(NSString *)url FileName:(NSString *)fileName FileExt:(NSString*)fileExt andGroupId:(NSInteger )groupId {
    self = [super init];
    
    if (self) {
        _url = url;
        _fileName = fileName;
        _fileExt = fileExt;
        _progress = [[NSProgress alloc] init];
        _groupId = groupId;
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    
    return self;
}


#pragma mark - NSOperation

- (void) start {
    if ([self isCancelled]) {
        self._finished = YES;
        return;
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    self._executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
    
}

- (void) main {
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    
    NSString *pathDoc = [NSString stringWithFormat:@"%@", urls[0]];
    

    _path = [NSString stringWithFormat:@"%@%@.%@",pathDoc,_fileName,_fileExt];
    
    
    NSURL *downloadURL = [NSURL URLWithString:_url];
    
    

    if ([self isCancelled]) {
        return;
    }
    
    if (_url) {
        @synchronized (_session) {
            if ([self isCancelled]) {
                return;
            }
            
            _downloadTask = [_session downloadTaskWithURL:downloadURL];
            
            [_downloadTask resume];
        }
    } else {
        return;
    }
}

- (void)cancel {
    if (self.downloadTask) {
        [self.downloadTask cancel];
    }
    
    [super cancel];
    if (self._executing) {
        [self willChangeValueForKey:@"isFinished"];
        [self willChangeValueForKey:@"isExecuting"];
        
        self._executing = NO;
        self._finished = YES;
        
        [self didChangeValueForKey:@"isExecuting"];
        [self didChangeValueForKey:@"isFinished"];
    }
    
    self.downloadTask = nil;
}

- (void)completeWithError:(NSError *)error {
    
    if (self.isCancelled) {
        return;
    }
    
    if (error) {
        self.progress.totalUnitCount = 1;
        self.progress.completedUnitCount = 0;
    }
    
   
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    self._executing = NO;
    self._finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];

    self.downloadTask = nil;
}

- (void)pause {
    [_downloadTask suspend];
}

- (BOOL)isExecuting {
    return self._executing;
}

- (BOOL)isFinished {
    return self._finished;
}


#pragma mark - url session download delegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    if ([self isCancelled]) {
        
        return;
    }
    
    if (_progress) {
        _statusDownload = 2;
        if (_progress.totalUnitCount <= 0 && totalBytesExpectedToWrite > 0) {
            _progress.totalUnitCount = totalBytesExpectedToWrite;
        }

        if (_progress.totalUnitCount > 1) {
            _progress.completedUnitCount = totalBytesWritten;
        }
    }
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    [_progress setUserInfoObject:_fileName forKey:@"progress"];
    
    NSData *data = [NSData dataWithContentsOfURL:location];
    NSLog(@"finished: %@", location);
    
    NSError *error;
    
    BOOL success = [[NSFileManager defaultManager] removeItemAtURL:location error:&error];
    if (!success) {
        NSLog(@"Error removing file at path: %@", error.localizedDescription);
    }

    
    // CoreData
    
    [self completeWithError:nil];
    [self saveDataToCoreDataWithData:data FileName:_fileName andGroupId:_groupId];
    _statusDownload = 3;
    
}


#pragma mark - CoreData

- (void)saveDataToCoreDataWithData:(NSData *)data FileName:(NSString*)strFileName andGroupId:(NSInteger)groupId {
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *context) {
        DataCore *dataCore = [DataCore MR_findFirstByAttribute:@"fileName" withValue:strFileName inContext:[NSManagedObjectContext MR_defaultContext]];
        dataCore.dataImage = data;
        dataCore.status = _statusDownload;
        dataCore.groupId = groupId;
    } completion:^(BOOL contextDidSave, NSError *error) {
//        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }];

}

@end
