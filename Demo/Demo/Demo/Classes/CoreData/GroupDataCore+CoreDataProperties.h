//
//  GroupDataCore+CoreDataProperties.h
//  
//
//  Created by ThanhSon on 6/5/18.
//
//

#import "GroupDataCore+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GroupDataCore (CoreDataProperties)

+ (NSFetchRequest<GroupDataCore *> *)fetchRequest;

@property (nonatomic) int16_t status;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t gid;
@property (nullable, nonatomic, retain) NSOrderedSet<DataCore *> *downloadDataCore;

@end

@interface GroupDataCore (CoreDataGeneratedAccessors)

- (void)insertObject:(DataCore *)value inDownloadDataCoreAtIndex:(NSUInteger)idx;
- (void)removeObjectFromDownloadDataCoreAtIndex:(NSUInteger)idx;
- (void)insertDownloadDataCore:(NSArray<DataCore *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeDownloadDataCoreAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInDownloadDataCoreAtIndex:(NSUInteger)idx withObject:(DataCore *)value;
- (void)replaceDownloadDataCoreAtIndexes:(NSIndexSet *)indexes withDownloadDataCore:(NSArray<DataCore *> *)values;
- (void)addDownloadDataCoreObject:(DataCore *)value;
- (void)removeDownloadDataCoreObject:(DataCore *)value;
- (void)addDownloadDataCore:(NSOrderedSet<DataCore *> *)values;
- (void)removeDownloadDataCore:(NSOrderedSet<DataCore *> *)values;

@end

NS_ASSUME_NONNULL_END
