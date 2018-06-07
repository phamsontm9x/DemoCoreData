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

- (void)dealloc {
    self.observedProgress = nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.observedProgress = nil;
    // Initialization code
}

- (void)initUIWithData:(DataDto*)data {
    _data = data;
    NSProgress *downloadProgress = [[Download_Manager sharedDownManager] downloadProgressForhID:[NSNumber numberWithInteger:_data.cid]];
    if (downloadProgress) {
        self.observedProgress = downloadProgress;
    }
    
    if (_data.statusDownload == 3) {
        self.observedProgress = [NSProgress progressWithTotalUnitCount:1];
        self.observedProgress.completedUnitCount = 1;
    } 
}

- (void)updateStatus:(NSInteger)status {
    switch (status) {
        case 0:
            self.lblTitle.text = @"";
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
        }
            break;
            
        default:
            break;
    }
}

- (void)setImageWithData:(NSData*)dataImage {
    if (dataImage == nil && _data.downloadSession.statusDownload == 3) {
        self.lblTitle.text = @"Reload";
    }
    self.imgView.image = [UIImage imageWithData:dataImage];
}


#pragma mark - Observe

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (context == @"Test1") {
        
        __weak typeof(&*self) self_weak_ = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSProgress *progress = (NSProgress *)object;
            __strong typeof(&*self_weak_) self_strong_ = self_weak_;
            if (self_strong_) {
                [self_strong_ updateStatus:2];
                self_strong_.progressView.progress = progress.fractionCompleted;
                
                if (progress.fractionCompleted == 1) {
                    [self_strong_ updateStatus:3];
                    self_strong_.observedProgress = nil;
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
            
            [_observedProgress removeObserver:self forKeyPath:@"fractionCompleted" context:@"Test1"];
        }
        
        _observedProgress = observedProgress;
        
        if (observedProgress) {
            
            [observedProgress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:@"Test1"];
            
            self.lblSubTitle.text = [NSString stringWithFormat:@"%0.f%%", observedProgress.fractionCompleted * 100];
            self.progressView.progress = observedProgress.fractionCompleted;
        }
    }
}

@end
