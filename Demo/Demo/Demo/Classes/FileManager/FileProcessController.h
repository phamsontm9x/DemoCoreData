//
//  FileProcessController.h
//  Demo
//
//  Created by Son Pham on 5/25/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileProcessProtocal.h"

@interface FileProcessController : NSObject

+ (id<FileProcessProtocal>)dataHandlerForData:(NSData *)data withURL:(NSString *)url;

@end
