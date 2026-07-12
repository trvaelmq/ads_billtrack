//
//  BUAdSDKManager.h
//  BUAdSDK
//
//  Copyright © 2017 bytedance. All rights reserved.
//

#import "BUInterfaceBaseObject.h"
#import <UIKit/UIKit.h>
#import "BUAdSDKDefines.h"
#import "BUMopubAdMarkUpDelegate.h"


typedef NS_ENUM(NSInteger, BUAdSDKInitializationState) {
    BUAdSDKInitializationStateNotReady = 0,
    BUAdSDKInitializationStateReady = 1
};

typedef NS_ENUM(NSInteger, BUAdSDKState) {
    /// The SDK have not start.
    BUAdSDKStateNotStart = 0,
    /// The SDK has been started.
    BUAdSDKStateStart = 1
};

NS_ASSUME_NONNULL_BEGIN
typedef void (^BUCompletionHandler)(BOOL success, NSError * _Nullable error);
 __attribute__((objc_subclassing_restricted))
@interface BUAdSDKManager : BUInterfaceBaseObject

@property (nonatomic, copy, readonly, class, nonnull) NSString *SDKVersion;

/// The SDK initialization state
@property (nonatomic, assign, readonly, class) BUAdSDKInitializationState initializationState DEPRECATED_MSG_ATTRIBUTE("Please use +[BUAdSDKManager state] instead.");

/// The SDK state
@property (nonatomic, assign, readonly, class) BUAdSDKState state;

/// The synchronize initialization method
/// @param completionHandler Callback to the initialization state of the calling thread
+ (void)startWithSyncCompletionHandler:(BUCompletionHandler)completionHandler;

/// The asynchronize initialization method
/// @param completionHandler Callback to the initialization state of the non-main thread
// Mediation:/// @note When 「useMediation」 is true, This is recommended.
+ (void)startWithAsyncCompletionHandler:(BUCompletionHandler)completionHandler;

@end


@interface BUAdSDKManager (MopubAdaptor) <BUMopubAdMarkUpDelegate>

@end

@interface BUAdSDKManager (BUAdNR)
+ (NSString *)bunr_dictionaryWithSlot:(BUAdSlot *)slot isDynamicRender:(BOOL)isDynamicRender;
@end


@interface BUAdSDKManager (InterfaceReadyReplacement)

/**
 @param  secretKey the unique identifier of the App, more safely
 */
+ (void)setSecretKey:(NSString *)secretKey;

/* Set the age group of the user, the interface only works only works in CN environment.
 * @params ageGroup: default BUAdSDKAgeGroupAdult
 */
+ (void)setAgeGroup:(BUAdSDKAgeGroup)ageGroup;

/// set additional user information.
+ (void)setUserExtData:(NSString *)data;

/// Solve the problem when your WKWebview post message empty,default is BUOfflineTypeWebview
+ (void)setOfflineType:(BUOfflineType)type;

/// Custom set the AB vid of the user. Array element type is NSNumber
+ (void)setABVidArray:(NSArray<NSNumber *> *)abvids;

/// Custom set the tob ab sdk version of the user.
+ (void)setABSDKVersion:(NSString *)abSDKVersion;


/// Custom set idfa value
+ (void)setCustomIDFA:(NSString *)idfa;



+ (void)setThemeStatus:(BUAdSDKThemeStatus)themeStatus;

/// get appID
+ (NSString *)appID;

/**
 Whether to allow SDK to modify the category and options of AVAudioSession when playing audio, default is NO.
 The category set by the SDK is AVAudioSessionCategoryAmbient, and the options are AVAudioSessionCategoryOptionDuckOthers
 */
+ (void)allowModifyAudioSessionSetting:(BOOL)isAllow;


+ (BUAdSDKThemeStatus)themeStatus;

@end

NS_ASSUME_NONNULL_END
