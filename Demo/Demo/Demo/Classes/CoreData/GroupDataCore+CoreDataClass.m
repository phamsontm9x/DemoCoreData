//
//  GroupDataCore+CoreDataClass.m
//  
//
//  Created by ThanhSon on 6/5/18.
//
//

#import "GroupDataCore+CoreDataClass.h"
@import MagicalRecord;



@implementation GroupDataCore

+ (GroupDataCore *)findGroupWithID:(long)gid inContext:(NSManagedObjectContext *)context {
    return [GroupDataCore MR_findFirstByAttribute:@"gid" withValue:[NSNumber numberWithLong:gid] inContext:context];
}

+ (NSFetchedResultsController<GroupDataCore *> *)fetchAllGroupAndDelegate:(id<NSFetchedResultsControllerDelegate>)delegate inContext:(NSManagedObjectContext *)context {
    
    NSFetchedResultsController *fetchedController = [GroupDataCore MR_fetchAllGroupedBy:nil withPredicate:nil sortedBy:@"gid" ascending:YES];
    fetchedController.delegate = delegate;
    
    NSError *err;
    [fetchedController performFetch:&err];
    
    if (err) {
        NSLog(@"%@",err.localizedDescription);
    }
    
    return fetchedController;
    
}

+ (BOOL)isHasGroupWithID:(long)gid inContext:(NSManagedObjectContext *)context {
    GroupDataCore *group = [GroupDataCore findGroupWithID:gid inContext:context];
    if (group) {
        return YES;
    }
    return NO;
}


@end
