//
//  BUMNativeExpressAdViewDelegate.h
//  BUAdSDK
//
//  Created by 🦁 on 2023/12/18.
//

#import "BUNativeExpressAdViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUMNativeExpressAdViewDelegate <BUNativeExpressAdViewDelegate>

@optional

/// 广告摇一摇提示view消除时调用该方法
/// @param nativeExpressAdView 广告视图
- (void)nativeExpressAdViewShakeViewDidDismiss:(BUNativeExpressAdView *_Nullable)nativeExpressAdView;

/// 激励信息流视频进入倒计时状态时调用
/// @param nativeExpressAdView 广告视图
/// @param countDown : 倒计时
/// @Note : 当前该回调仅适用于CSJ广告 - v4200
- (void)nativeExpressAdViewVideo:(BUNativeExpressAdView *_Nullable)nativeExpressAdView rewardDidCountDown:(NSInteger)countDown;

/// 广告视图中视频视图被点击时触发
/// @param nativeExpressAdView 广告视图
- (void)nativeExpressAdViewVideoDidClick:(BUNativeExpressAdView *_Nullable)nativeExpressAdView;

@end

NS_ASSUME_NONNULL_END
