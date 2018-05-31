//
//  DownloadTableViewCell.h
//  Demo
//
//  Created by Son Pham on 5/24/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataDto.h"
#import "ObjectDto.h"
#import "Download_Manager.h"

@class DownloadTableViewCell;

@protocol DownloadTableViewCellDelegate <NSObject>

@optional

- (void)updateStatus:(ObjectDto*)obj;

@end

@interface DownloadTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property(nonatomic, strong) NSProgress *observedProgress;

@property (nonatomic, weak) id<DownloadTableViewCellDelegate> delegate;

@property (strong, nonatomic) ObjectDto *data;

- (void)initUIWithData:(ObjectDto*)data;
- (void)updateStatus:(NSInteger)status;

@end
