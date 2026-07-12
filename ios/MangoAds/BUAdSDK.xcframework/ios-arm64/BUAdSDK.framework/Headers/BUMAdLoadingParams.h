//
//  BUMAdLoadingParams.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import <Foundation/Foundation.h>

#pragma mark - 通用参数
/// 聚合广告请求ID，NSString
extern NSString *const BUMAdLoadingParamLinkID;

/// 聚合广告位ID，NSString
extern NSString *const BUMAdLoadingParamMediationRitID;

/// 场景ID，NSString
extern NSString *const BUMAdLoadingParamScenarioID;

/// 价值分组规则ID，NSString
extern NSString *const BUMAdLoadingParamUValueRuleId;

extern NSString *const BUMAdLoadingParamGroupType;

/// ADN广告位ID，NSString
extern NSString *const BUMAdLoadingParamMediaRitID;

/// ADN广告位名称，平台配置名称，NSString
extern NSString *const BUMAdLoadingParamMediaName;

/// 请求广告的渲染类型，NSNumber/NSInteger，0 无需区分渲染类型; 1 ADN提供渲染; 2 开发者自渲染
extern NSString *const BUMAdLoadingParamExpressAdType;

/// 是否请求模板广告的描述信息，NSDictionary
extern NSString *const BUMAdLoadingParamExpressAdTypeInfos;

/// 媒体专属扩展参数， NSDictionary
extern NSString *const BUMAdLoadingParamMediaExtra;

/// 广告位中混用其他类型代码位时的代码位类型，0-未混用 3-banner类型 4-信息流类型
extern NSString *const BUMAdLoadingParamAdSubType;

/// 包名,目前仅Baidu有效
extern NSString *const BUMAdLoadingParamPackageName;

#pragma mark - 自定义补充

/// 自定义Adapter扩展参数， NSString，JSON格式
extern NSString *const BUMAdLoadingParamCustomJson;

/// 获取竞价类型，NSNumber/NSInteger，0-普通广告位 1-Client竞价广告位 100-P层数据位
extern NSString *const BUMAdLoadingParamBiddingType;

#pragma mark - Banner

/// 期望广告尺寸，NSValue/CGSize
extern NSString *const BUMAdLoadingParamBNExpectSize;

#pragma mark - 插屏广告
/// 期望广告尺寸，NSValue/CGSize
extern NSString *const BUMAdLoadingParamISExpectSize;

/// 是否是静音，NSNumber/BOOL
extern NSString *const BUMAdLoadingParamISIsMute;

#pragma mark - 全屏视频

/// 是否是静音，NSNumber/BOOL
extern NSString *const BUMAdLoadingParamFVIsMute;

/// 视频显示方向，NSNumber/NSInteger，0-竖屏，1-横屏，默认竖屏
extern NSString *const BUMAdLoadingParamFVShowDirection;

#pragma mark - 激励视频

/// 是否是静音，NSNumber/BOOL
extern NSString *const BUMAdLoadingParamRVIsMute;

/// 视频显示方向，NSNumber/NSInteger，0-竖屏，1-横屏，默认竖屏
extern NSString *const BUMAdLoadingParamRVShowDirection;

/// 用户标识， NSString
extern NSString *const BUMAdLoadingParamRVUserID;

/// 奖励名称， NSString
extern NSString *const BUMAdLoadingParamRVRewardName;

/// 奖励金额，NSNumber/NSInteger
extern NSString *const BUMAdLoadingParamRVRewardAmount;

/// 表示允许继续再看一个，NSNumber/BOOL
extern NSString *const BUMAdLoadingParamRVRewardAllowPlayAgain;

/// 扩展信息， NSString
extern NSString *const BUMAdLoadingParamRVExtra;

///百度ACT URL,值为0，1。1为转化激励，0为非转化激励
extern NSString *const BUMAdLoadingParamActURL;
#pragma mark - Splash广告
/// 是否需要开屏卡片功能，NSNumber/BOOL
extern NSString *const BUMAdLoadingParamSPSupportCardView;

/// 自定义底部视图，UIView
extern NSString *const BUMAdLoadingParamSPCustomBottomView;

/// 期望广告尺寸，NSValue/CGSize
extern NSString *const BUMAdLoadingParamSPExpectSize;

/// 开屏超时时间，NSNumber/NSInteger
extern NSString *const BUMAdLoadingParamSPTolerateTimeout;

/// 开屏点击区域，NSNumber/NSInteger/BUMSplashButtonType
extern NSString *const BUMAdLoadingParamSPButtonType;

