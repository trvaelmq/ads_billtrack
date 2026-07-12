//
//  ATNativeADDelegate.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 08/05/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef ATNativeADDelegate_h
#define ATNativeADDelegate_h
#import <AnyThinkSDK/AnyThinkSDK.h>
@class ATNativeADView;

NS_ASSUME_NONNULL_BEGIN

@protocol ATNativeADDelegate<ATAdLoadingDelegate>


/// Native ads displayed successfully
- (void)didShowNativeAdInAdView:(ATNativeADView *)adView
                    placementID:(NSString *)placementID
                          extra:(NSDictionary *)extra;

/// Native ad click
- (void)didClickNativeAdInAdView:(ATNativeADView *)adView
                     placementID:(NSString *)placementID
                           extra:(NSDictionary *)extra;

@optional

/// Native video ad starts playing
- (void)didStartPlayingVideoInAdView:(ATNativeADView *)adView
                         placementID:(NSString *)placementID
                               extra:(NSDictionary *)extra;

/// Native video ad ends playing
- (void)didEndPlayingVideoInAdView:(ATNativeADView *)adView
                       placementID:(NSString *)placementID
                             extra:(NSDictionary *)extra;

/// Native ad close button cliecked
- (void)didTapCloseButtonInAdView:(ATNativeADView *)adView
                      placementID:(NSString *)placementID
                            extra:(NSDictionary *)extra;

/// Native ads click to close the details page
/// v5.7.47+
- (void)didCloseDetailInAdView:(ATNativeADView *)adView
                   placementID:(NSString *)placementID
                         extra:(NSDictionary *)extra;

/// Whether the click jump of Native ads is in the form of Deeplink
/// currently only returns for TopOn Adx ads
- (void)didDeepLinkOrJumpInAdView:(ATNativeADView *)adView
                      placementID:(NSString *)placementID
                            extra:(NSDictionary *)extra
                           result:(BOOL)success;

/// Native enters full screen video ads, only for Nend
- (void)didEnterFullScreenVideoInAdView:(ATNativeADView *)adView
                            placementID:(NSString *)placementID
                                  extra:(NSDictionary *)extra;

/// Native exit full screen video ad, only for Nend
- (void)didExitFullScreenVideoInAdView:(ATNativeADView *)adView
                           placementID:(NSString *)placementID
                                 extra:(NSDictionary *)extra;

@end
#endif /* ATNativeADDelegate_h */

NS_ASSUME_NONNULL_END
