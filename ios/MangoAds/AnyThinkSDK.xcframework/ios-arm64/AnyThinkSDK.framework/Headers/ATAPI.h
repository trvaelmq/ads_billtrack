//
//  ATAPI.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 09/04/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AnyThinkSDK/ATNetwokBaseConfigure.h>
#import <AnyThinkSDK/ATSDKConfiguration.h>
#import <AnyThinkSDK/ATDebuggerConfig.h>
#import <AnyThinkSDK/ATDeviceInfoConfig.h>
#import <AnyThinkSDK/ATCustomNetworkMode.h>
#import <AnyThinkSDK/ATSharePlacementConfig.h>
#import <AnyThinkSDK/ATSDKGlobalSetting.h>
#import <AnyThinkSDK/ATAdErrorCode.h>
#import <AnyThinkSDK/ATCustomContentResult.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kATADDelegateExtraNetworkFirmIdKey;
extern NSString *const kATADDelegateExtraAdSourceIdKey;
extern NSString *const kATADDelegateExtraIsHeaderBiddingKey;
extern NSString *const kATADDelegateExtraBidModeKey;
extern NSString *const kATADDelegateExtraAdSourcePriceKey;
extern NSString *const kATADDelegateExtraPriorityKey;
extern NSString *const kATADDelegateExtraBidFloorKey;
extern NSString *const kATADDelegateExtraRequestIDKey;
extern NSString *const kATADDelegateExtraCustomExtKey;
extern NSString *const kATADDelegateExtraECPMLevelKey; // the eCPM level of the ad source
extern NSString *const kATADDelegateExtraSegmentIDKey; //segment ID
extern NSString *const kATADDelegateExtraScenarioIDKey; // Advertising Scene ID,Only Rewarded Video and Interstitial support
extern NSString *const kATADDelegateExtraChannelKey; // Channel Information
extern NSString *const kATADDelegateExtraSubChannelKey; // sub-channel information
extern NSString *const kATADDelegateExtraCustomRuleKey; // Json string of the Placement + App dimension custom rule
extern NSString *const kATADDelegateExtraIDKey; // a unique ID generated for each impression
extern NSString *const kATADDelegateExtraAdunitIDKey; // TopOn placement ID
extern NSString *const kATADDelegateExtraPublisherRevenueKey; // impression revenue
extern NSString *const kATADDelegateExtraCurrencyKey; // currency unit, for example: "USD"
extern NSString *const kATADDelegateExtraCountryKey; // country code, for example: "CN"
extern NSString *const kATADDelegateExtraFormatKey; // ad source types
extern NSString *const kATADDelegateExtraPrecisionKey; // eCPM precision
extern NSString *const kATADDelegateExtraNetworkTypeKey; // Network Type
extern NSString *const kATADDelegateExtraNetworkPlacementIDKey; // the ad placement ID of a third-party Ads Network
extern NSString *const kATADDelegateExtraScenarioRewardNameKey; // reward name of the ad Scenario,Only Rewarded Video support
extern NSString *const kATADDelegateExtraScenarioRewardNumberKey; // number of reward for the ad Scenario，Only Rewarded Video support
extern NSString *const kATADDelegateExtraPlacementRewardNameKey;
extern NSString *const kATADDelegateExtraPlacementRewardNumberKey;
extern NSString *const kATADDelegateExtraExtInfoKey; // additional information of Topon Adx & OnlineAPI Offer,output as Json string
extern NSString *const kATADDelegateExtraOfferIDKey;
extern NSString *const kATADDelegateExtraCreativeIDKey;
extern NSString *const kATADDelegateExtraIsDeeplinkKey;
extern NSString *const kATADDelegateExtraUserCustomData;
extern NSString *const kATADDelegateExtraPlacementTypeKey;
extern NSString *const kATADDelegateExtraSharedPlacementIdKey;
extern NSString *const kATADDelegateExtraNetworkNameKey;
extern NSString *const kATADDelegateExtraShowCustomExtKey;
extern NSString *const kATADDelegateExtraCustomContentResultKey;
extern NSString *const kATADDelegateExtraTpBidIDKey;
extern NSString *const kATADDelegateExtraABTestIDKey;
extern NSString *const kATADDelegateExtraDismissTypeKey;
extern NSString *const kATADDebuggerKey;
extern NSString *const kATADDelegateExtraServerKeyIdKey;
extern NSString *const kATADDelegateExtraClientSideEcpmKey;
extern NSString *const kATADDelegateExtraUsdExchangeRmbRateKey;
extern NSString *const kATADDelegateExtraRmbExchangeUsdRateKey;

