//
//  DataCore+CoreDataClass.m
//  Demo
//
//  Created by ThanhSon on 5/30/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//
//

#import <MagicalRecord/MagicalRecord.h>
#import "DataCore+CoreDataClass.h"
#import "CoreDataManager.h"


@implementation DataCore


+ (NSPredicate *)predicateForDownloadByGroupID:(long)gid {
    return [NSPredicate predicateWithFormat:@"groupId == %@ ", @(gid)];
}

+ (NSPredicate *)predicateForDownloadByName:(NSString *)name {
    return [NSPredicate predicateWithFormat:@"fileName == %@ ", name];
}

+ (nullable NSArray *)findDownloadByGroupID:(long)gid inContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [DataCore fetchRequest];
    NSPredicate *predicate = [self predicateForDownloadByGroupID:gid];
    request.predicate = predicate;
    
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    }
    
    return array;
}

+ (nullable NSArray *)findFileDownloadByName:(NSString *)name inContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [DataCore fetchRequest];;
    NSPredicate *predicate = [self predicateForDownloadByName:name];
    request.predicate = predicate;
    
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    }
    
    return array;
}

#pragma mark - FetchedResultsController

+ (NSFetchedResultsController<DataCore *> *)fetchAllDownloadImageWithGroupID:(NSInteger)groupID AndDelegate:(id<NSFetchedResultsControllerDelegate>)delegate inContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest *fetch = [DataCore fetchRequest];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"fileName" ascending:YES selector:nil];
    fetch.sortDescriptors = @[sort];
    fetch.predicate = [DataCore predicateForDownloadByGroupID:groupID];
    
    NSFetchedResultsController * fetchedController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:context sectionNameKeyPath:nil cacheName:@"imageDownLoad"];
    fetchedController.delegate = delegate;
    NSError *err;
    [fetchedController performFetch:&err];
    
    if (err) {
        NSLog(@"%@",err.localizedDescription);
    }
    
    return fetchedController;
    
}




@end
