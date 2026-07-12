//
//  MSCustomDrawEventProtocol.h
//  MSAdSDK
//
//  Created by leej on 2022/5/19.
//  Copyright © 2022 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSCustomDrawEventProtocol <NSObject>

@required
/**
 DrawAd广告物料加载成功调用
 */
- (void)msCustomDrawAdLoadSuccess;
/**
 DrawAd广告物料加载失败调用
 */
- (void)msCustomDrawAdLoadFailError:(NSError *)error;
/**
 视频缓存成功调用
 */
- (void)msCustomDrawAdVideoCacheSuccess;
/**
 视频缓存失败调用
 */
- (void)msCustomDrawAdVideoCacheFailedError:(NSError *)error;
/**
 视频展示成功调用
 */
- (void)msCustomDrawAdVideoShowSuccess:(UIView *)adView;
/**
 视频展示失败调用
 */
- (void)msCustomDrawAdVideoShowFailedError:(NSError *)error;
/**
 视频准备开始播放调用
 */
- (void)msCustomDrawAdVideoDidStartPlaying;
/**
 视频暂停播放调用
 */
- (void)msCustomDrawAdVideoDidPause;
/**
 视频重播调用
 */
- (void)msCustomDrawAdVideoDidReplay;
/**
 视频播放完成调用
 */
- (void)msCustomDrawAdVideoDidComplete;
/**
 视频播放失败调用
 */
- (void)msCustomDrawAdVideoPlayingFailedError:(NSError *)error;
/**
 视频被点击调用
 */
- (void)msCustomDrawAdVideoDidClick:(UIView *)adView;
/**
 视频被关闭调用
 */
- (void)msCustomDrawAdVideoDidClosed:(UIView *)adView;
/**
 广告落地页已经关闭调用
 */
- (void)msCustomDrawAdVideoDetailClosed;
@end

NS_ASSUME_NONNULL_END
