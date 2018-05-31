//
//  DownloadTableViewCell.m
//  Demo
//
//  Created by Son Pham on 5/24/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "DownloadTableViewCell.h"

@implementation DownloadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initUIWithData:(ObjectDto*)data {
    _data = data;
    if (data) {
        self.observedProgress = data.progress;
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
        
        case 3: {
            self.lblTitle.text = @"Finished";
        }
            
            break;
            
        default:
            break;
    }
}


#pragma mark - Observe

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (context == @"Test") {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSProgress *progress = (NSProgress *)object;
            
            if (self) {
 
                self.lblSubTitle.text = [NSString stringWithFormat:@"%0.f%%", progress.fractionCompleted * 100];
                self.progressView.progress = progress.fractionCompleted;
                
                if (progress.fractionCompleted == 1) {
                    if (_delegate && [_delegate respondsToSelector:@selector(updateStatus:)]) {
                        _data.statusDownload = 3;
                        [_delegate updateStatus:_data];
                    }
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
