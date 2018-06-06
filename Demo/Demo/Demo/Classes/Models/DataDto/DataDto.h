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

@property (nonatomic, assign) NSInteger cid;

- (instancetype)initDataDtoWith:(NSString *)url FileName:(NSString *)fileName cid:(NSInteger)cid GroupId:(NSInteger)groupId andStatus:(NSInteger)status;


@end


NS_ASSUME_NONNULL_END
