//
//  ATSDKGlobalSetting.h
//  AnyThinkSDK
//
//  Created by Topon on 8/23/23.
//  Copyright © 2023 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/ATAdLoadingDelegate.h>

NS_ASSUME_NONNULL_BEGIN
@class ATCustomContentInfo, ATCustomContentResult, ATAntiBrushConfig, ATRiskControlModel, ATAdCustomFilter;
extern NSString *const kATDeviceDataInfoOSVersionNameKey; //System version name
extern NSString *const kATDeviceDataInfoOSVersionCodeKey; //System version code
extern NSString *const kATDeviceDataInfoPackageNameKey; //Application package name
extern NSString *const kATDeviceDataInfoAppVersionNameKey; //Application version name
extern NSString *const kATDeviceDataInfoAppVersionCodeKey; //Application version code
extern NSString *const kATDeviceDataInfoBrandKey; //Phone brands
extern NSString *const kATDeviceDataInfoCPUKey; //Phone cpu
extern NSString *const kATDeviceDataInfoModelKey; //Phone model
extern NSString *const kATDeviceDataInfoScreenKey; //Screen Resolution
extern NSString *const kATDeviceDataInfoNetworkTypeKey; //Network Type
extern NSString *const kATDeviceDataInfoMNCKey; //Mobile Network Code
extern NSString *const kATDeviceDataInfoMCCKey; //Mobile Country Code
extern NSString *const kATDeviceDataInfoLanguageKey; //Language
extern NSString *const kATDeviceDataInfoTimeZoneKey; //Time zone
extern NSString *const kATDeviceDataInfoUserAgentKey; //User Agent
extern NSString *const kATDeviceDataInfoOrientKey; //Screen orientation
extern NSString *const kATDeviceDataInfoIDFAKey; //idfa
extern NSString *const kATDeviceDataInfoIDFVKey; //idfv
extern NSString *const kATDeviceDataInfoSIMCardStateKey; //sim card status
extern NSString *const kATDeviceDataInfoBatteryKey; //sim card status

typedef NS_ENUM(NSUInteger, ATSplashAdClickResultType) {
    ATSplashAdClickResultTypeDidCloseAd         = 1,  // After clicking on the jump button, close the splash ad
    ATSplashAdClickResultTypePauseCountdown     = 2,  // Pause the countdown after clicking the jump button, and continue the countdown when the splash ad is visible
};

/// Debug values for testing geography.
typedef NS_ENUM(NSInteger, ATUMPDebugGeography) {
    ATUMPDebugGeographyDisabled = 0,  ///< Disable geography debugging.
    ATUMPDebugGeographyEEA = 1,       ///< Geography appears as in EEA for debug devices.
    ATUMPDebugGeographyNotEEA = 2,    ///< Geography appears as not in EEA for debug devices.
};

typedef NS_ENUM(NSInteger, ATSystemPlatformType) {
    ATSystemPlatformTypeUnknown = 0,
    ATSystemPlatformTypeIOS = 1,
    ATSystemPlatformTypeUnity = 2,
    ATSystemPlatformTypeCocos2dx = 3,
    ATSystemPlatformTypeCocosCreator = 4,
    ATSystemPlatformTypeReactNative = 5,
    ATSystemPlatformTypeFlutter = 6,
    ATSystemPlatformTypeAdobeAir = 7
};

@interface ATSDKGlobalSetting : NSObject

+ (instancetype)sharedManager;

/*
 channel & customData has to be set before init
 */
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *subchannel;
@property (nonatomic, strong) NSDictionary *customData;
/// Splash Shake Text String, Only for DirectlyAd
@property (nonatomic, strong) NSString *directlySplashAdShakeTextString;
/// Splash CTA Button BackgroundColor, Only for DirectlyAd
@property (nonatomic, strong) UIColor *directlySplashAdCTAButtonBackgroundColor;
/// Splash Shake Custom View, Only for DirectlyAd
@property (nonatomic, strong) UIView *directlySplashAdCustomShakeView;
/// Splash CTA Custom View, Only for DirectlyAd
@property (nonatomic, strong) UIView *directlySplashAdCustomCTAView;
/// Splash Video Mute Icon hidden, Not hidden by default,  Only for DirectlyAd
@property (nonatomic, assign) BOOL directlySplashAdVideoMuteIconHidden;
/// Whether to pause the countdown after clicking on the  Splash ad to jump, the default is NO, Only for TopOn ADX、DirectlyAd and Cross Promotion
@property (nonatomic, assign) ATSplashAdClickResultType splashAdClickResultType;

