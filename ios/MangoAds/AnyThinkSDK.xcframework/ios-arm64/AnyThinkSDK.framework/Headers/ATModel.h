//
//  ATModel.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 11/04/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ATAdFormat) {
    ATAdFormatNative = 0,
    ATAdFormatRewardedVideo = 1,
    ATAdFormatBanner = 2,
    ATAdFormatInterstitial = 3,
    ATAdFormatSplash = 4,
    ATAdFormatMediaVideo = 50
};

typedef NS_ENUM(NSInteger, ATEndCardClickable) {
    ATEndCardClickableFullscreen = 1,
    ATEndCardClickableCTA,
    ATEndCardClickableBanner
};

typedef NS_ENUM(NSInteger, ATScreenOrientation) {
    ATScreenOrientationPortrait,
    ATScreenOrientationLandscape
};

typedef NS_ENUM(NSInteger, ATInterstitialType) {
    ATInterstitialVideo = 1,
    ATInterstitialPicture
};

typedef NS_ENUM(NSInteger, ATLinkType) {
    ATLinkTypeAppStore           = 1, // storekit打开
    ATLinkTypeSafari             = 2, // 外部浏览器
    ATLinkTypeWebView            = 3, // 内部webView vc打开
    ATLinkTypeAPKDownload        = 4, // APK下载，Android特有，iOS不支持
    ATLinkTypeInnerSafari        = 5, // 调起内部safari浏览器
    ATLinkTypeWXMiniProgram      = 6, // 微信小程序
    ATLinkTypeQuickApp           = 7, // 快应用，Android特有，iOS不支持
    ATLinkTypeWXNativePage       = 8  // 微信原生页
};

typedef NS_ENUM(NSInteger, ATOfferLayoutType) {
    ATOfferLayoutTypeNormal = 0,
    ATOfferLayoutTypeExpress
};

typedef NS_ENUM(NSInteger, ATClickMode) {
    ATClickModeSync = 1,
    ATClickModeAsync
};

typedef NS_ENUM(NSInteger, ATLoadType) {
    ATLoadTypeSafari = 1,
    ATLoadTypeInternalWebview
};

typedef NS_ENUM(NSInteger, ATUserAgentType) {
    ATUserAgentWebView = 1,
    ATUserAgentSystem
};

typedef NS_ENUM(NSInteger, ATLoadStorekitTime) {
    ATLoadStorekitTimePreload = 1,
    ATATLoadStorekitTimeClick,
    ATATLoadStorekitTimeNone
};

typedef NS_ENUM(NSInteger, ATVideoClickable) {
    ATVideoClickableNone = 1,
    ATVideoClickableWithCTA
};

typedef NS_ENUM(NSInteger, ATNetworkFirmId) {
    ATNetworkFirmIdADX =  66,
    ATNetworkFirmIdMyOffer = 35,
    ATNetworkFirmIdGDTOnline = 42,
    ATNetworkFirmIdDirectOffer =  67,
};

typedef NS_ENUM(NSInteger, ATOfferModelType) {
    ATOfferModelMyOffer = 1,
    ATOfferModelADX =  2,
    ATOfferModelOnlineApi =  3,
    ATOfferModelDirectOffer =  4,
};

typedef NS_ENUM(NSInteger, ATOfferCrtType) {
    ATOfferCrtTypeOneImage = 1,
    ATOfferCrtTypeImages = 2,
    ATOfferCrtTypeOneImageWithText = 3,
    ATOfferCrtTypeImagesWithText = 4,
    ATOfferCrtTypeVideo = 5,
    ATOfferCrtTypeXHTML = 6
};

typedef NS_ENUM(NSInteger, ATDeepLinkClickMode) {
    ATDeepLinkModeNone = 1,
    ATDeepLinkModePreClickUrl = 2,
    ATDeepLinkModeLastClickUrl = 3
};

typedef NS_ENUM(NSInteger, ATClickType) {
    ATClickTypeClickUrl = 1,
    ATClickTypeDeepLinkUrl,
    ATClickTypeClickJumpUrl,
    ATClickTypeClickUniversalLinkUrl,
    ATClickTypeClickMarketUrl
};

typedef NS_ENUM(NSInteger, ATUnitGroupType) {
    ATUnitGroupTypeNormal = 1,
    ATUnitGroupTypeAdx,
    ATUnitGroupTypeC2S,
    ATUnitGroupTypeS2S,
    ATUnitGroupTypeInHouse,
    ATUnitGroupTypeBKS,
    ATUnitGroupTypeDirectOffer,
    ATUnitGroupTypeDefault,
    ATUnitGroupTypeDynamicHB,
    ATUnitGroupTypeDynamicC2S,
    ATUnitGroupTypeDynamicS2S,

};

