//
//  ATOfferSetting.h
//  AnyThinkSDK
//
//  Created by stephen on 26/8/2020.
//  Copyright © 2020 AnyThink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AnyThinkSDK/ATOfferModel.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kATOfferTrackerExtraLifeCircleID;
extern NSString *const kATOfferTrackerExtraScene;
extern NSString *const kATOfferTrackerMacroClickID;
extern NSString *const kATOfferTrackerMacroSLD;
extern NSString *const kATOfferTrackerMacroImpressionDuration;
extern NSString *const kATOfferTrackerMacroMaxShowRadio;
extern NSString *const kATOfferTrackerMacroViewScreenX;
extern NSString *const kATOfferTrackerMacroViewScreenY;
extern NSString *const kATOfferTrackerMacroWidth;
extern NSString *const kATOfferTrackerMacroHeight;
extern NSString *const kATOfferTrackerMacroDownX;
extern NSString *const kATOfferTrackerMacroDownY;
extern NSString *const kATOfferTrackerMacroUpX;
extern NSString *const kATOfferTrackerMacroUpY;
extern NSString *const kATOfferTrackerMacroRequestWidth;
extern NSString *const kATOfferTrackerMacroRequestHeight;
extern NSString *const kATOfferTrackerMacroRelativeDownX;
extern NSString *const kATOfferTrackerMacroRelativeDownY;
extern NSString *const kATOfferTrackerMacroRelativeUpX;
extern NSString *const kATOfferTrackerMacroRelativeUpY;
extern NSString *const kATOfferTrackerMacroTimestamp;
extern NSString *const kATOfferTrackerMacroMilliTimestamp;
extern NSString *const kATOfferTrackerMacroEndTimestamp;
extern NSString *const kATOfferTrackerMacroEndMilliTimestamp;
extern NSString *const kATOfferTrackerMacroKYAbsoluteCoord;
extern NSString *const kATOfferTrackerMacroKYRelativeCoord;
extern NSString *const kATOfferTrackerMacroDeeplinkType;
extern NSString *const kATOfferTrackerMacroOPDPType;
/// video
extern NSString *const kATOfferTrackerMacroVideoLength;
extern NSString *const kATOfferTrackerMacroVideoStartTime;
extern NSString *const kATOfferTrackerMacroVideoEndTime;
extern NSString *const kATOfferTrackerMacroVideoPlayInStart;
extern NSString *const kATOfferTrackerMacroVideoPlayInEnd;
extern NSString *const kATOfferTrackerMacroVideoPlayScence;
extern NSString *const kATOfferTrackerMacroVideoPlayType;
extern NSString *const kATOfferTrackerMacroVideoPlayBehavior;
extern NSString *const kATOfferTrackerMacroVideoPlayStatus;
extern NSString *const kATOfferTrackerMacroVideoTimePlayed;
extern NSString *const kATOfferTrackerMacroVideoMilliTimePlayed;
/// 第二套宏替换
extern NSString *const kATOfferTrackerMacroCSLD;
extern NSString *const kATOfferTrackerMacroCDownX;
extern NSString *const kATOfferTrackerMacroCDownY;
extern NSString *const kATOfferTrackerMacroCUpX;
extern NSString *const kATOfferTrackerMacroCUpY;
extern NSString *const kATOfferTrackerMacroRelativeCDownX;
extern NSString *const kATOfferTrackerMacroRelativeCDownY;
extern NSString *const kATOfferTrackerMacroRelativeCUpX;
extern NSString *const kATOfferTrackerMacroRelativeCUpY;
extern NSString *const kATOfferTrackerMacroShareACCMaxX;
extern NSString *const kATOfferTrackerMacroShareACCMaxY;
extern NSString *const kATOfferTrackerMacroShareACCMaxZ;
extern NSString *const kATOfferTrackerMacroTURNX;
extern NSString *const kATOfferTrackerMacroTURNY;
extern NSString *const kATOfferTrackerMacroTURNZ;
extern NSString *const kATOfferTrackerMacroTURNTimestamp;
/// 新增pt单位上报宏
extern NSString *const kATOfferTrackerMacroViewScreenDTX;
extern NSString *const kATOfferTrackerMacroViewScreenDTY;
extern NSString *const kATOfferTrackerMacroDTWidth;
extern NSString *const kATOfferTrackerMacroDTHeight;
extern NSString *const kATOfferTrackerMacroDTDownX;
extern NSString *const kATOfferTrackerMacroDTDownY;
extern NSString *const kATOfferTrackerMacroDTUpX;
extern NSString *const kATOfferTrackerMacroDTUpY;
extern NSString *const kATOfferTrackerMacroRelativeDTDownX;
extern NSString *const kATOfferTrackerMacroRelativeDTDownY;
extern NSString *const kATOfferTrackerMacroRelativeDTUpX;
extern NSString *const kATOfferTrackerMacroRelativeDTUpY;
extern NSString *const kATOfferTrackerMacroDTCDownX;
extern NSString *const kATOfferTrackerMacroDTCDownY;
extern NSString *const kATOfferTrackerMacroDTCUpX;
extern NSString *const kATOfferTrackerMacroDTCUpY;
extern NSString *const kATOfferTrackerMacroRelativeDTCDownX;
extern NSString *const kATOfferTrackerMacroRelativeDTCDownY;
extern NSString *const kATOfferTrackerMacroRelativeDTCUpX;
extern NSString *const kATOfferTrackerMacroRelativeDTCUpY;

