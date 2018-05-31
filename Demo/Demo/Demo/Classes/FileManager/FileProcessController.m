//
//  FileProcessController.m
//  Demo
//
//  Created by Son Pham on 5/25/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "FileProcessController.h"
#import "FileImage.h"
#import "FilePdf.h"

#define arrImage @[@"ipg",@"png",@"jpge"]
#define arrPDF @[@"pdf",@"doc",@"docs"]

@implementation FileProcessController

+ (id<FileProcessProtocal>)dataHandlerForData:(NSData *)data withURL:(NSString *)url {
    
    Class fileClass = [self classWithFile:[url pathExtension]];
    
    return [fileClass imageWithData:data path:url];
}

+ (id)classWithFile:(NSString *)fileExt {
    if ([arrImage containsObject:fileExt] ) {
        return [FileImage class];
    } else if ([arrPDF containsObject:fileExt]) {
        return [FilePdf class];
    }
    return [FileImage class];
}

@end
