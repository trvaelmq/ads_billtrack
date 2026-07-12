//
//  WindHCData+Internal.h
//  WindHTTPCache
//
//  Created by Single on 2017/8/11.
//  Copyright © 2017年 Single. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WindHCDataCacheItemZone.h"
#import "WindHCDataCacheItem.h"
#import "WindHCDataResponse.h"
#import "WindHCDataRequest.h"
#import "WindHCDataReader.h"
#import "WindHCDataLoader.h"

#pragma mark - WindHCDataReader

@interface WindHCDataReader ()

- (instancetype)initWithRequest:(WindHCDataRequest *)request NS_DESIGNATED_INITIALIZER;

@end

#pragma mark - WindHCDataLoader

@interface WindHCDataLoader ()

- (instancetype)initWithRequest:(WindHCDataRequest *)request NS_DESIGNATED_INITIALIZER;

@end

#pragma mark - WindHCDataRequest

@interface WindHCDataRequest ()

- (WindHCDataRequest *)newRequestWithRange:(WindHCRange)range;
- (WindHCDataRequest *)newRequestWithTotalLength:(long long)totalLength;

@end

#pragma mark - WindHCDataResponse

@interface WindHCDataResponse ()

- (instancetype)initWithURL:(NSURL *)URL headers:(NSDictionary *)headers NS_DESIGNATED_INITIALIZER;

@end

#pragma mark - WindHCDataCacheItem

@interface WindHCDataCacheItem ()

- (instancetype)initWithURL:(NSURL *)URL
                      zones:(NSArray<WindHCDataCacheItemZone *> *)zones
                totalLength:(long long)totalLength
                cacheLength:(long long)cacheLength
                vaildLength:(long long)vaildLength NS_DESIGNATED_INITIALIZER;

@end

#pragma mark - WindHCDataCacheItemZone

@interface WindHCDataCacheItemZone ()

- (instancetype)initWithOffset:(long long)offset length:(long long)length NS_DESIGNATED_INITIALIZER;

@end