/// 是否隐藏跳过按钮，NSNumber，0-不需要 ，1-需要
extern NSString *const BUMAdLoadingParamSPHideSkipButton;
#pragma mark - Native/Draw广告
/// 期望广告图片尺寸，NSValue/CGSize
extern NSString *const BUMAdLoadingParamNAExpectImageSize;

/// 期望广告尺寸，NSValue/CGSize
extern NSString *const BUMAdLoadingParamNAExpectSize;

/// 期望摇一摇提示view的frame，NSValue/CGRect
extern NSString *const BUMAdLoadingParamNAExpectShakeViewFrame;

/// 是否是静音，NSNumber/BOOL
extern NSString *const BUMAdLoadingParamNAIsMute;

/// 加载广告数量，NSNumber/NSInteger
extern NSString *const BUMAdLoadingParamNALoadAdCount;

#pragma mark - 加载回调参数，即adapter开发者通过`- ***Ad:didLoadSuccess/Fail*** ext:`中NSDictionary回调的数据

/// 【可选】AND广告ECPM，NSString，单位分
extern NSString *const BUMMediaAdLoadingExtECPM;

/// 【可选】AND广告ECPMLevel，NSString
extern NSString *const BUMMediaAdLoadingExtECPMLevel;

/// 【可选】ADN广告的加载标识，NSString
extern NSString *const BUMMediaAdLoadingExtRequestID;

/// 【可选】AND广告唯一标识，NSString
extern NSString *const BUMMediaAdLoadingExtAdID;

/// 【可选】AND广告创意唯一标识，NSString
extern NSString *const BUMMediaAdLoadingExtCreativeID;

/// 【可选】直播间信息，NSDictionary
extern NSString *const BUMMediaAdLoadingExtLiveRoom;

/// 【可选】商品信息，NSDictionary
extern NSString *const BUMMediaAdLoadingExtProduct;

/// 【可选】卷信息，NSDictionary
extern NSString *const BUMMediaAdLoadingExtCoupon;

/// 【可选】广告样式（视频 or 图片）， NSNumber/BUFeedADMode
extern NSString *const BUMMediaAdLoadingExtImageMode;

/// 【可选】广告标题，NSString
extern NSString *const BUMMediaAdLoadingExtTitle;

/// 【可选】广告描述，NSString
extern NSString *const BUMMediaAdLoadingExtDescription;

/// 【可选】广告图片地址，NSString
extern NSString *const BUMMediaAdLoadingExtImageUrl;

/// 【可选】广告视频地址，NSString
extern NSString *const BUMMediaAdLoadingExtVideoUrl;

/// 【可选】广告主品牌图片地址，NSString
extern NSString *const BUMMediaAdLoadingExtIconUrl;

/// 【可选】告知使用策略相关数据,设定policy专用key
extern NSString *const BUMAdUsePolicy;

/// 【可选】告知使用策略-adGap相关数据,接受字符串&number类型
extern NSString *const BUMAdUsePolicyAdGap;

/// 【可选】告知使用策略-adLoad相关数据,接受字符串&number类型
extern NSString *const BUMAdUsePolicyAdLoad;

/// 【可选】告知使用策略-sectionId相关数据,接受字符串&number类型
extern NSString *const BUMAdUsePolicySectionId;

/// 【可选】告知使用策略-pageId相关数据,接受字符串&number类型
extern NSString *const BUMAdUsePolicyPageId;

/// 【可选】告知使用策略-自定义相关数据,接受字典类型;
///  内部key:value需要满足:字符串类型&小于100字符&不包含特殊字符[大小写字母+数字+'-'+'_']
extern NSString *const BUMAdUsePolicyCustom;

#pragma mark - 优惠券功能使用相关
/// 【可选】优惠券、翻页、弹幕组件使用相关通知名称 (根据具体Adn支持情况判定,目前仅Baidu支持)
extern NSString *const BUMMediaAdWidgetViewCreateNotificationName;

/// 【可选】优惠券翻页视图Creator
extern NSString *const BUMMediaAdCouponFlipViewCreator;

/// 【可选】优惠券悬浮视图Creator
extern NSString *const BUMMediaAdCouponSuspensionViewCreator;

#pragma mark - 弹幕功能使用相关
/// 【可选】弹幕组件视图Creator
extern NSString *const BUMMediaAdBarrageViewCreator;

/// 【可选】扭动视图Enable
extern NSString *const BUMMediaAdRotateViewEnable;

/// 【可选】扭动视图Creator
extern NSString *const BUMMediaAdRotateViewCreator;
