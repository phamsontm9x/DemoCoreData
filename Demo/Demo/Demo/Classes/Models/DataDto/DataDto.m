//
//  DataDto.m
//  Demo
//
//  Created by Son Pham on 5/24/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "DataDto.h"


typedef NS_ENUM(NSInteger, StatusDownload) {
    StatusDefault = 0,
    StatusDownloadQueue,
    StatusDownLoading,
    StatusDownloadfinish,
};



@implementation DataDto

- (instancetype)initDataDtoWith:(NSString *)url FileName:(NSString *)fileName cid:(NSNumber *)cid andGroupId:(NSInteger)groupId {
    self = [super init];
    
    if (self) {
        
        self.url = url;
        self.fileName = fileName;
        self.cid = cid;
        self.statusDownload = 0;
        self.groupId = groupId;
        
        [self setFileExt];
        
        self.downloadSession = [[Download alloc] initWithUrl:url FileName:self.fileName FileExt:self.fileExt andGroupId:self.groupId];
        self.downloadSession.statusDownload = 0;
        
    }
    
    return self;
}

- (void)setFileExt {
    _fileExt = [_url pathExtension];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    
    NSString *pathDoc = [NSString stringWithFormat:@"%@", urls[0]];
    
    NSString *temp= [NSString stringWithFormat:@"%@%@.%@",pathDoc,_fileName,_fileExt];
   
    _path = [temp substringFromIndex:6];
}


@end
