//
//  SFVideoConfig.h
//  MSaas
//
//  Created by lurich on 2021/10/27.
//

#import <Foundation/Foundation.h>
#import "SFFeedAdData.h"

/// 视频声音控制宏
#define MSaasVideoMuteEnable      @"MSaasVideoMuteEnable"
/// 视频播放控制宏
#define MSaasVideoPlayEnable      @"MSaasVideoPlayEnable"
/// 获取 BOOL 值的Key
#define MSaasVideoEnableSwitchKey @"MSaasVideoEnableSwitchKey"


/// 释放指定播放器的Key（广告类请求ID）
#define MSaasVideoFreePlayerKey   @"MSaasVideoFreePlayerKey"
/// 释放视频播放器
#define MSaasVideoFreePlayerName  @"MSaasVideoFreePlayerName"

typedef NS_ENUM(NSInteger, SFVideoAutoPlayPolicy) {
    SFVideoAutoPlayPolicyWIFI   = 0, // WIFI 下自动播放
    SFVideoAutoPlayPolicyAlways = 1, // 总是自动播放，无论网络条件
    SFVideoAutoPlayPolicyNever  = 2, // 从不自动播放，无论网络条件
};

NS_ASSUME_NONNULL_BEGIN

@interface SFVideoConfig : NSObject

/**
 *  视频自动播放策略，默认 SFVideoAutoPlayPolicyAlways,
 *  选择 SFVideoAutoPlayPolicyNever 策略时，需要开发者手动控制视频播放/暂停
 *
 *  播放控制 MSaasVideoPlayEnable  YES：播放； NO：暂停
 *  [[NSNotificationCenter defaultCenter] postNotificationName:MSaasVideoPlayEnable object:nil userInfo:@{MSaasVideoEnableSwitchKey:@(status)}];
 */
@property (nonatomic, assign) SFVideoAutoPlayPolicy autoPlayPolicy;

/**
 *  自动播放时，是否静音。默认 YES。loadAd 前设置。
 *
 *  声音实时控制 MSaasVideoMuteEnable  YES：静音； NO：有声
 *  [[NSNotificationCenter defaultCenter] postNotificationName:MSaasVideoMuteEnable object:nil userInfo:@{MSaasVideoEnableSwitchKey:@(status)}];
 */
@property (nonatomic, assign) BOOL videoMuted;

/**
 *  由SDK控制视频是否静音。 默认NO
 * */
@property (nonatomic, assign) BOOL isVideoMutedConfig;

/**
 *  是否循环播放视频广告，默认YES
 * */
@property (nonatomic, assign) BOOL replay;

/**
 *  sdk渲染全屏视频
 * */
-(void) renderFullScreenVideoWithUrl: (SFFeedAdData *) adData completeBlock: (void(^)(BOOL result)) completeBlock;

@end

NS_ASSUME_NONNULL_END
