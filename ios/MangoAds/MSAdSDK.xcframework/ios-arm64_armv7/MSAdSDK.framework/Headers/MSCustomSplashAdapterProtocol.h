//
//  MSCustomSplashAdapterProtocol.h
//  MSAdSDK
//
//  Created by leej on 2022/4/26.
//  Copyright © 2022 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCustomSplashEventProtocol.h"
#import "MSCustomAdapterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MSCustomSplashAdapterProtocol <MSCustomAdapterProtocol>

@required
/**
 加载广告
 */
- (void)loadSplashAd:(NSString *)pid
         splashEvent:(id<MSCustomSplashEventProtocol>)event;
/**
 展示开屏广告
 */
- (void)showSplashAd:(UIWindow *)window bottomView:(UIView *)bottomView;
/**
 广告是否有效
 如果三方提供查询广告是否有效接口则用三方的，否则按照三方广告过期时长进行处理
 */
- (BOOL)isAdValid;

@optional
/**
 移除开屏广告，返回代表移除是否成功
 */
- (BOOL)removeSplashAdView;
@end

NS_ASSUME_NONNULL_END
