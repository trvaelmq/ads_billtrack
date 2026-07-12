//
//  MSFeedVideoDelegate.h
//  MSAdSDK
//
//  Created by lj on 2020/9/1.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSFeedVideoDelegate <NSObject>
@optional
//视频播放完成
- (void)msFeedVideoFinish;
//视频开始播放
- (void)msFeedVideoStart;
//视频暂停播放
- (void)msFeedVideoPause;
//视频恢复播放
- (void)msFeedVideoResume;
/// 视频播放进度
/// - Parameters:
///   - progress: 播放进度百分比 取值[0~100%]
///   - currentTime: 当前播放时间
///   - totalTime:   视频总时长
- (void)msFeedVideoPlayingProgress:(CGFloat)progress currentTime:(CGFloat)currentTime totalTime:(CGFloat)totalTime;
//视频播放出错
- (void)msFeedVideoError:(NSError *)error;
@end

NS_ASSUME_NONNULL_END
