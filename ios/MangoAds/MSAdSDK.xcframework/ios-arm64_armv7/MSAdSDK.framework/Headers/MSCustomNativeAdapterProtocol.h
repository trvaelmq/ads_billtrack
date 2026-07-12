//
//  MSCustomNativeAdapterProtocol.h
//  MSAdSDK
//
//  Created by leej on 2022/5/20.
//  Copyright © 2022 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCustomAdapterProtocol.h"
#import "MSCustomNativeEventProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MSCustomNativeAdapterProtocol <MSCustomAdapterProtocol>
@required
/**
 *  加载广告
 *  详解：pid - 广告位 id
 */
- (void)loadAdPid:(NSString *)pid
          adCount:(NSInteger)adCount
        presentVC:(UIViewController *)presentVC
            event:(id<MSCustomNativeEventProtocol>)event;

@optional
//更新vc
- (void)updateCustomAdapterCurrentPresentVC:(UIViewController *)presentVC;
@end

NS_ASSUME_NONNULL_END
