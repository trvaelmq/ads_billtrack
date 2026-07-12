//
//  MSNativeFeedAd.h
//  MSAdSDK
//
//  Created by leej on 2021/7/31.
//  Copyright © 2021 Adxdata. All rights reserved.
//
#import "MSBaseAd.h"
#import "MSBaseAdConfigParams.h"
#import "MSNativeFeedAdDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface MSNativeFeedAd : MSBaseAd
/**
 * 信息流混合广告基础回调代理
 */
@property(nonatomic,weak) id<MSNativeFeedAdDelegate> delegate;
/**
 * 信息流混合广告扩展回调代理
 * 如不需要扩展回调相关功能，可不用指定
 */
@property(nonatomic,weak) id<MSNativeFeedAdExtensionFunctionDelegate> extDelegate;
/**
 *  广告发起请求方法
 *  @param pid          广告位ID 【必传】
 *  @param adParam 广告参数 【必传】
 */
- (void)loadAdWithPid:(NSString *)pid adParam:(MSNativeFeedAdConfigParams *)adParam;

@end

NS_ASSUME_NONNULL_END
