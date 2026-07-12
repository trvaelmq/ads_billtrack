//
//  WindHCDataFileSource.h
//  WindHTTPCache
//
//  Created by Single on 2017/8/11.
//  Copyright © 2017年 Single. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WindHCDataSource.h"

@class WindHCDataFileSource;

@protocol WindHCDataFileSourceDelegate <NSObject>

- (void)wind_fileSourceDidPrepare:(WindHCDataFileSource *)fileSource;
- (void)wind_fileSource:(WindHCDataFileSource *)fileSource didFailWithError:(NSError *)error;

@end

@interface WindHCDataFileSource : NSObject <WindHCDataSource>

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithPath:(NSString *)path range:(WindHCRange)range readRange:(WindHCRange)readRange NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy, readonly) NSString *path;
@property (nonatomic, readonly) WindHCRange readRange;

@property (nonatomic, weak, readonly) id<WindHCDataFileSourceDelegate> delegate;
@property (nonatomic, strong, readonly) dispatch_queue_t delegateQueue;

- (void)setDelegate:(id<WindHCDataFileSourceDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue;

@end
