//
//  MSCustomInterstitialAdapterProtocol.h
//  MSAdSDK
//
//  Created by leej on 2022/5/16.
//  Copyright © 2022 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCustomAdapterProtocol.h"
#import "MSCustomInterstitialEventProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MSCustomInterstitialAdapterProtocol <MSCustomAdapterProtocol>

@required

/**
 *  加载广告
 *  详解：pid - 广告位 id
 */
- (void)loadAd:(NSString *)pid interstitialEvent:(id<MSCustomInterstitialEventProtocol>)event;
/**
 *  显示广告
 *  详解：显示广告
 */
- (void)showAdFromVC:(UIViewController *)rootVC;
/**
 广告是否有效
 如果三方提供查询广告是否有效接口则用三方的，否则按照三方广告过期时长进行处理
 */
- (BOOL)isAdValid;

@optional
//释放广告资源
- (void)destoryInterstitialAd;
@end

NS_ASSUME_NONNULL_END
