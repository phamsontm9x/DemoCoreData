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
@property(nonatomic, weak) IBOutlet UIImageView *imgView;

@property(nonatomic, strong) NSProgress *observedProgress;
@property(nonatomic, strong) DataDto *data;


- (void)initUIWithData:(DataDto*)data;
- (void)updateStatus:(NSInteger)status;
- (void)setImageWithData:(NSData*)dataImage;


@end
