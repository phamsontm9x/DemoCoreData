//
//  FileProcess.h
//  Demo
//
//  Created by Son Pham on 5/25/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//


@protocol FileProcessProtocal <NSObject>

+ (id<FileProcessProtocal>)imageWithData:(NSData *)data path:(NSString *)destination;
- (BOOL)saveImage:(NSError *)error;
- (NSString *)filePath;

@end
