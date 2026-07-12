//
//  WindHCDataManager.h
//  WindHTTPCache
//
//  Created by Single on 2017/8/11.
//  Copyright © 2017年 Single. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WindHCDataReader.h"
#import "WindHCDataLoader.h"
#import "WindHCDataRequest.h"
#import "WindHCDataResponse.h"
#import "WindHCDataCacheItem.h"

@interface WindHCDataStorage : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)storage;

/**
 *  Return file path if the content did finished cache.
 */
- (NSURL *)completeFileURLWithURL:(NSURL *)URL;

/**
 *  Reader for certain request.
 */
- (WindHCDataReader *)readerWithRequest:(WindHCDataRequest *)request;

/**
 *  Loader for certain request.
 */
- (WindHCDataLoader *)loaderWithRequest:(WindHCDataRequest *)request;

/**
 *  Get cache item.
 */
- (WindHCDataCacheItem *)cacheItemWithURL:(NSURL *)URL;
- (NSArray<WindHCDataCacheItem *> *)allCacheItems;

/**
 *  Get cache length.
 */
@property (nonatomic) long long maxCacheLength;     // Default is 500M.
- (long long)totalCacheLength;

/**
 *  Delete cache.
 */
- (void)deleteCacheWithURL:(NSURL *)URL;
- (void)deleteAllCaches;


@end
