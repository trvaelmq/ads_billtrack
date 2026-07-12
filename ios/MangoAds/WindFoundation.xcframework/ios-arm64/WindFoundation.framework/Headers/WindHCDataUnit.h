//
//  WindHCDataUnit.h
//  WindHTTPCache
//
//  Created by Single on 2017/8/11.
//  Copyright © 2017年 Single. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WindHCDataUnitItem.h"

@class WindHCDataUnit;

@protocol WindHCDataUnitDelegate <NSObject>

- (void)wind_unitDidChangeMetadata:(WindHCDataUnit *)unit;

@end

@interface WindHCDataUnit : NSObject <NSCoding, NSLocking>

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithURL:(NSURL *)URL;

@property (nonatomic, copy, readonly) NSError *error;

@property (nonatomic, copy, readonly) NSURL *URL;
@property (nonatomic, copy, readonly) NSURL *completeURL;
@property (nonatomic, copy, readonly) NSString *key;       // Unique Identifier.
@property (nonatomic, copy, readonly) NSDictionary *responseHeaders;
@property (nonatomic, readonly) NSTimeInterval createTimeInterval;
@property (nonatomic, readonly) NSTimeInterval lastItemCreateInterval;
@property (nonatomic, readonly) long long totalLength;
@property (nonatomic, readonly) long long cacheLength;
@property (nonatomic, readonly) long long validLength;

/**
 *  Unit Item
 */
- (NSArray<WindHCDataUnitItem *> *)unitItems;
- (void)insertUnitItem:(WindHCDataUnitItem *)unitItem;

/**
 *  Info Sync
 */
- (void)updateResponseHeaders:(NSDictionary *)responseHeaders totalLength:(long long)totalLength;

/**
 *  Working
 */
@property (nonatomic, readonly) NSInteger workingCount;

- (void)workingRetain;
- (void)workingRelease;

/**
 *  File Control
 */
@property (nonatomic, weak) id <WindHCDataUnitDelegate> delegate;

- (void)deleteFiles;

@end
