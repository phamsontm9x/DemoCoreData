//
//  Download Manager.h
//  Demo
//
//  Created by Son Pham on 5/24/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataDto.h"



NS_ASSUME_NONNULL_BEGIN



@interface Download_Manager : NSObject

+ (Download_Manager *)sharedDownManager;

- (void)addEventDownload:(DataDto *)data;

- (nullable NSProgress *)downloadProgressForhID:(NSNumber *)cid;


- (void)resume;

- (void)pause;

@end



NS_ASSUME_NONNULL_END

