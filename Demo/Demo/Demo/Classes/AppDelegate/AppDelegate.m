//
//  AppDelegate.m
//  Demo
//
//  Created by ThanhSon on 5/21/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "AppDelegate.h"
#import "DataCore+CoreDataClass.h"
#import "DataCore+CoreDataProperties.h"

@import MagicalRecord;



@interface AppDelegate ()

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSURL *dic = [[[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [dic URLByAppendingPathComponent:@"Demo/"];
    NSLog(@"%@",storeURL);
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
    
    // Set up CoreData    
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"DataFile"];
    [[NSManagedObjectContext MR_defaultContext] setMergePolicy:NSOverwriteMergePolicy];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
//   [MagicalRecord cleanUp];
}


@end