// TODO待优化
extern NSString *const kATNetworkNameFyber;
extern NSString *const kATNetworkNameStartApp;
extern NSString *const kATNetworkNameFacebook;
extern NSString *const kATNetworkNameTanx;
extern NSString *const kATNetworkNameInmobi;
extern NSString *const kATNetworkNameAdmob;
extern NSString *const kATNetworkNameMintegral;
extern NSString *const kATNetworkNameApplovin;
extern NSString *const kATNetworkNameGDT;
extern NSString *const kATNetworkNameTapjoy;
extern NSString *const kATNetworkNameChartboost;
extern NSString *const kATNetworkNameIronSource;
extern NSString *const kATNetworkNameVungle;
extern NSString *const kATNetworkNameAdColony;
extern NSString *const kATNetworkNameUnityAds;
extern NSString *const kATNetworkNameTT;
extern NSString *const kATNetworkNamePangle;
extern NSString *const kATNetworkNameBaidu;
extern NSString *const kATNetworkNameNend;
extern NSString *const kATNetworkNameMaio;
extern NSString *const kATNetworkNameSigmob;
extern NSString *const kATNetworkNameMyOffer;
extern NSString *const kATNetworkNameKS;
extern NSString *const kATNetworkNameOgury;
extern NSString *const kATNetworkNameGoogleAdManager;
extern NSString *const kATNetworkNameADX;
extern NSString *const kATNetworkNameHelium;
extern NSString *const kATNetworkNameMintegralOnlineApi;
extern NSString *const kATNetworkNameGDTOnlineApi;
extern NSString *const kATNetworkNameKidoz;
extern NSString *const kATNetworkNameMyTarget;
extern NSString *const kATNetworkNameMobrain;
extern NSString *const kATNetworkNameYandex;
extern NSString *const kATNetworkNamePubNative;
extern NSString *const kATNetworkNameBigo;
extern NSString *const kATNetworkNameAdxPublic;
extern NSString *const kATNetworkNameJADYun;
extern NSString *const kATNetworkNameKwai;
extern NSString *const kATNetworkNameIMA;
extern NSString *const kATNetworkNameMax;
extern NSString *const kATNetworkNameklevin;
extern NSString *const kATNetworkNameQumeng;
extern NSString *const kATNetworkNameSmaato;
extern NSString *const kATNetworkNameBidMachine;

extern NSString *const kATCustomDataUserIDKey;//string
extern NSString *const kATCustomDataAgeKey;//Integer
extern NSString *const kATCustomDataGenderKey;//Integer
extern NSString *const kATCustomDataNumberOfIAPKey;//Integer
extern NSString *const kATCustomDataIAPAmountKey;//Double
extern NSString *const kATCustomDataIAPCurrencyKey;//string
extern NSString *const kATCustomDataChannelKey;//string
extern NSString *const kATCustomDataSubchannelKey;//string
extern NSString *const kATCustomDataSegmentIDKey;//int

extern NSString *const kATAdLoadingExtraBUAdLoadTypeKey;
extern NSString *const kATNetWorkVideoStatusKey;

