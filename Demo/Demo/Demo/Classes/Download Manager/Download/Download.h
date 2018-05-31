//
//  Download.h
//  Demo
//
//  Created by Son Pham on 5/24/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN


@class Download;


typedef void(^DownloadOperationCompletionBlock)(BOOL succes, NSError * _Nullable);


@interface Download : NSOperation

@property (nullable, nonatomic, copy) DownloadOperationCompletionBlock downloadCompletionBlock;

@property (nonatomic, strong) NSProgress * _Nullable progress;

@property (nonatomic, assign) NSInteger statusDownload;
@property (nonatomic, assign) NSInteger groupId;

- (instancetype )initWithUrl:(NSString * _Nullable)url FileName:(NSString * _Nullable)fileName FileExt:(NSString* _Nullable)fileExt andGroupId:(NSInteger )groupId;

@end


NS_ASSUME_NONNULL_END

