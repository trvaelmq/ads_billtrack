//
//  MSInterstitialAd.h
//  MSAdSDK
//
//  Created by Liumaos on 2020/7/23.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSInterstitialDelegate.h"
#import "MSBaseAd.h"
#import "MSBaseAdConfigParams.h"
NS_ASSUME_NONNULL_BEGIN

@interface MSInterstitialAd : MSBaseAd
/**
 * 插屏基础回调代理
 */
@property(nonatomic,weak) id<MSInterstitialDelegate> delegate;
/**
 * 插屏扩展回调代理
 * 如不需要扩展回调相关功能，可不用指定
 */
@property(nonatomic,weak) id<MSInterstitialExtensionFunctionDelegate> extDelegate;
/**
 *  加载广告
 *  @param pid             广告位id  [必传]
 *  @param adParams 广告参数  [必传]
 */
- (void)loadAdWithPid:(NSString *)pid adConfigParams:(MSInterstitialAdConfigParams *)adParams;
/**
 *  显示广告
 *  @param presentVC  【必传】
 */
- (void)showAdFromRootViewController:(UIViewController *)presentVC;
/**
 广告是否有效
 注意：调用show接口前建议先检测广告是否有效
 */
- (BOOL)isAdValid;
/**
 广告价格  单位：分 [C2S下，返回渠道出价，非C2S下，返回平台填写的固价]
 注意：广告加载成功后获取
 */
- (NSInteger)ecpm;
@end

NS_ASSUME_NONNULL_END