typedef NS_ENUM(NSInteger, ATNetworkFirmIDType) {
    ATNetworkFirmIDTypeFacebook = 1,
    ATNetworkFirmIDTypeAdmob = 2,
    ATNetworkFirmIDTypeInmobi = 3,
    ATNetworkFirmIDTypeApplovin = 5,
    ATNetworkFirmIDTypeMintegral = 6,
    ATNetworkFirmIDTypeGDT = 8,
    ATNetworkFirmIDTypeChartboost = 9,
    ATNetworkFirmIDTypeTapjoy = 10,
    ATNetworkFirmIDTypeIronSource = 11,
    ATNetworkFirmIDTypeUnityAds = 12,
    ATNetworkFirmIDTypeVungle = 13,
    ATNetworkFirmIDTypeAdColony = 14,
    ATNetworkFirmIDTypeCSJ = 15,
    ATNetworkFirmIDTypeBaidu = 22,
    ATNetworkFirmIDTypeNend = 23,
    ATNetworkFirmIDTypeMaio = 24,
    ATNetworkFirmIDTypeStartApp = 25,
    ATNetworkFirmIDTypeKuaishou = 28,
    ATNetworkFirmIDTypeSigmob = 29,
    ATNetworkFirmIDTypeMyTarget = 32,
    ATNetworkFirmIDTypeGoogleAdManager = 33,
    ATNetworkFirmIDTypeYandex = 34,
    ATNetworkFirmIDTypeCrossPromotion = 35,
    ATNetworkFirmIDTypeOgury = 36,
    ATNetworkFirmIDTypeFyber = 37,
    ATNetworkFirmIDTypeHelium = 40,
    ATNetworkFirmIDTypeMintegralOnlineApi = 41,
    ATNetworkFirmIDTypeGDTOnlineApi = 42,
    ATNetworkFirmIDTypeKidoz = 45,
    ATNetworkFirmIDTypePangle = 50,
    ATNetworkFirmIDTypeKlevin = 51,
    ATNetworkFirmIDTypePubNative = 58,
    ATNetworkFirmIDTypeBigo = 59,
    ATNetworkFirmIDTypeBidMachine = 65,
    ATNetworkFirmIDTypeTopOnADX = 66,
    ATNetworkFirmIDTypeJD = 72,
    ATNetworkFirmIDTypeQumeng = 74,
    ATNetworkFirmIDTypeIMA = 76,
    ATNetworkFirmIDTypeKwai = 77,
    ATNetworkFirmIDTypeTanx = 82,
    ATNetworkFirmIDTypeSmaato = 84,
};

typedef NS_ENUM(NSInteger, ATUserLocation) {
    ATUserLocationUnknown = 0,
    ATUserLocationInEU = 1,
    ATUserLocationOutOfEU = 2
};

typedef NS_ENUM(NSInteger, ATDataConsentSet) {
    //Let it default to forbidden if not set
    ATDataConsentSetUnknown = 0,
    ATDataConsentSetPersonalized = 1,
    ATDataConsentSetNonpersonalized = 2
};

typedef NS_ENUM(NSInteger, ATBUAdLoadType) {
    ATBUAdLoadTypeUnknown                    = -1,//Unknown
    ATBUAdLoadTypePreload                    = 1,//Preload resources
    ATBUAdLoadTypeLoad                       = 3,//Load resources in real time
};

typedef NS_ENUM(NSInteger, ATPersonalizedAdState) {
    ATPersonalizedAdStateType = 1,
    ATNonpersonalizedAdStateType = 2
};

typedef NS_OPTIONS(NSInteger, ATLogType) {
    ATLogTypeNone = 0,
    ATLogTypeInternal = 1 << 0,
    ATLogTypeExternal = 1 << 1,
    ATLogTypeTemporary = 1 << 2,
    ATLogTypeProcess = 1 << 3,
    ATLogTypeSave = 1 << 4
};

// Position of the logo icon in the containing ad.
typedef NS_ENUM(NSInteger, ATAdLogoPosition) {
    ATAdLogoPositionBottomRightCorner = 0,  ///< Bottom right corner.
    ATAdLogoPositionBottomLeftCorner,   ///< Bottom Left Corner.
    ATAdLogoPositionTopRightCorner,     ///< Top right corner.
    ATAdLogoPositionTopLeftCorner,      ///< Top left corner.
};

@interface ATConsentPrivacySetting : NSObject

/// Set this to @c YES to enable the consent flow. You must also provide your privacy policy and terms of service URLs in this object, and you must provide a
///* @c NSUserTrackingUsageDescription string in your @code Info.plist @endcode file.
@property (nonatomic, assign, getter=isEnabled) BOOL enabled;

/// URL for your company’s privacy policy. This is required
@property (nonatomic, copy, nullable) NSURL *privacyPolicyURL;

/// URL for your company’s terms of service. This is optional
@property (nonatomic, copy, nullable) NSURL *termsOfServiceURL;

@end

@interface ATShowConfig : NSObject

@property (nonatomic, readonly) NSString *scene;
@property (nonatomic, readonly) NSString *showCustomExt;
@property (nonatomic, readonly) ATCustomContentResult *customContentResult;
@property (nonatomic, weak) UIViewController *showViewController;

