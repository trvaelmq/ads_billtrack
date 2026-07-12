//
//  WindHCDataSourceManager.h
//  WindHTTPCache
//
//  Created by Single on 2017/8/11.
//  Copyright © 2017年 Single. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WindHCDataNetworkSource.h"
#import "WindHCDataFileSource.h"

@class WindHCDataSourceManager;

@protocol WindHCDataSourceManagerDelegate <NSObject>

- (void)wind_sourceManagerDidPrepare:(WindHCDataSourceManager *)sourceManager;
- (void)wind_sourceManagerHasAvailableData:(WindHCDataSourceManager *)sourceManager;
- (void)wind_sourceManager:(WindHCDataSourceManager *)sourceManager didFailWithError:(NSError *)error;
- (void)wind_sourceManager:(WindHCDataSourceManager *)sourceManager didReceiveResponse:(WindHCDataResponse *)response;

@end

@interface WindHCDataSourceManager : NSObject <WindHCDataSource>

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithSources:(NSArray<id<WindHCDataSource>> *)sources
                       delegate:(id <WindHCDataSourceManagerDelegate>)delegate
                  delegateQueue:(dispatch_queue_t)delegateQueue NS_DESIGNATED_INITIALIZER;

@property (nonatomic, weak, readonly) id <WindHCDataSourceManagerDelegate> delegate;
@property (nonatomic, strong, readonly) dispatch_queue_t delegateQueue;

@end
