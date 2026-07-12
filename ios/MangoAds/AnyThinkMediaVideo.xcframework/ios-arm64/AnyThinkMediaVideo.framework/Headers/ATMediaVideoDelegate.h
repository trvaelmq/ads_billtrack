//
//  ATMediaVideoDelegate.h
//  AnyThinkMediaVideo
//
//  Created by li zhixuan on 2024/3/5.
//  Copyright © 2024 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/AnyThinkSDK.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ATMediaVideoAdapterProtocol <NSObject>

- (void)startWithAd:(id<ATAd>)ad;
- (void)pauseWithAd:(id<ATAd>)ad;
- (void)resumeWithAd:(id<ATAd>)ad;
- (void)destoryWithAd:(id<ATAd>)ad;
- (void)contentCompleteWithAd:(id<ATAd>)ad;

@end

@protocol ATMediaVideoDelegate<ATAdLoadingDelegate>

@optional
/// ad play starts
- (void)mediaVideoDidStartPlayingForPlacementID:(NSString *)placementID
                                             extra:(NSDictionary *)extra;

/// ad play ends
- (void)mediaVideoDidEndPlayingForPlacementID:(NSString *)placementID
                                           extra:(NSDictionary *)extra;

/// ad play fail
- (void)mediaVideoDidFailToPlayForPlacementID:(NSString *)placementID
                                           error:(NSError *)error
                                           extra:(NSDictionary *)extra;

/// ad clicks
- (void)mediaVideoDidClickForPlacementID:(NSString *)placementID
                                      extra:(NSDictionary *)extra;

/// ad pause
- (void)mediaVideoAdPauseForPlacementID:(NSString *)placementID
                                  extra:(NSDictionary *)extra;

/// ad resume
- (void)mediaVideoAdResumeForPlacementID:(NSString *)placementID
                                  extra:(NSDictionary *)extra;

/// ad skiped
- (void)mediaVideoAdSkipedForPlacementID:(NSString *)placementID
                                  extra:(NSDictionary *)extra;

/// IMA callback
- (void)mediaVideoAdForPlacementID:(NSString *)placementID
                             extra:(NSDictionary *)extra event:(id)event;

/// video area tap
- (void)mediaVideoAdTappedForPlacementID:(NSString *)placementID
                                  extra:(NSDictionary *)extra;

/// video progress
- (void)mediaVideoAdDidProgressForPlacementID:(NSString *)placementID
                                        extra:(NSDictionary *)extra mediaTime:(NSTimeInterval)mediaTime totalTime:(NSTimeInterval)totalTime;

#pragma mark - IMA Event
/// video start buffering
- (void)mediaVideoAdDidStartBufferingForPlacementID:(NSString *)placementID
                                              extra:(NSDictionary *)extra;

/// video did Buffer
- (void)mediaVideoAdDidBufferToMediaTimeForPlacementID:(NSString *)placementID
                                                 extra:(NSDictionary *)extra mediaTime:(NSTimeInterval)mediaTime;

/// video ready
- (void)mediaVideoAdPlaybackReadyForPlacementID:(NSString *)placementID
                                          extra:(NSDictionary *)extra;

- (void)mediaVideoAdRequestContentPauseForPlacementID:(NSString *)placementID
                                                extra:(NSDictionary *)extra;

- (void)mediaVideoAdRequestContentResumeForPlacementID:(NSString *)placementID
                                                 extra:(NSDictionary *)extra;

/// return IMA kIMAAdEvent_AD_BREAK_READY event
- (void)mediaVideoAdBreakReadyForPlacementID:(NSString *)placementID
                                       extra:(NSDictionary *)extra;


@end

NS_ASSUME_NONNULL_END
