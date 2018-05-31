//
//  DataDto.h
//  Demo
//
//  Created by Son Pham on 5/24/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Download.h"
#import "BaseDto.h"



NS_ASSUME_NONNULL_BEGIN


@class Download;


@interface DataDto : BaseDto

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *fileExt;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *path;

@property (nonatomic, strong) Download *downloadSession;

@property (nullable, nonatomic, copy) NSNumber *cid;

- (instancetype)initDataDtoWith:(NSString *_Nullable)url FileName:(NSString *_Nullable)fileName cid:(NSNumber *_Nullable)cid andGroupId:(NSInteger)groupId;


@end


NS_ASSUME_NONNULL_END
