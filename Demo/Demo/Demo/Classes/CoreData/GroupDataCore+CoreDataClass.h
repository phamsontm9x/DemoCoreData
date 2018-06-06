//
//  GroupDataCore+CoreDataClass.h
//  
//
//  Created by ThanhSon on 6/5/18.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>



@class DataCore;



NS_ASSUME_NONNULL_BEGIN



@interface GroupDataCore : NSManagedObject

+ (GroupDataCore *)findGroupWithID:(long)gid inContext:(NSManagedObjectContext *)context;
+ (NSFetchedResultsController<GroupDataCore *> *)fetchAllGroupAndDelegate:(id<NSFetchedResultsControllerDelegate>)delegate inContext:(NSManagedObjectContext *)context;
+ (BOOL)isHasGroupWithID:(long)gid inContext:(NSManagedObjectContext *)context;

@end



NS_ASSUME_NONNULL_END



#import "GroupDataCore+CoreDataProperties.h"
