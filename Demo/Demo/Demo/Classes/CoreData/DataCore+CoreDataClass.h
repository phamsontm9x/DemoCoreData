//
//  DataCore+CoreDataClass.h
//  
//
//  Created by ThanhSon on 6/5/18.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>



@class GroupDataCore;



NS_ASSUME_NONNULL_BEGIN


@interface DataCore : NSManagedObject

+ (DataCore *)findDataCoreWithName:(NSString *)name inContext:(NSManagedObjectContext *)context;
+ (NSPredicate *)predicateForDownloadByGroupID:(long)gid;
+ (NSPredicate *)predicateForDownloadByName:(NSString *)name;

+ (nullable NSArray *)findDownloadByGroupID:(long)gid inContext:(NSManagedObjectContext *)context;
+ (nullable NSArray *)findFileDownloadByName:(NSString *)name inContext:(NSManagedObjectContext *)context;

+ (BOOL)isHasDataCoreWithName:(NSString *)name inContext:(NSManagedObjectContext *)context;

+ (NSFetchedResultsController<DataCore *> *)fetchAllDownloadImageWithGroupID:(NSInteger)groupID AndDelegate:(id<NSFetchedResultsControllerDelegate>)delegate inContext:(NSManagedObjectContext *)context;


@end


NS_ASSUME_NONNULL_END



#import "DataCore+CoreDataProperties.h"
