//
//  ATAdManager+ATMediaVideo.h
//  AnyThinkMediaVideo
//
//  Created by li zhixuan on 2024/3/5.
//  Copyright © 2024 AnyThink. All rights reserved.
//

#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AnyThinkMediaVideo/ATMediaVideoDelegate.h>
#import <AnyThinkMediaVideo/ATMediaVideoOffer.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kATMediaVideoDelegateExtraNetworkIDKey;
extern NSString *const kATMediaVideoDelegateExtraPrice;

extern NSString *const kATAdMediaVideoExtraKeyInternalBrowser;
extern NSString *const kATAdMediaVideoExtraKeyInternalBrowserViewController;
extern NSString *const kATAdMediaVideoExtraKeyHideCountDown;
extern NSString *const kATAdMediaVideoExtraKeyLoadVideoTimeout;
extern NSString *const kATAdMediaVideoExtraKeyAutoPlayAdBreaks;
extern NSString *const kATAdMediaVideoExtraKeyDisableNowPlayingInfo;
extern NSString *const kATAdMediaVideoExtraKeyEnablePreloading;

extern NSString *const kATAdMediaVideoExtraKeyPlayhead;
extern NSString *const kATAdMediaVideoExtraKeyContainerView;
extern NSString *const kATAdMediaVideoExtraKeyViewController;

extern NSString *const kATAdMediaVideoExtraKeyControlDataParam;
extern NSString *const kATAdMediaVideoExtraKeySystemObejct;


@interface ATAdManager (ATMediaVideo)

- (nullable ATMediaVideoOffer *)mediaVideoObjectWithPlacementID:(NSString *)placementID showConfig:(ATShowConfig * _Nullable)showConfig delegate:(id<ATMediaVideoDelegate>)delegate;

- (void)loadADWithPlacementID:(NSString *)placementID
                        extra:(NSDictionary *)extra
             controlDataParam:(NSDictionary * _Nullable)param
                      tkExtra:(NSDictionary * _Nullable)tkExtra
                     delegate:(id<ATMediaVideoDelegate>)delegate
                adxFloorPrice:(ATADXFloorPrice * _Nullable)adxFloorPrice
      mediaVideoContainerView:(UIView *)containerView
               viewController:(UIViewController *)viewController;

- (void)loadADWithPlacementID:(NSString *)placementID
                        extra:(NSDictionary *)extra
             controlDataParam:(NSDictionary * _Nullable)param
                     delegate:(id<ATMediaVideoDelegate>)delegate
      mediaVideoContainerView:(UIView *)containerView
               viewController:(UIViewController *)viewController;

- (void)loadADWithPlacementID:(NSString *)placementID
                        extra:(NSDictionary *)extra
                     delegate:(id<ATMediaVideoDelegate>)delegate
      mediaVideoContainerView:(UIView *)containerView
               viewController:(UIViewController *)viewController;

/// Query all cached information of the ad slot
- (NSArray<NSDictionary *> *)getMediaVideoValidAdsForPlacementID:(NSString *)placementID;

/// Enter the current ad slot cache status statistics in the business scenario.
/// @param scene - ad Scenario
/// v5.7.91+
- (void)entryMediaVideoScenarioWithPlacementID:(NSString *)placementID
                                            scene:(NSString *)scene;

@end

NS_ASSUME_NONNULL_END
