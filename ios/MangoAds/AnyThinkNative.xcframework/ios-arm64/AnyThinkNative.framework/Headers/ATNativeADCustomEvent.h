//
//  ATNativeADCustomEvent.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 25/04/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/AnyThinkSDK.h>

#import <AnyThinkNative/ATNativeADView.h>
#import <AnyThinkNative/ATNativeADDelegate.h>


@class ATNativeADCache;

NS_ASSUME_NONNULL_BEGIN

@interface ATNativeADCustomEvent : ATAdCustomEvent

/// callback to developer when ad is loaded
/// @param assets - native ad assets
- (void)trackNativeAdLoaded:(NSArray *)assets;

/// callback to developer when ad is load failed
/// @param error - error message
- (void)trackNativeAdLoadFailed:(NSError *)error;

/// callback to developer when ad is showed
/// @param refresh - whether the show is trigered by a ad refresh
- (void)trackNativeAdShow:(BOOL)refresh;

- (void)trackNativeAdImpression;

/// callback to developer when ad is clicked
- (void)trackNativeAdClick;

- (void)trackNativeAdVideoStart;

- (void)trackNativeAdVideoEnd;

/// callback to developer when ad is closed
- (void)trackNativeAdClosed;

- (void)trackNativeAdDeeplinkOrJumpResult:(BOOL)success;

//v5.7.47
- (void)trackNativeAdCloseDetail;

/// only for adx、onlineApi、myoffer、directOffer
- (NSTimeInterval)getNativeAdViewMonitoringShowTime;

- (void)didAttachMediaView;
- (void)invalidateUsedAdInfo;
- (void)willDetachOffer:(ATNativeADCache *)offer fromAdView:(ATNativeADView *)adView;
/// If it returns YES, then when sending the embedding points of "show", the embedding points of "impression" will be sent together. Otherwise, it will not be sent. Same for the banner ads (ATBannerCustomEvent.h).
- (BOOL)sendImpressionTrackingIfNeed;
- (BOOL)isTapClickdSwitch;
- (CGFloat)popupReminderDuration;
- (CGFloat)autoClickdDuration;
- (id)getCustomOfferModel;
- (id)getCustomOfferSetting;
- (BOOL)isAllowMraidWebPreLoad;
- (BOOL)isMraidAd;
- (NSString *)getNativeAdViewOfferIdentifier;
- (void)sendMraidAdRenderSuccessEvent;
- (ATNativeADSourceType)sourceType;

- (instancetype)initWithInfo:(NSDictionary *)serverInfo localInfo:(NSDictionary *)localInfo;

@property (atomic, copy) void(^requestCompletionBlock)( NSArray<NSDictionary *> * _Nullable assets,  NSError * _Nullable error);
@property (nonatomic, readonly) NSMutableArray<NSDictionary *> *assets;
@property (nonatomic, weak) ATNativeADView *adView;
@property (nonatomic) NSInteger requestNumber;
/**
 * Failed or successful, a request's considered finished.
 */
@property (nonatomic) NSInteger numberOfFinishedRequests;

@end

@interface ATNativeADView(Event)
- (void)notifyNativeAdClick;
- (void)notifyVideoStart;
- (void)notifyVideoEnd;
- (void)notifyVideoEnterFullScreen;
- (void)notifyVideoExitFullScreen;
- (void)notifyCloseButtonTapped;
- (void)notifyDeeplinkOrJumpResult:(BOOL)success;
- (void)notifyAdDetailClosed;
- (void)notifyNativeAdShow;
- (void)notifyNativeAdDidRevenue;
@end


NS_ASSUME_NONNULL_END
