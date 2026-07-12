//
//  BUAdSlot+Mediation.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUAdSlot.h"
#import "BUMSplashUserData.h"

@class BUAdSlotMediation;

NS_ASSUME_NONNULL_BEGIN

@interface BUAdSlot (Mediation)

/// 调用该接口，用于继续设置聚合维度相关属性
@property (nonatomic, strong, readonly) BUAdSlotMediation *mediation;

@end

@interface BUAdSlotMediation : NSObject

/**
 2021-02
 optional
 设定是否静音播放视频，YES = 静音，NO = 非静音
 PS:
 ①仅gdt、ks、mtg支持设定mute
 ②仅适用于视频播放器设定生效
 重点：请在loadAdData前设置,否则不生效
 */
@property (nonatomic, assign) BOOL mutedIfCan;

/// 在Bididing结束后是否回调ADN结果，默认NO
@property (nonatomic, assign) BOOL bidNotify;

/// 广告场景ID
@property (nonatomic, copy, nullable) NSString *scenarioID;

/// [可选]设置开屏兜底，当使用聚合广告位进行开屏广告加载时，在广告位配置拉取失败后，会使用传入的rit和appID兜底，进行广告加载
/// @warning : 如果BUAdSlot中ID为CSJ代码位而非聚合广告位时，请勿设置该接口，会导致广告加载失败。
@property (nonatomic, strong, nullable)BUMSplashUserData *splashUserData;

/// 聚合维度下部分adn会用到window展示开屏广告，支持设置该值；如未设置该值则取设置的splashRootViewController.view.window
@property (nonatomic, weak, nullable) UIWindow *showInWindow;

@end

NS_ASSUME_NONNULL_END