typedef NS_ENUM(NSInteger, ATAdShakeAnimationType) {
    ATAdShakeAnimationTypeRock = 1,
    ATAdShakeAnimationTypeJoggle = 2,
    ATAdShakeAnimationTypeShakeShake = 3,
};

typedef NS_ENUM(NSInteger, ATAdSplashCTAType) {
    ATAdSplashCTATypeNormal = 1,
    ATAdSplashCTATypeBottomSemicircle = 2,
};


typedef NS_ENUM(NSInteger, ATOnlyDisplaySendWinType) {
    ATOnlyDisplaySendWinUnknownType = 0,
    ATOnlyDisplaySendWinOnType = 1,
    ATOnlyDisplaySendWinOffType = 2,
};

typedef NS_ENUM(NSInteger, ATRewardPictureAnimateType) {
    ATRewardPictureAnimateUnknownType = 0,
    ATRewardPictureNOAnimateType,
    ATRewardPictureClickAnimateType,
    ATRewardPictureRedPacketAnimateType,
    ATRewardPictureSlideAnimateType,
    ATRewardPictureCardScaleAnimateType,
};

typedef NS_ENUM(NSInteger, ATRewardPictureWebType) {
    ATRewardPictureWebJointType = 1,
    ATRewardPictureWebOtherType,
};

typedef NS_ENUM(NSInteger, ATBannerClickType) {
    ATBannerClickTypeTap = 1,
    ATBannerClickTypeInsideSlideTap,
    ATBannerClickTypeAllClick,
};

typedef NS_ENUM(NSUInteger, ATCtaAnimationType) {
    ATCtaAnimationTypeBreath = 1,// 呼吸
    ATCtaAnimationTypeSway,// 中心点摆动
    ATCtaAnimationTypeStreak,// 斜边划过
    ATCtaAnimationTypeBreathAndStreaks,// 呼吸&划过
    ATCtaAnimationTypeHandClick,// 小手点击
};

typedef NS_ENUM(NSInteger, ATDirectOfferUnitType) {
    ATDirectOfferUnitPictureType = 0,
    ATDirectOfferUnitVideoType = 1,
};

typedef NS_ENUM(NSUInteger, ATVideoPlaySetting) {
    ATVideoPlayAlwaysAutoPlaySetting  = 0,
    ATVideoPlayOnlyWiFiAutoPlaySetting,
    ATVideoPlayClickAutoPlaySetting,
};

typedef NS_ENUM(NSUInteger, ATCTAStyleType) {
    ATCTAStyleTypeBothOne             = 1,  // 主素材和endcard都是单CTA，老样式（默认值）
    ATCTAStyleTypeOnlyMainMaterialOne = 2,  // 主素材是单CTA，endcard是双CTA
    ATCTAStyleTypeOnlyMainMaterialTwo = 3,  // 主素材是双CTA，endcard是单CTA
    ATCTAStyleTypeBothTwo             = 4   // 主素材和endcard都是双CTA
};

