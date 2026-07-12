//
//  ATAdManager+Banner.h
//  AnyThinkBanner
//
//  Created by Martin Lau on 18/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <AnyThinkSDK/AnyThinkSDK.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NativeMixBannerViewBlock)(ATNativeBannerView *nativeBannerView);

//Supported by Nend banner only
extern NSString *const kATBannerLoadingExtraParameters;
extern NSString *const kATAdLoadingExtraBannerAdSizeKey;//defaults to 320 * 50
extern NSString *const kATAdLoadingExtraBannerSizeAdjustKey;//Currently supported by Nend

extern NSString *const kATAdLoadingExtraAdmobBannerSizeKey;//Admob Adaptive width
extern NSString *const kATAdLoadingExtraAdmobAdSizeFlagsKey;//Admob AdSize flags

@class ATBannerView;

@interface ATAdManager (Banner)

/// check whether the splash ad is ready
/// v5.7.06+
- (BOOL)bannerAdReadyForPlacementID:(NSString *)placementID;

- (BOOL)bannerAdReadyForPlacementID:(NSString *)placementID showViewController:(UIViewController *)showViewController;

/// check whether the splash ad is ready
/// @param send - whether send tk
- (BOOL)bannerAdReadyForPlacementID:(NSString *)placementID
                             sendTK:(BOOL)send;

/// Get the banner ad view
/// note: nil will be returned if banner ad is not ready.
- (nullable ATBannerView *)retrieveBannerViewForPlacementID:(NSString *)placementID;

/// Get the banner ad view
/// @param placementID - TopOn's ad placement id
/// @param extra -  Local configuration parameter
/// note: nil will be returned if banner ad is not ready.
- (nullable ATBannerView *)retrieveBannerViewForPlacementID:(NSString *)placementID
                                                      extra:(NSDictionary *)extra DEPRECATED_ATTRIBUTE;

/// Get the banner ad view
/// @param placementID - TopOn's ad placement id
/// @param scene - Scene id
/// note: nil will be returned if banner ad is not ready.
- (nullable ATBannerView *)retrieveBannerViewForPlacementID:(NSString *)placementID
                                                      scene:(NSString *)scene;

- (nullable ATBannerView *)retrieveBannerViewForPlacementID:(NSString *)placementID
                                                     config:(ATShowConfig *)config;

/// Get the banner ad view
/// @param placementID - TopOn's ad placement id
/// @param scene - Scene id
/// note: nil will be returned if banner ad is not ready.
- (nullable ATBannerView *)retrieveBannerViewForPlacementID:(NSString *)placementID
                                                      scene:(NSString *)scene
                                   nativeMixBannerViewBlock:(nullable NativeMixBannerViewBlock)nativeMixBannerViewBlock;

- (nullable ATBannerView *)retrieveBannerViewForPlacementID:(NSString *)placementID
                                                     config:(ATShowConfig *)config
                                   nativeMixBannerViewBlock:(nullable NativeMixBannerViewBlock)nativeMixBannerViewBlock;

/// Get the status object of the current ad slot ATCheckLoadModel
- (ATCheckLoadModel *)checkBannerLoadStatusForPlacementID:(NSString *)placementID;

/// Query all cached information of the ad slot
- (nullable NSArray<NSDictionary *> *)getBannerValidAdsForPlacementID:(NSString *)placementID;

/// Enter the current ad slot cache status statistics in the business scenario.
/// @param scene - ad Scenario
/// v6.2.51+
- (void)entryBannerScenarioWithPlacementID:(NSString *)placementID scene:(NSString *)scene;

@end

NS_ASSUME_NONNULL_END
