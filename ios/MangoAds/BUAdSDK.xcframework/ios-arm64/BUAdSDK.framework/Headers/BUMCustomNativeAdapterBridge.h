//
//  BUMCustomNativeAdapterBridge.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import <Foundation/Foundation.h>
#import "BUMMediatedNativeAd.h"
#import "BUPlayerPublicDefine.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUMCustomNativeAdapter,NSString;

/// 自定义Native广告的adapter的回调协议
@protocol BUMCustomNativeAdapterBridge <NSObject>
@optional

#pragma mark - Load
/// 在非模板广告加载完成时调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param ads 广告数据组
/// @param exts 扩展数据组
- (void)nativeAd:(id<BUMCustomNativeAdapter>_Nonnull)adapter didLoadWithNativeAds:(NSArray<BUMMediatedNativeAd *> * _Nullable)ads exts:(NSArray<NSDictionary *> * _Nullable)exts;

/// 在模板广告加载完成时调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param views 广告视图数据组
/// @param exts 扩展数据组
- (void)nativeAd:(id<BUMCustomNativeAdapter>_Nonnull)adapter didLoadWithExpressViews:(NSArray<UIView *> * _Nullable)views exts:(NSArray<NSDictionary *> * _Nullable)exts;

/// 在广告加载失败时调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param error 错误信息
- (void)nativeAd:(id<BUMCustomNativeAdapter>_Nonnull)adapter didLoadFailWithError:(NSError *_Nullable)error;

/// 广告点击跳转使用的控制器
- (UIViewController *)viewControllerForPresentingModalView;

#pragma mark - View

/// 广告展示时调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param nativeAd 广告数据，native广告请传递原始数据（即BUMMediatedNativeAd.originMediatedNativeAd），express广告请传递上报GroMore的UIView
- (void)nativeAd:(id<BUMCustomNativeAdapter>_Nonnull)adapter didVisibleWithMediatedNativeAd:(id _Nonnull)nativeAd;

/// 广告点击事件时调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param nativeAd 广告数据，native广告请传递原始数据（即BUMMediatedNativeAd.originMediatedNativeAd），express广告请传递上报GroMore的UIView
- (void)nativeAd:(id<BUMCustomNativeAdapter>_Nonnull)adapter didClickWithMediatedNativeAd:(id _Nonnull)nativeAd;

/// 在广告即将展示详情页或者app store时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param nativeAd 广告数据，native广告请传递原始数据（即BUMMediatedNativeAd.originMediatedNativeAd），express广告请传递上报GroMore的UIView
- (void)nativeAd:(id<BUMCustomNativeAdapter>_Nonnull)adapter willPresentFullScreenModalWithMediatedNativeAd:(id _Nonnull)nativeAd;

/// 在广告落地页关闭时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param nativeAd 广告数据，native广告请传递原始数据（即BUMMediatedNativeAd.originMediatedNativeAd），express广告请传递上报GroMore的UIView
- (void)nativeAd:(id<BUMCustomNativeAdapter>_Nonnull)adapter didDismissFullScreenModalWithMediatedNativeAd:(id _Nonnull)nativeAd;

/// 广告摇一摇提示view消除时调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param nativeAd 广告数据，native广告请传递原始数据（即ABUMediatedNativeAd.originMediatedNativeAd），express广告请传递上报GroMore的UIView
- (void)nativeAd:(id<BUMCustomNativeAdapter>_Nonnull)adapter didShakeViewDismissWithNativeAd:(id _Nonnull)nativeAd;

/// 此方法在强制删除Ad视图容器时调用。
/// @param adapter 当前适配器
/// @param nativeAd 广告数据，native广告请传递原始数据（即ABUMediatedNativeAd.originMediatedNativeAd），express广告请传递上报GroMore的UIView
- (void)nativeAd:(id<BUMCustomNativeAdapter>_Nonnull)adapter adContainerViewDidRemovedWithNativeAd:(id _Nonnull)nativeAd;

#pragma mark - Express ad
/// 仅限模板广告，在渲染成功或者模板广告的尺寸更新时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param expressView 模板广告
- (void)nativeAd:(id<BUMCustomNativeAdapter>_Nonnull)adapter renderSuccessWithExpressView:(UIView *_Nonnull)expressView;

/// 仅限模板广告，在渲染失败调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param expressView 模板广告
- (void)nativeAd:(id<BUMCustomNativeAdapter>_Nonnull)adapter renderFailWithExpressView:(UIView *_Nonnull)expressView andError:(NSError *_Nonnull)error;

/// 仅限模板广告，在模板广告关闭的时候调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param expressView 模板广告
/// @param filterWords 用户手动关闭时的关闭原因描述
- (void)nativeAd:(id<BUMCustomNativeAdapter>_Nonnull)adapter didCloseWithExpressView:(UIView *_Nonnull)expressView closeReasons:(NSArray<NSString *> *_Nullable)filterWords;

#pragma mark - non-Express ad
/// 仅限非模板广告，在非模板广告点击不喜欢原因后调用
/// @param adapter 当前适配器
/// @param nativeAd 广告数据，native广告请传递原始数据（即ABUMediatedNativeAd.originMediatedNativeAd）
/// @param filterWords 用户手动关闭时的关闭原因描述
- (void)nativeAd:(id<BUMCustomNativeAdapter>_Nonnull)adapter dislikeWithMediatedNativeAd:(id _Nonnull)nativeAd closeReasons:(NSArray<NSString *> *_Nullable)filterWords;

#pragma mark - video

/// 视频广告中视频播放状态变更的时候调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param state 播放状态
/// @param nativeAd 广告数据，native广告请传递原始数据（即BUMMediatedNativeAd.originMediatedNativeAd），express广告请传递上报GroMore的UIView
- (void)nativeAd:(id<BUMCustomNativeAdapter>_Nonnull)adapter videoStateDidChangedWithState:(BUPlayerPlayState)state andNativeAd:(id _Nonnull)nativeAd;

/// 激励信息流视频进入倒计时状态时调用
/// @param adapter 当前适配器
/// @param countDown : 倒计时
/// @Note : 当前该回调仅适用于CSJ广告
- (void)nativeAd:(id<BUMCustomNativeAdapter>_Nonnull)adapter rewardDidCountDown:(NSInteger)countDown andNativeAd:(id _Nonnull)nativeAd;

/// 视频广告中视频视图被点击时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param nativeAd 广告数据，native广告请传递原始数据（即BUMMediatedNativeAd.originMediatedNativeAd），express广告请传递上报GroMore的UIView
- (void)nativeAd:(id<BUMCustomNativeAdapter>_Nonnull)adapter videoDidClick:(id _Nonnull)nativeAd;

/// 视频广告中视频播放完成时调用，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param nativeAd 广告数据，native广告请传递原始数据（即BUMMediatedNativeAd.originMediatedNativeAd），express广告请传递上报GroMore的UIView
- (void)nativeAd:(id<BUMCustomNativeAdapter>_Nonnull)adapter videoDidPlayFinish:(id _Nonnull)nativeAd;

@end

NS_ASSUME_NONNULL_END