typedef NS_ENUM(NSUInteger, ATEndcardStyleType) {
    ATEndcardStyleTypeNormal               = 1,  // 或非1-5的取值，或不含该配置，代表按原有endcard逻辑进行展示
    ATEndcardStyleTypeCountdownGuideMask   = 2,  // 代表在endcard上要展示倒计时引导蒙层
    ATEndcardStyleTypeRedPacket            = 3,  // 代表在endcard上要展示红包样式
    ATEndcardStyleTypeWithdraw             = 4,  // 代表在endcard上要展示双endcard的提现样式
    ATEndcardStyleTypeUniversal            = 5   // 代表在endcard上要展示双endcard的通用挽留页样式
};

typedef NS_ENUM(NSUInteger, ATEndCardRedPacketStyleType) {
    ATEndCardRedPacketStyleTypeOpenDetail  = 1,  // 则进入红包领取页，不会执行广告点击逻辑
    ATEndCardRedPacketStyleTypeDismiss     = 2,  // 则执行广告点击逻辑，进入广告跳转，并将红包隐藏/销毁，显示底部正常endcard
};

typedef NS_ENUM(NSUInteger, ATRedPacketClickableAreaType) {
    ATRedPacketClickableAreaTypeAllNotClickable     = 0,  // 代表红包区域及背景蒙层不可点
    ATRedPacketClickableAreaTypeOnlyMaskClickable   = 1,  // 代表红包区域不可点，点击背景蒙层执行广告点击
    ATRedPacketClickableAreaTypeAllClickable        = 2,  // 代表点击红包区域及背景蒙层执行广告点击
};

typedef NS_ENUM(NSUInteger, ATRedPacketDetailClickableAreaType) {
    ATRedPacketDetailClickableAreaTypeAllNotClickable  = 0,  // 代表领取页其他区域不可点
    ATRedPacketDetailClickableAreaTypeAllClickable     = 1,  // 代表领取页点击其他区域执行广告点击
};

typedef NS_ENUM(NSUInteger, ATWithdrawClickableAreaType) {
    ATWithdrawClickableAreaTypeCardAndButton     = 1,  // 代表卡片及按钮区域点击进入广告跳转，其他区域不可点
    ATWithdrawClickableAreaTypeAllClickable      = 2,  // 代表全屏可点
};

typedef NS_ENUM(NSUInteger, ATSecondEndcardClickableAreaType) {
    ATSecondEndcardClickableAreaTypeOnlyCTA       = 1,  // 代表仅挽留页卡片CTA可点
    ATSecondEndcardClickableAreaTypeOnlyEndcard   = 2,  // 代表整个挽留页卡片可点
    ATSecondEndcardClickableAreaTypeExceptClose   = 3,  // 代表全屏可点，除了关闭按钮
    ATSecondEndcardClickableAreaTypeAllClickable  = 4,  // 代表全屏可点，以及首次关闭按钮可点
};

typedef NS_ENUM(NSUInteger, ATOfferMediaViewExpressType) {
    ATOfferMediaViewExpressTypeLeftImage = 1,
    ATOfferMediaViewExpressTypeLeftText,
    ATOfferMediaViewExpressTypeAboveImage,
    ATOfferMediaViewExpressTypeAboveText,
    ATOfferMediaViewExpressTypeTextFloating,
    ATOfferMediaViewExpressTypeDefault,
};

typedef NS_ENUM(NSUInteger, ATShakeTriggerModeType) {
    ATShakeTriggerModeTypeMultiDirectional     = 1,  // 多向来回判断
    ATShakeTriggerModeTypeUnidirectional       = 2,  // 单向判断
};

typedef NS_ENUM(NSUInteger, ATCloseButtonStyleType) {
    ATCloseButtonStyleTypeUnavailable     = 1,  // 不生效次级按钮样式
    ATCloseButtonStyleTypeActive          = 2,  // 生效次级按钮样式
};

