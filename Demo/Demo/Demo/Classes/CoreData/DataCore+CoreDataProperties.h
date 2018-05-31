//
//  DataCore+CoreDataProperties.h
//  Demo
//
//  Created by ThanhSon on 5/30/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//
//

#import "DataCore+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DataCore (CoreDataProperties)

+ (NSFetchRequest<DataCore *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *dataImage;
@property (nullable, nonatomic, copy) NSString *fileName;
@property (nonatomic) int16_t groupId;

@end

NS_ASSUME_NONNULL_END
