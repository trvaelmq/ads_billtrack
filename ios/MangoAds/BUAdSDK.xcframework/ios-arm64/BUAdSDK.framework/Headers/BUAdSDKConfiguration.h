//
//  BUAdSDKConfiguration.h
//  BUAdSDK
//
//  Created by Eason on 2021/3/4.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "BUAdSDKDefines.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "BUAdSDKPrivacyProvider.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BUAudioSessionSettingType) {
    BUAudioSessionSettingType_Default   = 1 << 2,
    BUAudioSessionSettingType_Mix       = 1 << 5, //可以跟其他音乐软件共存声音
    BUAudioSessionSettingType_DisableLiveModify = 1 << 6 //禁止直播修改
};

@interface BUAdSDKConfiguration : NSObject

+ (instancetype)configuration NS_SWIFT_NAME(configuration());

///Register the App key that’s already been applied before requesting an ad from TikTok Audience Network.
/// the unique identifier of the App
@property (nonatomic, copy, nullable) NSString *appID;

/// the unique identifier of the App, more safely
@property (nonatomic, copy, nullable) NSString *secretKey;

/// the age group of the user
/// only works in CN environment
@property (nonatomic, assign) BUAdSDKAgeGroup ageGroup;

/// additional user information.
@property (nonatomic, copy, nullable) NSString *userExtData;

/// Solve the problem when your WKWebview post message empty,
/// default is BUOfflineTypeWebview
@property (nonatomic, assign) BUOfflineType webViewOfflineType;

/// Custom set the debugLog to print debug Log.
/// debugLog 0: close debug log, 1: open debug log.
@property (nonatomic, strong, nullable) NSNumber *debugLog;

@property (nonatomic, strong, nullable) NSNumber *themeStatus;

/// Custom set the AB vid of the user. Array element type is NSNumber
@property (nonatomic, strong, nullable) NSArray<NSNumber *> *abvids;

/// Custom set the tob ab sdk version of the user.
@property (atomic, copy, nullable) NSString *abSDKVersion;

/// Custom set idfa value.
/// @Note :  聚合广告维度下，支持的adn为：CSJ，KS，Sigmob，Mintegral
@property (nonatomic, copy, nullable) NSString *customIdfa;

/**
 In CN environment Whether to allow SDK to modify the category and options of AVAudioSession when playing audio, default is NO.
 The category set by the SDK is AVAudioSessionCategoryAmbient, and the options are AVAudioSessionCategoryOptionDuckOthers
 In VA environment Whether to allow SDK to modify the category and options of AVAudioSession when playing audio. When the scene is native or banner and current category is AVAudioSessionCategorySoloAmbient, default value is YES and the category set by the SDK is AVAudioSessionCategoryAmbient, the options are AVAudioSessionCategoryOptionMixWithOthers.The other scenes, default is NO.
 */
@property (nonatomic, assign) BOOL allowModifyAudioSessionSetting;

@property (nonatomic, assign) BUAudioSessionSettingType audioSessionSetType;

/**
 If you are a Unity developer, set this to Yes
 */
@property (nonatomic, assign) BOOL unityDeveloper;

/// You can use this property to set whether the SDK can use certain privacy data, or pass these privacy data yourself.
/// If this property is not set, the SDK will execute the default privacy data usage logic.
/// Note: This property is only valid for the CN environment. Unless you know what you need, it is recommended not to assign a value to this property.
@property (nonatomic, strong, nullable) id<BUAdSDKPrivacyProvider> privacyProvider;

/// App logo image. If set, it will be displayed in the App open ad.
@property (nonatomic, strong, nullable) UIImage *appLogoImage;


/// Whether the SDK is in debug mode ,the default is NO
/// When set to YES, some necessary debugging information will be initialized
/// @warning It is recommended to set it to YES in the development phase, which can output necessary debugging information during the development phase, which is convenient for debugging and exception resolution.
/// When publishing the app, it is recommended to set it to NO, otherwise the extra output will increase the performance.
@property (nonatomic, assign) BOOL SDKDEBUG;

/// Note: set before BUAdSDKManager initialize
@property (nonatomic, strong, nullable) CTTelephonyNetworkInfo *customNetworkInfo;

/// Set this property to YES if TTSDK is used in your bussiness.
@property (nonatomic, assign) BOOL unionTTSDK;

@end

NS_ASSUME_NONNULL_END
