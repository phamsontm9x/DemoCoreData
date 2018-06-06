//
//  DataCore+CoreDataProperties.m
//  
//
//  Created by ThanhSon on 6/5/18.
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
@dynamic status;
@dynamic cid;
@dynamic downloadGroup;

@end
