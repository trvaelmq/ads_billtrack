//
//  ATSplashCustomEvent.h
//  AnyThinkSplash
//
//  Created by Martin Lau on 2018/12/20.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AnyThinkSplash/ATSplashDelegate.h>

NS_ASSUME_NONNULL_BEGIN



@class ATSplash;
@protocol ATSplashDelegate;

@interface ATSplashCustomEvent : ATAdCustomEvent

/// callback to developer when ad is closed
- (void)trackSplashAdClosed:(nullable NSDictionary *)extra;

- (void)trackSplashAdWillClosed:(NSDictionary *)extra;

/// callback to developer when ad is loaded
/// @param splashAd - splash ad object
/// v5.7.05 +
- (void)trackSplashAdLoaded:(id _Nullable)splashAd;

/// callback to developer when ad is loaded
/// @param splashAd - splash ad object
/// @param adExtra - extra data
/// v5.7.06 +
- (void)trackSplashAdLoaded:(id _Nullable)splashAd adExtra:(NSDictionary * _Nullable)adExtra;

/// 广告渲染成功(素材下载成功)
- (void)trackSplashAdRenderSuccess:(id)splashAd adExtra:(NSDictionary *_Nullable)adExtra;

/// 广告加载成功
- (void)trackSplashAdDataLoadSuccess:(id)splashAd adExtra:(NSDictionary *_Nullable)adExtra;

/// callback to developer when ad is showed
- (void)trackSplashAdShow;

- (void)trackSplashAdShowFailed:(NSError *)error;

- (void)trackSplashAdShowFailed:(NSError *)error extra:(NSDictionary *)extraDic;

/// callback to developer when ad is clicked
- (void)trackSplashAdClick;

/// callback to developer when ad is clicked
- (void)trackSplashAdClickWithClickType:(ATOfferClickAdType)clickType;

/// callback to developer when ad is load failed
/// @param error - error message
- (void)trackSplashAdLoadFailed:(NSError*)error;

/// callback to developer when ad ZoomOutView is clicked
- (void)trackSplashAdZoomOutViewClick;

/// callback to developer when ad ZoomOutView is closeed
- (void)trackSplashAdZoomOutViewClosed;

///  Whether the click jump of ad is in the form of Deeplink
/// @param success - success status
- (void)trackSplashAdDeeplinkOrJumpResult:(BOOL)success;

- (void)trackSplashAdDetailWillShow;

- (void)trackSplashAdDetailClosed;

- (void)trackSplashAdvideoPlayerStatusChanged:(ATVideoPlayerStatus)videoPlayerStatus;

- (void)trackSplashVideoPlayerError:(NSError *__nullable)error;


/// callback When the custom skip button and countdown related parameters are passed in
/// @param countdown - current countdown time
- (void)trackSplashAdCountdownTime:(NSInteger)countdown;

- (void)startCountdown:(NSDictionary *)localInfo countdownBlock:(void(^)(NSInteger time))block;

- (BOOL)isPauseTimer;

- (instancetype)initWithInfo:(NSDictionary *)serverInfo localInfo:(NSDictionary *)localInfo;

@property (nonatomic, weak, nullable) ATSplash *splash;
@property (nonatomic, strong, nullable) UIView *containerBgView;
@property (nonatomic, strong) id _Nullable protectLifeCycleObject;
@property (nonatomic, readonly) NSString *unitID;
@property (nonatomic, assign) NSInteger priorityIndex;
@property (nonatomic, weak) id<ATSplashDelegate> delegate;

@end
NS_ASSUME_NONNULL_END
