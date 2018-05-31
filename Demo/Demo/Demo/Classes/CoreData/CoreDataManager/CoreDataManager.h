//
//  CoreDataManager.h
//  Demo
//
//  Created by ThanhSon on 5/30/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>



@interface CoreDataManager : NSObject


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (CoreDataManager *)sharedInstance;

- (BOOL)save;
- (NSManagedObjectContext*)managedObjectContext;
- (NSURL *)applicationDocumentsDirectory;


@end
