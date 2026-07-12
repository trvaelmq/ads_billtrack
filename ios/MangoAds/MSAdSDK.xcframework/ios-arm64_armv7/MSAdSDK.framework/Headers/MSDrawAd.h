//
//  MSDrawAd.h
//  MSAdSDK
//
//  Created by leej on 2022/2/17.
//  Copyright © 2022 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSBaseAd.h"
#import "MSDrawAdDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSDrawAd : MSBaseAd
/**
 DrawAd基础回调代理
 传入时机：加载广告前传入
 */
@property(nonatomic,weak)id<MSDrawAdDelegate> delegate;
/**
 DrawAd扩展回调代理
 传入时机：加载广告前传入
 如不需要扩展回调相关功能，可不用指定
 */
@property(nonatomic,weak)id<MSDrawAdExtensionFunctionDelegate> extDelegate;
/**
 加载广告
 @param pid             广告位id  必传
 @param adParams  广告参数  必传
 */
- (void)loadAdWithPid:(NSString *)pid adConfigParams:(MSDrawAdConfigParams *)adParams;
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
 当前播放时间 仅ms、广点通平台有效
 @return 当前播放时间
 获取时机；调用showAdViewInContainer之后
 */
- (NSTimeInterval)currentTime;
/**
 视频总时长 仅ms、广点通平台有效
 @return 视频总时长
 获取时机；调用showAdViewInContainer之后
 */
- (NSTimeInterval)duration;
/**
 广告是否有效
 注意：展示广告前建议先检测广告是否有效
 */
- (BOOL)isAdValid;
/**
 广告价格  单位：分 [C2S下，返回渠道出价，非C2S下，返回平台填写的固价]
 注意：广告加载成功后获取
 */
- (NSInteger)ecpm;

@end

NS_ASSUME_NONNULL_END
