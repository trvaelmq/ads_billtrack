//
//  ATSplashDelegate.h
//  AnyThinkSplash
//
//  Created by Martin Lau on 2018/12/20.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef ATSplashDelegate_h
#define ATSplashDelegate_h

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

/// Video Player Status
typedef NS_ENUM(NSUInteger, ATVideoPlayerStatus) {
    ATVideoPlayerStatusDefault,    // 默认状态
    ATVideoPlayerStatusWillStart,  // 调用play方法
    ATVideoPlayerStatusBuffered,   // 缓存完成
    ATVideoPlayerStatusStarted,    // 播放中
    ATVideoPlayerStatusFinished,   // 播放完成
    ATVideoPlayerStatusPaused,     // 播放暂停
    ATVideoPlayerStatusResumed,    // 播放复播
    ATVideoPlayerStatusError,      // 播放异常
};
@protocol ATAdLoadingDelegate;

@protocol ATSplashDelegate<ATAdLoadingDelegate>

/// Splash ad displayed successfully
- (void)splashDidShowForPlacementID:(NSString *)placementID
                              extra:(NSDictionary *)extra;

/// Splash ad click
- (void)splashDidClickForPlacementID:(NSString *)placementID
                               extra:(NSDictionary *)extra;

/// Splash ad closed
- (void)splashDidCloseForPlacementID:(NSString *)placementID
                               extra:(NSDictionary *)extra;

@optional

/// Splash ad will closed
- (void)splashWillCloseForPlacementID:(NSString *)placementID
                               extra:(NSDictionary *)extra;

/// Callback when the splash ad is loaded successfully
/// @param isTimeout whether timeout
/// v 5.7.73
- (void)didFinishLoadingSplashADWithPlacementID:(NSString *)placementID
                                      isTimeout:(BOOL)isTimeout;

/// Splash ad loading timeout callback
/// v 5.7.73
- (void)didTimeoutLoadingSplashADWithPlacementID:(NSString *)placementID;

/// Splash ad failed to display
/// currently supports Pangle, Guangdiantong and Baidu
- (void)splashDidShowFailedForPlacementID:(NSString *)placementID
                                    error:(NSError *)error
                                    extra:(NSDictionary *)extra;

///  Whether the click jump of Splash ad is in the form of Deeplink
/// note: only suport TopOn Adx ad
- (void)splashDeepLinkOrJumpForPlacementID:(NSString *)placementID
                                     extra:(NSDictionary *)extra
                                    result:(BOOL)success;

///  Splash ad closes details page
- (void)splashDetailDidClosedForPlacementID:(NSString *)placementID
                                      extra:(NSDictionary *)extra;

///  Splash ad closes details show
- (void)splashDetailWillShowForPlacementID:(NSString *)placementID
                                      extra:(NSDictionary *)extra;

/// Called when splash zoomout view did click
/// note: only suport Pangle splash zoomout view and the Tencent splash V+ ad
- (void)splashZoomOutViewDidClickForPlacementID:(NSString *)placementID
                                          extra:(NSDictionary *)extra;

/// Called when splash zoomout view did close
/// note: only suport Pangle splash zoomout view and the Tencent splash V+ ad
- (void)splashZoomOutViewDidCloseForPlacementID:(NSString *)placementID
                                          extra:(NSDictionary *)extra;

/// This callback is triggered when the skip button is customized.
/// note: only suport TopOn MyOffer, TopOn Adx and TopOn OnlineApi
/// 5.7.61+
- (void)splashCountdownTime:(NSInteger)countdown
             forPlacementID:(NSString *)placementID
                      extra:(NSDictionary *)extra;

/// This callback is triggered when video player changed
- (void)splashVideoPlayerForPlacementID:(NSString *)placementID
                                  extra:(NSDictionary *)extra
                          statusChanged:(ATVideoPlayerStatus)videoPlayerStatus;

/// This callback is triggered when video player error
- (void)splashVideoPlayerForPlacementID:(NSString *)placementID
                                  extra:(NSDictionary *)extra
                            playerError:(NSError *__nullable)error;



@end
#endif /* ATSplashDelegate_h */

NS_ASSUME_NONNULL_END
