//
//  MSCustomVideoAdapterProtocol.h
//  MSAdSDK
//
//  Created by leej on 2022/5/18.
//  Copyright © 2022 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCustomAdapterProtocol.h"
#import "MSCustomVideoEventProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MSCustomVideoAdapterProtocol <MSCustomAdapterProtocol>

@required
/**
 *  加载广告
 *  详解：pid - 广告位 id
 */
- (UIView *)loadAndShow:(NSString *)pid
              presentVC:(UIViewController *)presentVC
                 adSize:(CGSize)adSize
             videoEvent:(id<MSCustomVideoEventProtocol>)event;
/**
 静音
 */
- (void)muteVideo:(BOOL)mute;
/**
 * 播放视频
 */
- (void)playVideo;
/**
 * 暂停视频
 */
- (void)pauseVideo;
/**
 * 调整视频大小
 */
- (void)reSize:(CGRect)frame;
/**
 广告是否有效
 如果三方提供查询广告是否有效接口则用三方的，否则按照三方广告过期时长进行处理
 */
-(BOOL)isAdValid;
/**
 视频总时长 单位：秒
 */
-(NSTimeInterval)totalVideoTime;
/**
 视频播放时长 单位：秒
 */
-(NSTimeInterval)currentPlayTime;
/**
 更新vc 
 */
-(void)updatePlatformAdPresentVc:(UIViewController *)presentVC;
@end

NS_ASSUME_NONNULL_END
