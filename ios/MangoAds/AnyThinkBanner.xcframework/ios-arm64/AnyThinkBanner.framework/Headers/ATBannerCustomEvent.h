//
//  ATBannerCustomEvent.h
//  AnyThinkBanner
//
//  Created by Martin Lau on 18/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AnyThinkBanner/ATBannerDelegate.h>

#import <AnyThinkBanner/ATBanner.h>
#import <AnyThinkBanner/ATBannerView.h>



NS_ASSUME_NONNULL_BEGIN
@interface ATBannerCustomEvent : ATAdCustomEvent

/// callback to developer when ad is clicked
- (void)trackBannerAdClick;

/// callback to developer when ad is Impression
- (void)trackBannerAdImpression;

/// callback to developer when ad is closed
- (void)trackBannerAdClosed;

/// callback to developer when ad Detail is closed
- (void)trackBannerAdDetailClosed;

/// callback to developer when ad is loaded
/// @param bannerView - bannerView object
/// @param adExtra - extra data
- (void)trackBannerAdLoaded:(id)bannerView adExtra:(NSDictionary * _Nullable)adExtra;

/// 广告渲染成功(素材下载成功)
/// @param bannerView - bannerView object
/// @param adExtra - extra data
- (void)trackBannerAdRenderSuccess:(id)bannerView adExtra:(NSDictionary *_Nullable)adExtra;

/// 广告加载成功
/// @param bannerView - bannerView object
/// @param adExtra - extra data
- (void)trackBannerAdDataLoadSuccess:(id)bannerView adExtra:(NSDictionary *_Nullable)adExtra;

/// callback to developer when ad is load failed
/// @param error - error message
- (void)trackBannerAdLoadFailed:(NSError *)error;

///  Whether the click jump of ad is in the form of Deeplink
/// @param success - success status
- (void)trackBannerAdDeeplinkOrJumpResult:(BOOL)success;

/// Some ad SDKs do not call back after ads were displayed. Override it and return 'YES', a impression tracking will be sent. Same for the native ads (ATNativeADCustomEvent).
- (BOOL)sendImpressionTrackingIfNeed;
- (void)bannerViewToggle;
- (void)invalidateBidInfo;
- (void)destroyBanner;
- (void)removedFromWindow;
- (void)cleanup;
// 自动点击
- (BOOL)isTapClickdSwitch;
- (CGFloat)popupReminderDuration;
- (CGFloat)autoClickdDuration;
- (id)getCustomOfferModel;
- (id)getCustomOfferSetting;
- (ATBannerClickType)getBannerTriggerClickType;

- (instancetype)initWithInfo:(NSDictionary *)serverInfo localInfo:(NSDictionary *)localInfo;

@property (nonatomic ,weak) id<ATBannerDelegate> delegate;
@property (nonatomic, weak) ATBanner *banner;
@property (nonatomic, weak) ATBannerView *bannerView;
@property (nonatomic, readonly) NSString *unitID;
@property (nonatomic, readonly) CGSize size;
@property (nonatomic, strong) NSValue *admobAdSizeValue;//For admob
@property (nonatomic, assign) NSInteger admobAdSizeFlags;//For admob
@property (nonatomic) NSDictionary *loadingParameters;//For nend
@property (nonatomic) BOOL adjustAdSize;//For nend
@property (nonatomic, assign) NSInteger priorityIndex;
@property (nonatomic, assign) ATOfferClickAdType clickType;
@property (nonatomic, strong) id _Nullable protectLifeCycleObject;
@property (nonatomic, weak) UIViewController *loadInputShowViewController;
+ (UIViewController *)rootViewControllerWithPlacementID:(NSString *)placementID requestID:(NSString *)requestID;
@end

NS_ASSUME_NONNULL_END
