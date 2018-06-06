//
//  DataCore+CoreDataClass.m
//  
//
//  Created by ThanhSon on 6/5/18.
//
//

#import "DataCore+CoreDataClass.h"
@import MagicalRecord;


@implementation DataCore

+ (DataCore *)findDataCoreWithName:(NSString *)name inContext:(NSManagedObjectContext *)context {
    return [DataCore MR_findFirstByAttribute:@"fileName" withValue:name inContext:context];
}


+ (NSPredicate *)predicateForDownloadByGroupID:(long)gid {
    return [NSPredicate predicateWithFormat:@"groupId == %@ ", @(gid)];
}

+ (NSPredicate *)predicateForDownloadByName:(NSString *)name {
    return [NSPredicate predicateWithFormat:@"fileName == %@ ", name];
}

+ (nullable NSArray *)findDownloadByGroupID:(long)gid inContext:(NSManagedObjectContext *)context {
    
    NSPredicate *predicate = [self predicateForDownloadByGroupID:gid];
    return [DataCore MR_findAllWithPredicate:predicate inContext:context];
}

+ (nullable NSArray *)findFileDownloadByName:(NSString *)name inContext:(NSManagedObjectContext *)context {
    
    NSPredicate *predicate = [self predicateForDownloadByName:name];
    return [DataCore MR_findAllWithPredicate:predicate inContext:context];
}

+ (BOOL)isHasDataCoreWithName:(NSString *)name inContext:(NSManagedObjectContext *)context {
    DataCore *data = [DataCore findDataCoreWithName:name inContext:context];
    if (data) {
        return YES;
    }
    return NO;
}


#pragma mark - FetchedResultsController

+ (NSFetchedResultsController<DataCore *> *)fetchAllDownloadImageWithGroupID:(NSInteger)groupID AndDelegate:(id<NSFetchedResultsControllerDelegate>)delegate inContext:(NSManagedObjectContext *)context {
    
    NSFetchedResultsController *fetchedController = [DataCore MR_fetchAllGroupedBy:nil withPredicate:[DataCore predicateForDownloadByGroupID:groupID] sortedBy:@"fileName" ascending:YES];
    fetchedController.delegate = delegate;
    
    NSError *err;
    [fetchedController performFetch:&err];
    
    if (err) {
        NSLog(@"%@",err.localizedDescription);
    }
    
    return fetchedController;
    
}

@end
