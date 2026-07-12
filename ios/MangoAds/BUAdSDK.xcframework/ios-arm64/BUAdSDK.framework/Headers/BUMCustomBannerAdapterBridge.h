//
//  BUMCustomBannerAdapterBridge.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import <Foundation/Foundation.h>
#import "BUMCustomAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUMCustomBannerAdapter;

/// 自定义banner广告的回调代理协议
@protocol BUMCustomBannerAdapterBridge <NSObject>
@optional

/// 在广告加载成功时调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param bannerView 广告视图
/// @param ext 回传信息
- (void)bannerAd:(id<BUMCustomBannerAdapter>)adapter didLoad:(UIView *)bannerView ext:(NSDictionary *)ext;

/// 在广告加载失败时调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param error 错误信息
/// @param ext 回传信息
- (void)bannerAd:(id<BUMCustomBannerAdapter>)adapter didLoadFailWithError:(NSError *_Nullable)error ext:(NSDictionary *)ext;

/// 在广告已经展示的时候调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param bannerView 广告视图
- (void)bannerAdDidBecomeVisible:(id<BUMCustomBannerAdapter>)adapter bannerView:(UIView *)bannerView;

/// 在广告弹出详情页或者展示展示appstore时调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param bannerView 广告视图
- (void)bannerAdWillPresentFullScreenModal:(id<BUMCustomBannerAdapter>)adapter bannerView:(UIView *)bannerView;

/// 在广告关闭详情页或者appstore时调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param bannerView 广告视图
- (void)bannerAdWillDismissFullScreenModal:(id<BUMCustomBannerAdapter>)adapter bannerView:(UIView *)bannerView;

/// 在广告触发点击事件时调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param bannerView 广告视图
- (void)bannerAdDidClick:(id<BUMCustomBannerAdapter>)adapter bannerView:(UIView *)bannerView;

/// 在广告关闭时调用该方法，直接调用即可，无需做响应判断
/// @param adapter 当前适配器
/// @param bannerView 广告视图
/// @param filterWords 用户手动关闭时的关闭原因描述
- (void)bannerAd:(id<BUMCustomBannerAdapter>)adapter bannerView:(UIView *)bannerView didClosedWithDislikeWithReason:(NSArray<NSString *> *_Nullable)filterWords;

/// 广告点击跳转使用的控制器
- (UIViewController *)viewControllerForPresentingModalView;
@end

NS_ASSUME_NONNULL_END
