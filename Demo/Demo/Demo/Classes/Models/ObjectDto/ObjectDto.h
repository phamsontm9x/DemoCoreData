//
//  ObjectDto.h
//  Demo
//
//  Created by Son Pham on 5/24/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataDto.h"
#import "BaseDto.h"



NS_ASSUME_NONNULL_BEGIN


@interface ObjectDto : BaseDto

@property (nonatomic, strong) NSProgress *progress;
@property (nonatomic, strong) NSString *groupName;

@property (nonatomic, strong) NSMutableArray <DataDto*> *listData;

- (instancetype)initObjectDtoWithName:(NSString *)name groupId:(NSInteger )gid andStatus:(NSInteger)status;

- (void)configProgress;

@end


NS_ASSUME_NONNULL_END
