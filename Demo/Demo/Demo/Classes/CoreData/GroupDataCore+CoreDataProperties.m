//
//  GroupDataCore+CoreDataProperties.m
//  
//
//  Created by ThanhSon on 6/5/18.
//
//

#import "GroupDataCore+CoreDataProperties.h"

@implementation GroupDataCore (CoreDataProperties)

+ (NSFetchRequest<GroupDataCore *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GroupDataCore"];
}

@dynamic status;
@dynamic name;
@dynamic gid;
@dynamic downloadDataCore;

@end
