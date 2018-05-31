//
//  DowloadCollectionViewCell.h
//  Demo
//
//  Created by ThanhSon on 5/25/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataDto.h"



@interface DowloadCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;
@property(nonatomic, strong) IBOutlet UIImageView *imgView;

@property(nonatomic, strong) DataDto *data;
@property(nonatomic, strong) NSProgress *observedProgress;

- (void)initUIWithData:(DataDto*)data;
- (void)updateStatus:(NSInteger)status;


@end
