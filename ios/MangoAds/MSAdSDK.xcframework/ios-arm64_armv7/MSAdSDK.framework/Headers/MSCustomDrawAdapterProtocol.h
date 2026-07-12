//
//  MSCustomDrawAdapterProtocol.h
//  MSAdSDK
//
//  Created by leej on 2022/5/19.
//  Copyright © 2022 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCustomAdapterProtocol.h"
#import "MSCustomDrawEventProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MSCustomDrawAdapterProtocol <MSCustomAdapterProtocol>

@required
/**
 *  加载广告
 *  详解：pid - 广告位 id
 */
- (void)loadAdPid:(NSString *)pid
            presentVC:(UIViewController *)presentVC
               adSize:(CGSize)adSize
           videoEvent:(id<MSCustomDrawEventProtocol>)event;
/**
 展示draw广告
 @param container 展示draw广告的view 此参数必传
 注意：container的size务必和传入的adSize保持一致，否则会展示异常
 */
- (void)showAdViewInContainer:(UIView *)container presentVC:(UIViewController *)presentVC;
/**
 不再展示draw广告
 注意：不再展示该广告时，务必调用该接口
 */
- (void)dismissDrawAdView;
/**
 播放视频
 设置时机：调用showAdViewInContainer后设置有效
 */
- (void)play;
/**
 暂停播放
 设置时机：调用showAdViewInContainer后设置有效
 */
- (void)pause;
/**
 销毁播放器,释放广告对象时务必调用该方法
 */
- (void)stop;
/**
 设置静音
 设置时机：调用showAdViewInContainer后设置有效
 @param mute YES静音   NO非静音
 */
- (void)setVideoMute:(BOOL)mute;
/**
 当前播放时间 单位：秒
 @return 当前播放时间
 获取时机；调用showAdViewInContainer之后
 */
- (NSTimeInterval)currentTime;
/**
 视频总时长 单位：秒
 @return 视频总时长
 获取时机；调用showAdViewInContainer之后
 */
- (NSTimeInterval)duration;

@optional
//更新vc
- (void)updateCustomAdapterCurrentPresentVC:(UIViewController *)presentVC;
@end

NS_ASSUME_NONNULL_END
