//
//  MSVideoAd.h
//  MSAdSDK
//
//  Created by Liumaos on 2020/7/23.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSVideoAdDelegate.h"
#import "MSBaseViewAd.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSVideoAd : MSBaseViewAd
/**
 * 贴片基础回调代理
 */
@property (nonatomic, weak) id<MSVideoAdDelegate> delegate;
/**
 * 贴片扩展回调代理 如不需要扩展回调相关功能，可不用指定
 */
@property (nonatomic, weak) id<MSVideoAdExtensionFunctionDelegate> extDelegate;
/**
 * 加载广告
 @param pid             广告位id  必传
 @param adParams  广告参数  必传
 */
- (void)loadAdWithPid:(NSString *)pid adConfigParams:(MSVideoAdConfigParams *)adParams;
/**
 * 展示广告
 */
- (void)showAdWithPresentVc:(UIViewController*)presentVc;
/**
 * 是否静音 提示：穿山甲不支持，需在穿山甲开发者平台进行配置
 */
- (void)setMuted:(BOOL)muted;
/**
 * 视频时长 注意由于三方获取视频总时长时机不一致，因此建议视频广告展示后获取
 */
- (NSTimeInterval)duration;
/**
 * 视频当前播放时长
 */
- (NSTimeInterval)currentTime;
/**
 * 播放视频
 * 注意：广点通、穿山甲、百度广告不支持该设置
 */
- (void)playVideo;
/**
 * 暂停视频
 * 注意：广点通、穿山甲、百度广告不支持该设置
 */
- (void)pauseVideo;
/**
 * 调整视频大小
 * 注意：广点通广告不支持该设置
 */
- (void)reSize:(CGRect)frame;
/**
 广告是否有效
 注意：仅广点通平台支持获取，其他平台默认YES
 */
-(BOOL)isAdValid;
/**
 广告价格  单位：分 [C2S下，返回渠道出价，非C2S下，返回平台填写的固价]
 注意：广告加载成功后获取
 */
- (NSInteger)ecpm;
@end

NS_ASSUME_NONNULL_END
