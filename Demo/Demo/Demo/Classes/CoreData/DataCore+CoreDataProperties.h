//
//  DataCore+CoreDataProperties.h
//  
//
//  Created by ThanhSon on 6/5/18.
//
//

#import "DataCore+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DataCore (CoreDataProperties)

+ (NSFetchRequest<DataCore *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *dataImage;
@property (nullable, nonatomic, copy) NSString *fileName;
@property (nonatomic) int16_t groupId;
@property (nonatomic) int16_t status;
@property (nonatomic) int16_t cid;
@property (nullable, nonatomic, retain) GroupDataCore *downloadGroup;

@end

NS_ASSUME_NONNULL_END