typedef NS_ENUM(NSUInteger, ATMaterialLayoutType) {
    ATMaterialLayoutTypeFullScreenMainMaterial,          // 全屏主素材
    ATMaterialLayoutTypeHalfScreenMainMaterial,          // 半屏主素材
    ATMaterialLayoutTypeHalfScreenMainMaterialOnlyCTA,   // 半屏主素材仅显示CTA
    ATMaterialLayoutTypeEndCard,                         // endcard素材
    ATMaterialLayoutTypeSplashMaterial,                  // 开屏素材
};

typedef NS_ENUM(NSUInteger, ATCTAButtonLayoutType) {
    ATCTAButtonLayoutTypeOneCTA,             // 单CTA
    ATCTAButtonLayoutTypeDoubleCTA,          // 双CTA
    ATCTAButtonLayoutTypeWithCloseButton,    // 一个CTA一个关闭按钮
    ATCTAButtonLayoutTypeBottomSemicircle,    // 开屏底部半圆CTA
};

typedef NS_ENUM(NSUInteger, ATVideoCountdownStyle) {
    ATVideoCountdownStyleNumerical       = 1, // 仅展示数字倒计时
    ATVideoCountdownStyleProgressBar     = 2, // 仅展示播放进度条
    ATVideoCountdownStyleNeitherShow     = 3, // 数字倒计时和播放进度条均不展示
    ATVideoCountdownStyleBothShow        = 4  // 数字倒计时和播放进度条都展示
};

typedef NS_ENUM(NSUInteger, ATInterstitialTemplateType) {
    ATInterstitialTemplateTypeHalfScreen            = 1, // 半屏插屏
    ATInterstitialTemplateTypeFullScreen            = 2, // 全屏插屏
    ATInterstitialTemplateTypeHalfScreenEnvelope    = 3, // 半屏信封插屏
    ATInterstitialTemplateTypeFullScreenEnvelope    = 4  // 全屏信封插屏
};
/// 广告位活动氛围样式
typedef NS_ENUM(NSUInteger, ATEventsAtmosphereType) {
    ATEventsAtmosphereTypeNone            = 1, // 无
    ATEventsAtmosphereTypeBubbleDrop            = 2, // 气泡掉落（开屏、插屏)
    ATEventsAtmosphereTypeECAmbience    = 3, //  异形电商氛围（插屏半屏）
};

/// 开屏拼接推荐
typedef NS_ENUM(NSUInteger, ATSplashSpliceType) {
    ATSplashSpliceTypeNone            = 1, // 无
    ATSplashSpliceTypeHotRecommend           = 2, // 热门推荐
};

