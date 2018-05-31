//
//  DataCore+CoreDataClass.m
//  Demo
//
//  Created by ThanhSon on 5/30/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//
//

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


@end
