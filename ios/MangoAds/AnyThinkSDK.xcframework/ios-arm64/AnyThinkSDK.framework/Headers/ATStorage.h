//
//  ATStorage.h
//  ToponSdkDemo
//
//  Created by li zhixuan on 2022/11/19.
//

#import <Foundation/Foundation.h>

@class ATDatabaseStorage;
@class ATMemoryStorage;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ATStorageEntitySaveType) {
    ATStorageEntitySaveTypeMemory,
    ATStorageEntitySaveTypeDatabase,
};

@protocol ATStorageEntityProtocol <NSObject>

- (id)identifier;
+ (ATStorageEntitySaveType)saveType;

@end

@protocol ATStorageProtocol <NSObject>

- (void)createEntityClazz:(Class)clazz;
- (BOOL)saveWithEntity:(id<ATStorageEntityProtocol>)entity entityClazz:(Class)clazz;
- (id<ATStorageEntityProtocol>)readEntityWithIdentifier:(id)identifier entityClazz:(Class)clazz;
- (BOOL)removeEntityWithIdentifier:(id)identifier entityClazz:(Class)clazz;
- (BOOL)removeAllEntity;
- (void)readEntityFromDBWithIdentifier:(id)identifier entityClazz:(Class)clazz completion:(void (^ __nullable)(id<ATStorageEntityProtocol> entity))completion;

@end

@interface ATStorage : NSObject<ATStorageProtocol>

@property (nonatomic, readonly) ATDatabaseStorage *database;
@property (nonatomic, readonly) ATMemoryStorage *memory;

+ (ATStorage *)shareInstance;

- (void)createEntityClazz:(Class)clazz;

- (BOOL)saveWithEntity:(id<ATStorageEntityProtocol>)entity entityClazz:(Class)clazz;
- (id<ATStorageEntityProtocol>)readEntityWithIdentifier:(id)identifier entityClazz:(Class)clazz;
- (BOOL)removeEntityWithIdentifier:(id)identifier entityClazz:(Class)clazz;
- (BOOL)removeAllEntity;
- (void)readEntityFromDBWithIdentifier:(id)identifier entityClazz:(Class)clazz completion:(void (^ __nullable)(id<ATStorageEntityProtocol> entity))completion;

@end

NS_ASSUME_NONNULL_END