@class ATOfferModel,ATGuideClickOverlayItem,ATRVIncentiveTaskConfig;
@interface ATOfferSetting : ATModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong) NSString *placementID;
//setting for banner
@property (nonatomic, strong) NSString *bannerSize;
@property (nonatomic, assign) NSTimeInterval resourceDownloadTimeout;
@property (nonatomic, assign) NSTimeInterval bannerAppearanceInterval;
@property (nonatomic, assign) NSTimeInterval bannerDisapearInterval;
@property (nonatomic, assign) NSTimeInterval closeButtonAppearanceInterval;
@property (nonatomic, assign) ATAdFormat format;
@property (nonatomic, assign) ATVideoClickable videoClickable;
@property (nonatomic, assign) ATEndCardClickable endCardClickable;
@property (nonatomic, assign) ATLoadStorekitTime storekitTime;
@property (nonatomic, assign) ATOfferLayoutType layoutType;
@property (nonatomic, assign) ATClickMode clickMode;
@property (nonatomic, assign) ATLoadType loadType;
@property (nonatomic, assign) ATUserAgentType impressionUAType;
@property (nonatomic, assign) ATUserAgentType clickUAType;
@property (nonatomic, assign) ATDeepLinkClickMode deeplinkClickMoment;
@property (nonatomic, assign) ATSplashType splashType;
@property (nonatomic, assign) ATSplashImageScaleType splashImageScaleType;
@property (nonatomic, assign) ATAdShakeAnimationType adShakeAnimationType;
@property (nonatomic, assign) NSInteger lastOfferidsNum;
@property (nonatomic, assign) NSInteger splashCountDownTime;
@property (nonatomic, assign) NSInteger splashOrientation;
/// The minimum value of the close button delayed display
@property (nonatomic, assign) NSInteger closeBtnDelayMinTime;
/// The maximum value of the close button delayed display
@property (nonatomic, assign) NSInteger closeBtnDelayMaxTime;
@property (nonatomic, assign) NSInteger closeBtnDelayRate;
@property (nonatomic, assign) NSInteger onRewardTime;
@property (nonatomic, assign) CGFloat closeBtnNoFirstClickArea;
@property (nonatomic, assign) CGFloat closeBtnFirstClickArea;
@property (nonatomic, assign) CGFloat closeBtnNoFirstClickAreaScal;
@property (nonatomic, assign) CGFloat closeBtnFirstClickAreaScal;
@property (nonatomic, assign) BOOL unMute;
@property (nonatomic, assign) BOOL skipable;
@property (nonatomic, assign) BOOL showBannerCloseBtn;
@property (nonatomic, assign) BOOL isGuideClick;
@property (nonatomic, assign) BOOL rewardWhenFailed;
@property (nonatomic, assign) BOOL showEndCard;
// Whether to enable the shake function. 1 means open, 2 means not open
@property (nonatomic, assign) BOOL splashShakeSw;
// The minimum value of the gyroscope that can trigger a shake click. Default is 0.1
@property (nonatomic, assign) CGFloat shakeStrength;
// Shake the time interval that a tap can trigger again. The default is 5s
@property (nonatomic, assign) NSInteger shakeTime;
@property (nonatomic, assign) NSTimeInterval clickCacheTime;
@property (nonatomic, assign) BOOL clickNotice;
//6.1.32https://confluence.magicgame001.com/pages/viewpage.action?pageId=47126246
@property (nonatomic, assign) BOOL overlaySwitch;
@property (nonatomic, assign) NSTimeInterval overlayDuration;
@property (nonatomic, assign) NSTimeInterval overlayShowTime;
@property (nonatomic, assign) BOOL overlayUserDismissible;
@property (nonatomic, assign) BOOL storeKitSwitch;
@property (nonatomic, assign) NSTimeInterval monitoringShowTime;
///是否预加载Mraid素材，yes是预加载，no是不预加载
@property (nonatomic, assign) BOOL mraidPreLoadSwitch;
/// 是否失败重发networkTK
@property (nonatomic, assign) BOOL retryNetworkTkSwitch;
/// 仅在展示时发送Win
@property (nonatomic, assign) ATOnlyDisplaySendWinType onlyDisplaySendWinType;
/// 自动点击 6.2.2_5
@property (nonatomic, assign) BOOL isAutoClickImage;
@property (nonatomic, assign) NSTimeInterval autoClickImageTipDuration;
@property (nonatomic, assign) NSTimeInterval autoClickImageTriggerDuration;
@property (nonatomic, assign) BOOL isAutoClickVideo;
@property (nonatomic, assign) NSTimeInterval autoClickVideoTipDuration;
@property (nonatomic, assign) NSTimeInterval autoClickVideoTriggerDuration;
@property (nonatomic, assign) BOOL isAutoClickEndCard;
@property (nonatomic, assign) NSTimeInterval autoClickEndCardTipDuration;
@property (nonatomic, assign) NSTimeInterval autoClickEndCardTriggerDuration;
@property (nonatomic, assign) ATRewardPictureAnimateType rewardPictureAnimateType;
@property (nonatomic, assign) NSTimeInterval rewardPictureOnRewardDuration;
@property (nonatomic, assign) ATRewardPictureWebType rewardPictureWebType;
@property (nonatomic, assign) ATBannerClickType bannerTriggerClickType;
@property (nonatomic, assign) ATAdOfferInterType interType;
@property (nonatomic, assign) ATDirectOfferUnitType unitType;
@property (nonatomic, assign) ATOfferMediaViewExpressType expressType;
// click guide animation Switch
@property (nonatomic, assign) BOOL guideClickOverlaySwitch;
// click guide animation list
@property (nonatomic, strong) NSArray<ATGuideClickOverlayItem *> *overlayItemArray;
// Q&A pop-up option answer
@property (nonatomic, strong) NSString *qaAnswerText;
// The probability of an invalid close button
@property (nonatomic, assign) BOOL closeButtonInvalidSwitch;
@property (nonatomic, assign) BOOL enableInterstitialStyleEnvelope;
@property (nonatomic, assign) BOOL isImpressionInterstitialStyleEnvelope;
/// 摇一摇图标外面的文案
@property (nonatomic, strong) NSString *shakeText;
/// 摇一摇图标里面的文案
@property (nonatomic, strong) NSString *shakeInternalText;
/// 摇一摇缩小后文案
@property (nonatomic, strong) NSString *shakeSmallText;
/// 摇一摇图片URL字符串
@property (nonatomic, strong) NSString *shakeImageURLString;
@property (nonatomic, assign) BOOL isShowDetentionPage;
/// 开屏结束弹窗倒计时 当下发为0的时，全屏开屏结束后不展示弹窗
@property (nonatomic, assign) NSTimeInterval splashPopTime;
/// 视频播放N秒后出现Banner(顶部)
@property (nonatomic, assign) NSTimeInterval topBannerStartTime;
/// Banner弹出播放时长(顶部)
@property (nonatomic, assign) NSTimeInterval topBannerShowTime;
/// 控制广告点击跳转后，是否销毁广告
@property (nonatomic, assign) BOOL isClickCloseAd;
/// 开屏倒计时结束后， 视频是否继续播放 1-是,2-否, 默认：2 
@property (nonatomic, assign) BOOL countDownPlaySwitch;
// offer 维度 readyRate
@property (nonatomic, assign) NSInteger readyRate;
///表示video下载到ready rate后是否继续下载，1或不下发表示继续下载，2表示暂停下载。默认不下发
@property (nonatomic, assign) NSInteger videoContinueType;
///表示视频展示后，观看到多少比例开始继续下载（针对边下边播场景）。默认0或不下发表示开始播放就开始下载。
@property (nonatomic, assign) NSInteger cdRate;
// 1:部分下载；2:下载剩余全部
@property (nonatomic, assign) NSInteger particalDownloadState;
/// CTA按钮动画效果
@property (nonatomic, assign) ATCtaAnimationType ctaAnimationType;
/// CTA按钮样式
@property (nonatomic, assign) ATCTAStyleType ctaStyleType;
/// CTA 左按钮文案
@property (nonatomic, strong) NSString *ctaLeftButtonText;
/// EndCard样式
@property (nonatomic, assign) ATEndcardStyleType endcardStyleType;
/// EndCard新样式倒计时，若 >0，则展示倒计时， 若 <0，不展示倒计时及关闭按钮区域，但按绝对值进行倒计时；当 =0，不进行倒计时，直接展示假关闭按钮
@property (nonatomic, assign) NSTimeInterval endcardCountdownNew;
/// EndCard红包样式交互
@property (nonatomic, assign) ATEndCardRedPacketStyleType endCardRedPacketStyleType;
/// EndCard红包样式可点区域
@property (nonatomic, assign) ATRedPacketClickableAreaType redPacketClickableAreaType;
/// EndCard红包样式详情页可点区域
@property (nonatomic, assign) ATRedPacketDetailClickableAreaType redPacketDetailClickableAreaType;
/// EndCard红包样式可点区域策略原始值，两位数数值
@property (nonatomic, assign) NSInteger redPacketClickableAreaOriginalValue;
/// 红包标题
@property (nonatomic, strong) NSString *redTitleText;
/// 红包祝福语
@property (nonatomic, strong) NSString *redBlessingsText;
/// 免责声明链接
@property (nonatomic, strong) NSString *disclaimerUrl;
/// 领取提醒
@property (nonatomic, strong) NSString *redReceiveNoticeText;
/// 领取按钮文案
@property (nonatomic, strong) NSString *redReceiveButtonText;
/// EndCard提现样式可点区域
@property (nonatomic, assign) ATWithdrawClickableAreaType withdrawClickableAreaType;
/// EndCard通用挽留页倒计时，若 >0，则展示倒计时。 若 <0，不展示倒计时及关闭按钮区域，但按绝对值进行倒计时；当 =0，不进行倒计时，直接展示假关闭按钮
@property (nonatomic, assign) NSTimeInterval secondEndcardCountdown;
/// EndCard通用挽留页可点区域
@property (nonatomic, assign) ATSecondEndcardClickableAreaType secondEndcardClickableAreaType;
/// 提现样式视频素材
@property (nonatomic, strong) NSString *withdrawVideoUrl;
/// 提现样式icon素材
@property (nonatomic, strong) NSString *withdrawIconUrl;
/// 提现样式挽留卡片标题
@property (nonatomic, strong) NSString *withdrawTitleText;
/// 提现样式挽留卡片素材
@property (nonatomic, strong) NSString *withdrawImageUrl;
/// 提现样式挽留卡片按钮文案
@property (nonatomic, strong) NSString *withdrawButtonText;
/// 原生视频自动播放设置，目前仅adx支持配置
@property (nonatomic, assign) ATVideoPlaySetting videoPlaySetting;
/// 触发摇一摇的方案 1：多向来回判断，2：单向判断，默认为1
@property (nonatomic, assign) ATShakeTriggerModeType shakeTriggerModeType;
/// 摇一摇监测时间 整数形式，单位毫秒
@property (nonatomic, assign) NSInteger shakeMonitorTime;
/// 摇一摇加速度设置-触发阈值  小数形式数组 例如[16.5, 15, 10]
@property (nonatomic, strong) NSArray<NSNumber *> *shakeTriggerThresholdArray;
/// 关闭按钮-次级按钮样式（激励视频、插屏下的图片和视频素材，SDK Version 6.3.70 及以上支持） ，默认值为 1
@property (nonatomic, assign) ATCloseButtonStyleType closeButtonStyleType;
/// 关闭按钮-次级按钮文案
@property (nonatomic, strong) NSString *closeButtonStyleText;
/// 视频广告倒计时的样式展示规则，默认值为：1
@property (nonatomic, assign) ATVideoCountdownStyle videoCountdownStyle;
/// 激励视频领取奖励倒计时,单位秒
@property (nonatomic, assign) NSInteger rvRewardTipCountdown;
/// 是否对html广告做自动点击拦截，=1或没有该字段或该字段没有值，则需要对html渲染的广告做屏蔽； =2，不做拦截屏蔽。
@property (nonatomic, assign) NSInteger filterAutoClick;
/// 激励任务类型
@property (nonatomic, assign) ATRVTncentiveTaskType rvIncentiveTaskType;
/// 播放 N 秒展示
@property (nonatomic, assign) NSInteger rvIncentiveTaskDisplayTiming;
/// 减少/跳过时长(秒)
@property (nonatomic, assign) NSInteger rvIncentiveTaskReduceOrFreeTime;
/// 浮层持续时间(秒)
@property (nonatomic, assign) NSInteger rvIncentiveTaskHoldingTime;
/// 广告位活动氛围样式
@property (nonatomic, assign) ATEventsAtmosphereType eventsAtmosphereType;
/// 开屏拼接推荐氛围样式
@property (nonatomic, assign) ATSplashSpliceType splashSpliceType;
/// 开屏底部CTA样式
@property (nonatomic, assign) ATAdSplashCTAType splashCTAType;
/// Deeplink 拉起成功时，是否同时打开 Click_u, 默认否
@property (nonatomic, assign) BOOL deeplinkSuccessOpenClickUrlSw;
/// 关闭按钮透明度,  默认值 1
@property (nonatomic, assign) CGFloat closeBtnOpenness;
/// 摇一摇延迟触发，单位毫秒，默认值 50，：SDK 支持配置 -1，即不生效延迟触发的逻辑
@property (nonatomic, assign) NSInteger shakeToTriggerDelay;

- (CGFloat)getClickArea:(NSInteger)sizeType;
- (CGFloat)getClickAreaScal:(NSInteger)sizeType;
/// CTA按钮渲染类型，根据ctaStyleType和closeButtonStyleType来控制
- (ATCTAButtonLayoutType)getCTAButtonLayoutType:(ATMaterialLayoutType)materialLayoutType offerModel:(ATOfferModel *)offerModel;
- (BOOL)isExistRewardPictureAnimate;
- (ATInterstitialTemplateType)getInterstitialTemplateType;

@end

NS_ASSUME_NONNULL_END
