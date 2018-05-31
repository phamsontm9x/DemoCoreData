//
//  DataCore+CoreDataProperties.m
//  Demo
//
//  Created by ThanhSon on 5/30/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//
//

#import "DataCore+CoreDataProperties.h"

@implementation DataCore (CoreDataProperties)

+ (NSFetchRequest<DataCore *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DataCore"];
}

@dynamic dataImage;
@dynamic fileName;
@dynamic groupId;

@end