@property (nonatomic, strong) NSDictionary *atAdInfo;

- (instancetype)initWithScene:(nullable NSString *)scene showCustomExt:(nullable NSString *)showCustomExt;
- (instancetype)initWithScene:(nullable NSString *)scene showCustomExt:(nullable NSString *)showCustomExt customContentResult:(nullable ATCustomContentResult *)customContentResult;

@end

@interface ATAPI : NSObject

/// singleton object
+ (instancetype)sharedInstance;

/// Initialize SDK
/// @param appID - appid string
/// @param appKey appkey string
/// @param error - see what's the matter.
- (BOOL)startWithAppID:(NSString *)appID
                appKey:(NSString *)appKey
                 error:(NSError **)error;

/// Initialize SDK
/// @param appID - appid string
/// @param appKey appkey string
/// @param sdkConfigure preinit network configure
/// @param error - see what's the matter.
- (BOOL)startWithAppID:(NSString *)appID
                appKey:(NSString *)appKey
         sdkConfigures:(ATSDKConfiguration *)sdkConfigure
                 error:(NSError **)error;
/// 更新初始化sdkConfigure,内部属性:ATAdChannelSource
- (void)updateSdkConfigure:(ATSDKConfiguration *)sdkConfigure;

/// map network firm id list
+ (NSDictionary<NSNumber*, NSString*>*)networkNameMap;

/// Whether the network platform integration integrity information is normal
+ (void)integrationChecking;

/// set location longitude
- (void)setLocationLongitude:(double)longitude dimension:(double)dimension DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager] setLocationLongitude:dimension: instead ");

/// set whether WX is installed
/// @param isInstallWX - install status
- (void)setWXStatus:(BOOL)isInstallWX DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager].isInstallWX instead ");

/// consentString might be nil.
/// This method is thread-safe.
- (void)setDataConsentSet:(ATDataConsentSet)dataConsentSet
            consentString:(NSDictionary<NSString*, NSString*>*)consentString;

/// Whether the device is located in data protected area.
- (BOOL)inDataProtectionArea;

/// get user location
/// @param callback - location type
- (void)getUserLocationWithCallback:(void(^)(ATUserLocation location))callback;

/// get Area
/// @param success - arear string
/// @param failure - error message
- (void)getAreaSuccess:(void(^)(NSString *areaCodeStr))success
               failure: (void(^)(NSError *error))failure;

/// get ps id
- (NSString *)psID;

/// Log enabled
/// @param logEnabled - log status
+ (void)setLogEnabled:(BOOL)logEnabled;

/// Log enabled
/// @param cacheEnabled log localCache status
+ (void)logLocalCacheEnabled:(BOOL)cacheEnabled;

+ (void)setDebuggerConfig:(void(^_Nullable)(ATDebuggerConfig * _Nullable debuggerConfig))debuggerConfigBlock DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager] setDebuggerConfig: instead ");

+ (void)setDeviceInfoConfig:(void(^_Nullable)(ATDeviceInfoConfig * _Nullable deviceInfoConfig))deviceInfoConfigBlock DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager] setDeviceInfoConfig: instead ");

+ (void)addCustomAdapterConfigArray:(NSArray <ATCustomNetworkMode *>*)array DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager] addCustomAdapterConfigArray: instead ");

/// print test info log
/// include idfa,idfv
+ (void)testModeInfo;
    
/**
 * Show the data consent dialog using the specified constroller as the presenting view controller.
 * viewController might be nil, for which the root view controller of the window will be used instead.
 */
- (void)presentDataConsentDialogInViewController:(UIViewController *)viewController
                               dismissalCallback:(void(^)(void))dismissCallback DEPRECATED_MSG_ATTRIBUTE("use showGDPRConsentDialogInViewController:dismissalCallback: instead ");

- (void)presentDataConsentDialogInViewController:(UIViewController *)viewController
                          loadingFailureCallback:(void(^)(NSError *error))loadingFailureCallback
                               dismissalCallback:(void(^)(void))dismissCallback DEPRECATED_MSG_ATTRIBUTE("use showGDPRConsentDialogInViewController:dismissalCallback: instead ");