typedef NS_ENUM(NSInteger, ATSplashType) {
    ATSplashTypeSplice = 1,
    ATSplashTypeFullScreen
};

typedef NS_ENUM(NSInteger, ATSplashImageScaleType) {
    ATSplashImageScaleTypeFit = 1,
    ATSplashImageScaleTypeFill
};

typedef NS_ENUM(NSInteger, ATBiddingCurrencyType) {
    ATBiddingCurrencyTypeUS        = 1,
    ATBiddingCurrencyTypeCNY       = 2,
    ATBiddingCurrencyTypeCNYCents  = 3
};

typedef NS_ENUM(NSInteger, ATOfferClickAdType) {
    ATOfferClickAdTypeUserClick = 1,
    ATOfferClickAdTypeAutoClickAfterDelay =  2,
    ATOfferClickAdTypeAutoClickAfterFinish = 3,
    ATOfferClickAdTypeShakeClick = 4,
    ATOfferClickAdTypeAutoClickImageClick = 5,
    ATOfferClickAdTypeAutoClickVideoClick = 6,
    ATOfferClickAdTypeAutoClickEndCardClick = 7,
    ATOfferClickAdTypeStoresKitClick = 8,
    ATOfferClickAdTypeSKOverlyClick = 9,
    ATOfferClickAdTypeInvalidCloseButtonClick = 10,
    ATOfferClickAdTypeGuideOverlyClick = 11,
    ATOfferClickAdTypeAdWithoutSlideClick = 12,
    ATOfferClickAdTypeAdInsideSlideClick = 13,
    ATOfferClickAdTypeEndCardFloatingLayerGuideClick = 14,
    ATOfferClickAdTypeEndCardRetentionPageClick = 15,
    ATOfferClickAdTypeRewardedVideoTaskClick = 16,
    ATOfferClickAdTypeBubbleDropClick = 17,
};

typedef NS_ENUM(NSInteger, ATOfferAdpType) {
    ATOfferAdpTypeNormal = 0,
    ATOfferAdpTypeMraid = 1,
    ATOfferAdpTypeVast = 2
};

typedef NS_ENUM(NSInteger, ATOfferADPAcceptType) {
    ATOfferADPAcceptTypeMraid = 1,
    ATOfferADPAcceptTypeVast = 2,
    ATOfferADPAcceptTypePMP = 3
};

typedef NS_ENUM(NSInteger, ATGuideClickOverlayType) {
    ATGuideClickOverlayTypeUnknown            = 0,
    ATGuideClickOverlayTypeGestureGuidance    = 1,  // 滑动手势
    ATGuideClickOverlayTypeDragPuzzle         = 2,  // 拖动拼图
    ATGuideClickOverlayTypeQAPopup            = 3,  // 问答弹窗
    ATGuideClickOverlayTypeNoviceGuide        = 4,  // 引导弹窗
    ATGuideClickOverlayTypeConfirmJump        = 5,  // 跳转确认
    ATGuideClickOverlayTypeFingerClickGuide   = 6,  // 手指点击引导
    ATGuideClickOverlayTypeFullScreenSwipe    = 7,  // 全屏滑动
    ATGuideClickOverlayTypeLuckybag           = 8,  // 福袋
    ATGuideClickOverlayTypeChopOnce           = 9,  // 砍一刀
    ATGuideClickOverlayTypeSlidePuzzle        = 10, // 滑动拼图有惊喜
    ATGuideClickOverlayTypeGestureSlide       = 11, // 新滑动手势
    ATGuideClickOverlayTypeGesureClick        = 12, // 新手指点击引导
    ATGuideClickOverlayTypeBigWhiteHand       = 13  // 大白指滑动
};

typedef NS_ENUM(NSInteger, ATRVTncentiveTaskType) {
    ATRVTncentiveTaskTypeNone              = 1,
    ATRVTncentiveTaskTypeReduceDuration    = 2,
    ATRVTncentiveTaskTypeADFree            = 3
};

typedef NS_ENUM(NSInteger, ATAdOfferInterType) {
    ATAdOfferInterTypeFull = 1,
    ATAdOfferInterTypeHalf
};

typedef NS_ENUM(NSInteger, ATADXMixFormat) {
    ATADXMixFormatNative = 1,
    ATADXMixFormatRewardedVideo = 2,
    ATADXMixFormatBanner = 3,
    ATADXMixFormatInterstitial = 4,
    ATADXMixFormatSplash = 5,
};

@interface ATModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
