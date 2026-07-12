//
//  ATAdManager+Splash.h
//  AnyThinkSplash
//
//  Created by Martin Lau on 2018/12/20.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AnyThinkSDK/ATSelfRenderingMixSplashView.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NativeMixSplashViewBlock)(ATSelfRenderingMixSplashView *selfRenderingMixSplashView);


extern NSString *const kATSplashExtraCountdownKey;
extern NSString *const kATSplashExtraTolerateTimeoutKey; //Timeout duration
extern NSString *const kATSplashExtraHideSkipButtonFlagKey;
extern NSString *const kATSplashExtraBackgroundImageKey;
extern NSString *const kATSplashExtraBackgroundColorKey;
extern NSString *const kATSplashExtraSkipButtonCenterKey;
extern NSString *const kATSplashExtraCustomSkipButtonKey; // only supported UIButton
extern NSString *const kATSplashExtraCanClickFlagKey;
extern NSString *const kATSplashExtraShowDirectionKey;//Supported by KS Splash, defaults to Vertical, 1 to Horizontal
// 5.7.61+
extern NSString *const kATSplashExtraCountdownIntervalKey;

extern NSString *const kATSplashExtraPlacementIDKey;
extern NSString *const kATSplashExtraNetworkFirmID; //Ad platform FirmID
extern NSString *const kATSplashExtraAdSourceIDKey; //Ad source ID
 
@protocol ATSplashDelegate;

@interface ATAdManager (Splash)

/// Called when load ad
/// @param placementID - the placementId string of the Ad that display.
/// @param extra - local configuration parameter
/// @param delegate - delegate object
/// @param containerView - Bottom view
- (void)loadADWithPlacementID:(NSString *)placementID
                        extra:(NSDictionary *)extra
                     delegate:(id<ATSplashDelegate>)delegate
                containerView:(UIView * _Nullable)containerView;

- (void)loadADWithPlacementID:(NSString *)placementID
                        extra:(NSDictionary *)extra
                      tkExtra:(NSDictionary * _Nullable)tkExtra
                adxFloorPrice:(ATADXFloorPrice * _Nullable)adxFloorPrice
                     delegate:(id<ATSplashDelegate>)delegate
                containerView:(UIView * _Nullable)containerView;

/// Called when Display Splash ads
/// @param window window where ads are displayed
- (void)showSplashWithPlacementID:(NSString *)placementID 
                            scene:(NSString *)scene
                           window:(UIWindow *)window
                         delegate:(id<ATSplashDelegate>)delegate DEPRECATED_MSG_ATTRIBUTE("use showSplashWithPlacementID:config:window:inViewController:extra:delegate: instead");
/// v5.7.61+
- (void)showSplashWithPlacementID:(NSString *)placementID 
                            scene:(NSString *)scene
                           window:(UIWindow *)window
                            extra:(NSDictionary *_Nullable)extra
                         delegate:(id<ATSplashDelegate>)delegate DEPRECATED_MSG_ATTRIBUTE("use showSplashWithPlacementID:config:window:inViewController:extra:delegate: instead");

- (void)showSplashWithPlacementID:(NSString *)placementID
                            scene:(NSString *)scene
                           window:(UIWindow *)window
                 inViewController:(UIViewController *)viewController
                         delegate:(id<ATSplashDelegate>)delegate DEPRECATED_MSG_ATTRIBUTE("use showSplashWithPlacementID:config:window:inViewController:extra:delegate: instead");

/// v6.2.96+
/// - Parameters:
///   - placementID: placementID
///   - scene: scene ID
///   - window: show container window,If it is nil, it defaults to the key window.
///   - viewController: show container viewController,If it is nil, it defaults to the top view controller.
///   - extra: extra parameter
///   - delegate: event delegate
- (void)showSplashWithPlacementID:(NSString *)placementID 
                            scene:(NSString *)scene
                           window:(UIWindow *)window
                 inViewController:(UIViewController *)viewController
                            extra:(NSDictionary *_Nullable)extra
                         delegate:(id<ATSplashDelegate>)delegate DEPRECATED_MSG_ATTRIBUTE("use showSplashWithPlacementID:config:window:inViewController:extra:delegate: instead");

- (void)showSplashWithPlacementID:(NSString *)placementID
                           config:(ATShowConfig *)config
                           window:(UIWindow *)window
                 inViewController:(UIViewController *)viewController
                            extra:(NSDictionary *_Nullable)extra
                         delegate:(id<ATSplashDelegate>)delegate;

- (void)showSplashWithPlacementID:(NSString *)placementID
                           config:(ATShowConfig *)config
                           window:(UIWindow *)window
                 inViewController:(UIViewController *)viewController
                            extra:(NSDictionary *_Nullable)extra
                         delegate:(id<ATSplashDelegate>)delegate
               nativeMixViewBlock:(nullable NativeMixSplashViewBlock)nativeMixViewBlock;

/// check whether the splash ad is ready
/// v5.7.06+
- (BOOL)splashReadyForPlacementID:(NSString *)placementID;

/// check whether the splash ad is ready
/// @param send - whether send tk
- (BOOL)splashReadyForPlacementID:(NSString *)placementID
                           sendTK:(BOOL)send;

- (BOOL)splashReadyWithoutLogForPlacementID:(NSString *)placementID sendTK:(BOOL)send;

/// Get the status object of the current ad slot ATCheckLoadModel
- (nullable ATCheckLoadModel *)checkSplashLoadStatusForPlacementID:(NSString *)placementID;

/// Query all cached information of the ad slot
- (nullable NSArray<NSDictionary *> *)getSplashValidAdsForPlacementID:(NSString *)placementID;

/// Enter the current ad slot cache status statistics in the business scenario.
/// @param scene - ad Scenario
/// v5.7.91+
- (void)entrySplashScenarioWithPlacementID:(NSString *)placementID
                                     scene:(NSString *)scene;

@end

NS_ASSUME_NONNULL_END