// ump test ids
@property (nonatomic, nullable,strong) NSArray<NSString *> *umpTestDeviceIdentifiers;
/// Debug geography.
@property (nonatomic, assign) ATUMPDebugGeography umpGeography;
/// set header bidding test mode,only support incoming device idfa.
/// setLogEnabled must be turned on before use
@property (nonatomic, strong) NSString *headerBiddingTestModeDeviceID;
/// system platform Information
@property (nonatomic, assign) ATSystemPlatformType systemPlatformType;

@property (nonatomic, strong) ATSharePlacementConfig *sharePlacementConfig;
/// set whether WX is installed
@property (nonatomic, assign) BOOL isInstallWX;
/// for setLocationLongitude:dimension:
@property (nonatomic, readonly) NSDictionary *locationDictionary;

/// set custom data for the ad placement
/// @param customData - custom data
/// @param placementID - placement id
- (void)setCustomData:(NSDictionary *)customData forPlacementID:(NSString *)placementID;

/// get custom data
- (NSDictionary *)customDataForPlacementID:(NSString *)placementID;

/// set Wechat appID and universalLink, for register WechatOpenSDK
/// @param appID - Wechat appID
/// @param universalLink - Wechat universalLink
- (void)setWeChatAppID:(NSString *)appID universalLink:(NSString *)universalLink;

- (void)addCustomAdapterConfigArray:(NSArray <ATCustomNetworkMode *>*)array;

/// set exlude appleid list for sdk to filter offers
- (void)setExludeAppleIdArray:(NSArray *)appleIdArray;

/// get exlude appleid list
- (NSArray *)exludeAppleIdArray;

/// set denied Upload Info list for sdk to Control report
- (void)setDeniedUploadInfoArray:(NSArray *)uploadInfoArray;

/// get denied Upload Info list
- (NSArray *)deniedUploadInfoArray;

/// Determine whether the Denied key is included
/// @param key - key string
- (BOOL)isContainsForDeniedUploadInfoArray:(NSString *)key;

- (void)setPresetPlacementConfigPathBundle:(NSBundle *)bundle;

/// set location longitude
- (void)setLocationLongitude:(double)longitude dimension:(double)dimension;

- (void)setDebuggerConfig:(void(^_Nullable)(ATDebuggerConfig * _Nullable debuggerConfig))debuggerConfigBlock;

- (void)setDeviceInfoConfig:(void(^_Nullable)(ATDeviceInfoConfig * _Nullable deviceInfoConfig))deviceInfoConfigBlock;

/// Delete all ads cached for the placementId
- (void)removeAllCacheWithPlacementId:(NSString *)placementId;
- (void)removeAllCacheWithPlacementId:(NSString *)placementId index:(NSInteger)index;
- (void)removeAllCacheWithPlacementId:(NSString *)placementId adInfoDictArray:(NSArray<NSDictionary *> *)adInfoDictArray;

- (void)setAuthNetworkArray:(NSArray <NSString *> *)networkFilmIdArray DEPRECATED_MSG_ATTRIBUTE("Deprecated; setting is ineffective.");


/// Set up anti-fraudulent traffic information
/// - Parameter config: config
- (void)setAntiBrushConfig:(ATAntiBrushConfig *)config;

/// Get risk tag
- (nullable ATRiskControlModel *)riskControlInfo;

- (ATCustomContentInfo *)customContentReviewResult:(NSArray<ATCustomContentInfo *> *)infos;

- (ATCustomContentResult *)customContentResultReviewByInfos:(NSArray<ATCustomContentInfo *> *)infos;

/// 是否允许异常信息收集
/// - Parameter isPermit: 默认为YES
- (void)setAbnormalCollect:(BOOL)isPermit;

/// 添加过滤器 开发者传入placementID
/// 多个placementID 可以共用一个过滤器
/// - Parameter filter: 过滤器
- (void)addFilter:(ATAdCustomFilter *)filter forPlacementID:(NSString *)placementID;

/// 删除所有过滤器
- (void)removeAllFilters;

/// 删除部分过滤器
/// - Parameter placementIDs: 过滤器对应的广告位id
- (void)removeFilterWithPlacementIDs:(NSArray <NSString *> *)placementIDs;

@end

NS_ASSUME_NONNULL_END
