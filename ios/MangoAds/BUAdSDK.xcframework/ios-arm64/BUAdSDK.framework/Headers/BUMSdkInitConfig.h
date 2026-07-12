//
//  BUMSdkInitConfig.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUInterfaceBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@class BUMUserConfig;

/// adn初始化配置信息
@interface BUMSdkInitConfig : BUInterfaceBaseObject

/// 用户自定义配置
@property (nonatomic, strong, readonly) BUMUserConfig *userConfig;

/// appID
@property (nonatomic, copy, readonly) NSString *appID;

/// appKey
@property (nonatomic, copy, readonly) NSString *appKey;

/// adn的标识
@property (nonatomic, copy, readonly) NSString *name;

/// 是否可用状态
@property (nonatomic, assign, readonly) BOOL valid;

/// 是否是自定义adapter，白名单用户权限
@property (nonatomic, assign, readonly) BOOL custom;

/// 自定义adapter初始化的配置类名，该类对象遵循BUMCustomConfigAdapter协议
@property (nonatomic, copy, readonly) NSString *customAdnClassName;

/// 自定义adapter banner广告的配置类名，该类对象遵循BUMCustomBannerAdapter协议
@property (nonatomic, copy, readonly) NSString *customBannerAdapterClassName;

/// 自定义adapter 插屏广告的配置类名，该类对象遵循BUMCustomInterstitialAdapter协议
@property (nonatomic, copy, readonly) NSString *customInterstitialAdapterClassName;

/// 自定义adapter 激励视频广告的配置类名，该类对象遵循BUMCustomRewardedVideoAdapter协议
@property (nonatomic, copy, readonly) NSString *customRewardedVideoAdapterClassName;

/// 自定义adapter 全屏广告的配置类名，该类对象遵循BUMCustomFullscreenVideoAdapter协议
@property (nonatomic, copy, readonly) NSString *customFullscreenVideoAdapterClassName;

/// 自定义adapter 开屏广告的配置类名，该类对象遵循BUMCustomSplashAdapter协议
@property (nonatomic, copy, readonly) NSString *customSplashAdapterClassName;

/// 自定义adapter native广告的配置类名，该类对象遵循BUMCustomNativeAdapter协议
@property (nonatomic, copy, readonly) NSString *customNativeAdapterClassName;

/// 自定义adapter draw广告的配置类名，该类对象遵循BUMCustomDrawAdapter协议
@property (nonatomic, copy, readonly) NSString *customDrawAdapterClassName;

@end

NS_ASSUME_NONNULL_END
