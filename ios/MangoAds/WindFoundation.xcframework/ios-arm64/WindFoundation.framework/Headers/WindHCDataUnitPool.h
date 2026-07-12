//
//  WindHCDataUnitPool.h
//  WindHTTPCache
//
//  Created by Single on 2017/8/11.
//  Copyright © 2017年 Single. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WindHCDataUnit.h"
#import "WindHCDataCacheItem.h"

@interface WindHCDataUnitPool : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)pool;

- (WindHCDataUnit *)unitWithURL:(NSURL *)URL;

- (long long)totalCacheLength;

- (NSArray<WindHCDataCacheItem *> *)allCacheItem;
- (WindHCDataCacheItem *)cacheItemWithURL:(NSURL *)URL;

- (void)deleteUnitWithURL:(NSURL *)URL;
- (void)deleteUnitsWithLength:(long long)length;
- (void)deleteAllUnits;
- (NSString *)cacheItemPathWithURL:(NSURL *)URL;

@end
