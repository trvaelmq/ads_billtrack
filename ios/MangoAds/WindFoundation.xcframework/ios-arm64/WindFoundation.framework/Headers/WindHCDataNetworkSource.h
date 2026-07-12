//
//  WindHCDataNetworkSource.h
//  WindHTTPCache
//
//  Created by Single on 2017/8/11.
//  Copyright © 2017年 Single. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WindHCDataSource.h"
#import "WindHCDataRequest.h"
#import "WindHCDataResponse.h"

@class WindHCDataNetworkSource;

@protocol WindHCDataNetworkSourceDelegate <NSObject>

- (void)wind_networkSourceDidPrepare:(WindHCDataNetworkSource *)networkSource;
- (void)wind_networkSourceHasAvailableData:(WindHCDataNetworkSource *)networkSource;
- (void)wind_networkSourceDidFinisheDownload:(WindHCDataNetworkSource *)networkSource;
- (void)wind_networkSource:(WindHCDataNetworkSource *)networkSource didFailWithError:(NSError *)error;

@end

@interface WindHCDataNetworkSource : NSObject <WindHCDataSource>

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithRequest:(WindHCDataRequest *)reqeust NS_DESIGNATED_INITIALIZER;

@property (nonatomic, strong, readonly) WindHCDataRequest *request;
@property (nonatomic, strong, readonly) WindHCDataResponse *response;

@property (nonatomic, weak, readonly) id<WindHCDataNetworkSourceDelegate> delegate;
@property (nonatomic, strong, readonly) dispatch_queue_t delegateQueue;

- (void)setDelegate:(id<WindHCDataNetworkSourceDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue;

@end
