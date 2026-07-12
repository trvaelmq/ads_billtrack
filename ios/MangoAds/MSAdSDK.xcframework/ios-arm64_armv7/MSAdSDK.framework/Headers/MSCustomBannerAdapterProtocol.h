//
//  MSCustomBannerAdapterProtocol.h
//  MSAdSDK
//
//  Created by leej on 2022/5/17.
//  Copyright © 2022 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MSCustomAdapterProtocol.h"
#import "MSCustomBannerEventProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MSCustomBannerAdapterProtocol <MSCustomAdapterProtocol>

@required
/**
 *  加载广告
 *  详解：pid - 广告位 id
 */
- (UIView *)loadAndShow:(NSString *)pid
              presentVC:(UIViewController *)presentVC
                 adSize:(CGSize)adSize
            bannerEvent:(id<MSCustomBannerEventProtocol>)event;
@optional
- (void)updateCustomAdapterCurrentPresentVC:(UIViewController *)presentVC;
@end

NS_ASSUME_NONNULL_END
