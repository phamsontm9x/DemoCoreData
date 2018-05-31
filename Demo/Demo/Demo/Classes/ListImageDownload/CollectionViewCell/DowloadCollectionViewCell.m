//
//  DowloadCollectionViewCell.m
//  Demo
//
//  Created by ThanhSon on 5/25/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "DowloadCollectionViewCell.h"
#import "Download_Manager.h"
#import "CoreDataManager.h"
#import "DataCore+CoreDataClass.h"

@implementation DowloadCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)initUIWithData:(DataDto*)data {
    _data = data;
    NSProgress *downloadProgress = [[Download_Manager sharedDownManager] downloadProgressForhID:data.cid];
    if (downloadProgress) {
        self.observedProgress = downloadProgress;
    }
}

- (void)updateStatus:(NSInteger)status {
    switch (status) {
        case 0:
            self.lblTitle.text = @"Image";
            break;
            
        case 1:
            self.lblTitle.text = @"Queueing...";
            break;
            
        case 2:
            self.lblTitle.text = @"Downloading...";
            break;
            
        case 3:
        {
            self.lblTitle.text = @"Finished";
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getImage];
            });
        }
            break;
            
        default:
            break;
    }
}

- (void)getImage {
    
    
    NSData *dataFile = [NSData dataWithContentsOfFile:_data.path];
    self.imgView.image = [UIImage imageWithData:dataFile];
    
    NSArray *results = [DataCore findFileDownloadByName:_data.fileName inContext:[[CoreDataManager sharedInstance] managedObjectContext]];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:results];
    if (arr.count > 0) {
        DataCore *data = arr.firstObject;
        UIImage *img = [UIImage imageWithData:data.dataImage];
        self.imgView.image = img;
    }
    

    
}

#pragma mark - Observe

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (context == @"Test") {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSProgress *progress = (NSProgress *)object;
            
            if (self) {
                [self updateStatus:2];
//                self.lblSubTitle.text = [NSString stringWithFormat:@"%0.f%%", progress.fractionCompleted * 100];
                self.progressView.progress = progress.fractionCompleted;
                
                if (progress.fractionCompleted == 1) {
                    [self updateStatus:3];
                    self.observedProgress = nil;
                }
            };
        });
        
    } else {
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setObservedProgress:(NSProgress *)observedProgress {
    
    if (_observedProgress != observedProgress) {
        
        if (_observedProgress) {
            
            [_observedProgress removeObserver:self forKeyPath:@"fractionCompleted" context:@"Test"];
        }
        
        _observedProgress = observedProgress;
        
        if (observedProgress) {
            
            [observedProgress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:@"Test"];
            
            self.lblSubTitle.text = [NSString stringWithFormat:@"%0.f%%", observedProgress.fractionCompleted * 100];
            self.progressView.progress = observedProgress.fractionCompleted;
        }
    }
}

@end
