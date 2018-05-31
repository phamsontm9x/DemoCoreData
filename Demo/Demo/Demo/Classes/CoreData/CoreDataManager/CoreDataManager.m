//
//  CoreDataManager.m
//  Demo
//
//  Created by ThanhSon on 5/30/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "CoreDataManager.h"



//NSString * const DataManagerDidSaveNotification = @"DataManagerDidSaveNotification";
//NSString * const DataManagerDidSaveFailedNotification = @"DataManagerDidSaveFailedNotification";



@interface CoreDataManager ()

@end


@implementation CoreDataManager

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;


+ (CoreDataManager*)sharedInstance {
    static dispatch_once_t pred;
    static CoreDataManager *sharedInstance = nil;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (NSManagedObjectModel*)objectModel {

    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DataFile" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
    
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self objectModel]];
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DataFile.sqlite"];
    
    NSError *error = nil;
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (!coordinator) {
        return nil;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return _managedObjectContext;
}


#pragma mark - Core Data Saving support

- (BOOL)save {
    if (![self.managedObjectContext hasChanges])
        return YES;
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error while saving: %@\n%@", [error localizedDescription], [error userInfo]);
//        [[NSNotificationCenter defaultCenter] postNotificationName:DataManagerDidSaveFailedNotification object:error];
        return NO;
    }
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:DataManagerDidSaveNotification object:nil];
    return YES;
}


@end

