//
//  BUMCustomSplashAdapterBridge.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import <Foundation/Foundation.h>
#import "BUMCardViewProperty.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUMCustomSplashAdapter;

/// 自定义开屏广告的adapter的回调协议
@protocol BUMCustomSplashAdapterBridge <NSObject>
@optional

/// 在广告加载完成时调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param ext 回传信息
- (void)splashAd:(id<BUMCustomSplashAdapter>_Nonnull)adapter didLoadWithExt:(NSDictionary *)ext;

/// 在广告加载失败时调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param error 错误信息
/// @param ext 回传信息
- (void)splashAd:(id<BUMCustomSplashAdapter>_Nonnull)adapter didLoadFailWithError:(NSError *_Nullable)error ext:(NSDictionary *)ext;

/// 在广告加载完成后如果存在cardView时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param view cardView
- (void)splashAd:(id<BUMCustomSplashAdapter>)adapter hasCardView:(UIView *)view withProperty:(void(^)(BUMCardViewProperty *prop))property;

/// 在广告即将展示时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
- (void)splashAdWillVisible:(id<BUMCustomSplashAdapter>_Nonnull)adapter;

/// 广告展示失败的时候调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param error 错误信息
- (void)splashAdDidShowFailed:(id<BUMCustomSplashAdapter>)adapter error:(NSError *)error;

/// 在广告点击事件触发时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
- (void)splashAdDidClick:(id<BUMCustomSplashAdapter>_Nonnull)adapter;

/// 在广告被点击跳过时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
- (void)splashAdDidClickSkip:(id<BUMCustomSplashAdapter>_Nonnull)adapter;

/// 在广告关闭时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
- (void)splashAdDidClose:(id<BUMCustomSplashAdapter>_Nonnull)adapter;

/// 在广告关闭时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
- (void)splashAdDidClose:(id<BUMCustomSplashAdapter>_Nonnull)adapter withType:(BUSplashAdCloseType)closeType;

/// 在广告控制器关闭时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @Note 如对应adn未提供该类型回调，可在开屏广告关闭DidClose后回传该回调，保持逻辑完整
- (void)splashAdViewControllerDidClose:(id<BUMCustomSplashAdapter>_Nonnull)adapter;

/// 在广告即将展示详情页或者app store时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
- (void)splashAdWillPresentFullScreenModal:(id<BUMCustomSplashAdapter>_Nonnull)adapter;

/// 在广告关闭详情页或者app store时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
- (void)splashAdWillDismissFullScreenModal:(id<BUMCustomSplashAdapter>_Nonnull)adapter;

/// 在模板广告渲染成功时调用，非模板广告无需调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
- (void)splashAdDidRenderSuccess:(id<BUMCustomSplashAdapter>_Nonnull)adapter;

/// 在广告渲染失败时调用，非模板广告无需调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param error 错误信息
- (void)splashAd:(id<BUMCustomSplashAdapter>_Nonnull)adapter didRenderFailedWithError:(NSError *)error;

/// 在广告倒计时结束时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
- (void)splashAdDidCountDownToZero:(id<BUMCustomSplashAdapter>_Nonnull)adapter;

/// 在广告视频播放完成或者出错时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param error 播放错误
- (void)splashAd:(id<BUMCustomSplashAdapter>_Nonnull)adapter didPlayFinishWithError:(NSError *)error;

/// 广告点击跳转使用的控制器
- (UIViewController *)viewControllerForPresentingModalView;
@end

/// 开屏广告cardView 视图协议
@protocol BUMCustomSplashAdapterCardViewBridge <NSObject>

/// 当zoom out 视图点击时调用，直接调用即可，无需做响应判断
/// @param splashCardView cardView 视图
- (void)adapterAdSplashCardViewDidClick:(UIView *_Nonnull)splashCardView;

/// 当zoom out 视图关闭时调用，直接调用即可，无需做响应判断
/// @param splashCardView cardView 视图
- (void)adapterAdSplashCardViewDidClose:(UIView *_Nonnull)splashCardView;

/// 当zoom out 在广告已经展示详情页或者app store时调用，直接调用即可，无需做响应判断
/// @param splashCardView cardView 视图
- (void)adapterAdSplashCardViewDidPresentFullScreenModal:(UIView *_Nonnull)splashCardView;

/// 当zoom out 在广告已经关闭详情页或者app store时调用，直接调用即可，无需做响应判断
/// @param splashCardView cardView 视图
- (void)adapterAdSplashCardViewDidDismissFullScreenModal:(UIView *_Nonnull)splashCardView;

@end

NS_ASSUME_NONNULL_END
