//
//  BUMCustomFullscreenVideoAdapterBridge.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import <Foundation/Foundation.h>
#import "BUMAdapterRewardAdInfo.h"

NS_ASSUME_NONNULL_BEGIN
@protocol BUMCustomFullscreenVideoAdapter;

/// 自定义全屏视频广告的adapter的回调协议
@protocol BUMCustomFullscreenVideoAdapterBridge <NSObject>
@optional

/// 在广告加载完成时调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param ext 回传信息
- (void)fullscreenVideoAd:(id<BUMCustomFullscreenVideoAdapter>_Nonnull)adapter didLoadWithExt:(NSDictionary *)ext;

/// 在广告加载失败时调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param error 错误信息
/// @param ext 回传信息
- (void)fullscreenVideoAd:(id<BUMCustomFullscreenVideoAdapter>_Nonnull)adapter didLoadFailWithError:(NSError *_Nullable)error ext:(NSDictionary *)ext;

/// 在广告中视频素材加载完成时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
- (void)fullscreenVideoAdVideoDidLoad:(id<BUMCustomFullscreenVideoAdapter>_Nonnull)adapter;

/// 在广告已经展示时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
- (void)fullscreenVideoAdDidVisible:(id<BUMCustomFullscreenVideoAdapter>_Nonnull)adapter;

/// 广告展示失败的时候调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param error 错误信息
- (void)fullscreenVideoAdDidShowFailed:(id<BUMCustomFullscreenVideoAdapter>)adapter error:(NSError *)error;

/// 在广告关闭时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
- (void)fullscreenVideoAdDidClose:(id<BUMCustomFullscreenVideoAdapter>_Nonnull)adapter;

/// 在广告点击事件触发时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
- (void)fullscreenVideoAdDidClick:(id<BUMCustomFullscreenVideoAdapter>_Nonnull)adapter;

/// 在广告即将展示详情页或者app store时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
- (void)fullscreenVideoAdWillPresentFullscreenModal:(id<BUMCustomFullscreenVideoAdapter>_Nonnull)adapter;

/// 在广告视频播放完成时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param error 错误信息
- (void)fullscreenVideoAd:(id<BUMCustomFullscreenVideoAdapter>_Nonnull)adapter didPlayFinishWithError:(nullable NSError *)error;

/// 在广告被点击跳过时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
- (void)fullscreenVideoAdDidClickSkip:(id<BUMCustomFullscreenVideoAdapter>_Nonnull)adapter;

/// 在模板广告渲染成功时调用，非模板广告无需调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
- (void)fullscreenVideoAdRenderSuccess:(id<BUMCustomFullscreenVideoAdapter>_Nonnull)adapter;

/// 在广告渲染失败时调用，非模板广告无需调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param error 错误信息
- (void)fullscreenVideoAd:(id<BUMCustomFullscreenVideoAdapter>_Nonnull)adapter renderFailedWithError:(NSError *)error;

/// 广告点击跳转使用的控制器
- (UIViewController *)viewControllerForPresentingModalView;

/// 在ADN验证激励成功时调用，直接调用即可，无需做响应判断：目前支持的adn:GDT
/// @param adapter 当前适配器
/// @param infoBuilder 激励信息
- (void)rewardedVideoAd:(id<BUMCustomFullscreenVideoAdapter>_Nonnull)adapter didServerRewardSuccessWithInfo:(void(^)(BUMAdapterRewardAdInfo *info))infoBuilder;

@end

NS_ASSUME_NONNULL_END