/// show UMP GDPR Auth
- (void)showGDPRConsentDialogInViewController:(UIViewController *)viewController
                         dismissalCallback:(void(^)(void))dismissCallback;

@property (nonatomic, readonly) ATDataConsentSet dataConsentSet;
@property (nonatomic, readonly) NSDictionary<NSString*, NSString*>* consentStrings;
@property (nonatomic, readonly) NSString *appID;
@property (nonatomic, readonly) NSString *appKey;
/*
 channel & customData has to be set before init
 */
@property (nonatomic, strong) NSString *channel DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager].channel instead ");
@property (nonatomic, strong) NSString *subchannel DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager].subchannel instead ");
@property (nonatomic, strong) NSDictionary *customData DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager].customData instead ");

@property (nonatomic, readonly,class) NSDate *firstLaunchDate;

/// Indicates preferred location of logo icon. Default is ATAdLogoPositionBottomRightCorner.
@property (nonatomic, assign) ATAdLogoPosition preferredAdLogoPosition;

/// set custom data for the ad placement
/// @param customData - custom data
/// @param placementID - placement id
- (void)setCustomData:(NSDictionary *)customData forPlacementID:(NSString *)placementID DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager] setCustomData:forPlacementID: instead ");

/// get custom data
- (NSDictionary *)customDataForPlacementID:(NSString *)placementID DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager] customDataForPlacementID: instead ");

/// get SDK version
- (NSString *)version;

/// set exlude appleid list for sdk to filter offers
- (void)setExludeAppleIdArray:(NSArray *)appleIdArray DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager] setExludeAppleIdArray: instead ");

/// get exlude appleid list
- (NSArray *)exludeAppleIdArray DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager] exludeAppleIdArray: instead ");

/// set denied Upload Info list for sdk to Control report
- (void)setDeniedUploadInfoArray:(NSArray *)uploadInfoArray DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager] setDeniedUploadInfoArray: instead ");

/// get denied Upload Info list
- (NSArray *)deniedUploadInfoArray DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager] deniedUploadInfoArray: instead ");

/// Determine whether the Denied key is included
/// @param key - key string
- (BOOL)isContainsForDeniedUploadInfoArray:(NSString *)key DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager] isContainsForDeniedUploadInfoArray: instead ");

/// set header bidding test mode,only support incoming device idfa.
/// setLogEnabled must be turned on before use
+ (void)setHeaderBiddingTestModeWithDeviceID:(NSString *)idfa DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager].headerBiddingTestModeDeviceID instead ");

/// set personalized recommendation state
/// @param state - 1 is to close personalized recommendation, other values or not set to open
- (void)setPersonalizedAdState:(ATPersonalizedAdState)state;

/// get personalized recommendation state
- (ATPersonalizedAdState)getPersonalizedAdState;

- (void)setConsentPrivacySetting:(ATConsentPrivacySetting *)settings;

/// Set System Platform Information
- (void)setSystemPlatformType:(ATSystemPlatformType)type DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager].systemPlatformType instead ");

/// set Wechat appID and universalLink, for register WechatOpenSDK
/// @param appID - Wechat appID
/// @param universalLink - Wechat universalLink
- (void)setWeChatAppID:(NSString *)appID universalLink:(NSString *)universalLink DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager] setWeChatAppID:universalLink: instead ");

- (void)setPresetPlacementConfigPathBundle:(NSBundle *)bundle DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager] setPresetPlacementConfigPathBundle: instead ");

- (void)setSharePlacementConfig:(ATSharePlacementConfig *)config DEPRECATED_MSG_ATTRIBUTE("use [ATSDKGlobalSetting sharedManager].sharePlacementConfig instead ");

/// 展示指定Networks
- (void)setAllowedShowNetworkFimIdArray:(NSArray <NSString *>*)networkFilmIdArray forPlacementID:(NSString *)placementID;
/// 不展示指定Networks
- (void)setForbidShowNetworkFirmIdArray:(NSArray<NSString *>*)networkFilmIdArray forPlacementID:(NSString *)placementID;
/// 不加载指定Networks
- (void)setForbidLoadNetworkFirmIdArray:(NSArray<NSString *>*)networkFilmIdArray;


NS_ASSUME_NONNULL_END
@end


