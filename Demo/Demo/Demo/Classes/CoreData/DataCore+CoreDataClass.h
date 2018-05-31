//
//  DataCore+CoreDataClass.h
//  Demo
//
//  Created by ThanhSon on 5/30/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>



NS_ASSUME_NONNULL_BEGIN



@interface DataCore : NSManagedObject

+ (NSPredicate *)predicateForDownloadByGroupID:(long)gid;
+ (NSPredicate *)predicateForDownloadByName:(NSString *)name;

+ (nullable NSArray *)findDownloadByGroupID:(long)gid inContext:(NSManagedObjectContext *)context;
+ (nullable NSArray *)findFileDownloadByName:(NSString *)name inContext:(NSManagedObjectContext *)context;

@end



NS_ASSUME_NONNULL_END



#import "DataCore+CoreDataProperties.h"
