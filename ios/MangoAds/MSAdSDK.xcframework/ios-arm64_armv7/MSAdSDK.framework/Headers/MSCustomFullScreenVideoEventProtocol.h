//
//  MSCustomFullScreenVideoEventProtocol.h
//  MSAdSDK
//
//  Created by leej on 2022/5/19.
//  Copyright © 2022 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSCustomFullScreenVideoEventProtocol <NSObject>

@required
/**
 全屏视频广告物料加载成功调用
 */
- (void)msCustomFullScreenVideoAdLoadSuccess;
/**
 全屏视频广告物料加载失败调用
 */
- (void)msCustomFullScreenVideoAdLoadFail:(NSError *)error;
/**
 全屏视频缓存成功调用
 */
- (void)msCustomFullScreenVideoAdCacheSuccess;
/**
 全屏视频缓存失败调用
 */
- (void)msCustomFullScreenVideoAdCacheFailed:(NSError *)error;
/**
 全屏视频开始播放调用
 */
- (void)msCustomFullScreenVideoAdDidStarted;
/**
 全屏视频展示成功调用
 */
- (void)msCustomFullScreenVideoAdShowSuccess:(UIView *_Nullable)adView;
/**
 全屏视频展示失败调用
 */
- (void)msCustomFullScreenVideoAdShowFailed:(NSError *)error;
/**
 全屏视频播放完成或视频播放途中发生异常错误调用
 */
- (void)msCustomFullScreenVideoAdDidPlayFinish:(NSError *)error;
/**
 全屏视频已被关闭调用
 */
- (void)msCustomFullScreenVideoAdDidCloseWithPlayingProgress:(CGFloat)progress;
/**
 全屏视频跳过按钮被点击调用
 */
- (void)msCustomFullScreenVideoAdDidSkipWithPlayingProgress:(CGFloat)progress;
/**
 全屏视频被点击调用
 */
- (void)msCustomFullScreenVideoAdDidClick:(UIView *_Nullable)adView withPlayingProgress:(CGFloat)progress;
@end

NS_ASSUME_NONNULL_END
