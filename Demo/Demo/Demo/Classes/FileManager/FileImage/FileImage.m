//
//  FileImage.m
//  Demo
//
//  Created by Son Pham on 5/25/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "FileImage.h"

@interface FileImage ()

@property (nonatomic, strong)   NSData *data;
@property (nonatomic, strong)   NSString *path;

@end



@implementation FileImage

+ (id<FileProcessProtocal>)imageWithData:(NSData *)data path:(NSString *)destination {
    FileImage *file = [FileImage new];
    file.data = data;
    file.path = destination;
    
    return file;
}


- (BOOL)saveImage:(NSError *)error {
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.path]) {
        [[NSFileManager defaultManager] removeItemAtPath:self.path error:nil];
    }
    
    [[NSFileManager defaultManager] createDirectoryAtPath:[self.path stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *temp=[self.path substringFromIndex:7];

    return [self.data writeToFile:temp options:NSDataWritingAtomic error:&error];
}

- (NSString *)filePath {
    return self.path.pathExtension;
}


@end
