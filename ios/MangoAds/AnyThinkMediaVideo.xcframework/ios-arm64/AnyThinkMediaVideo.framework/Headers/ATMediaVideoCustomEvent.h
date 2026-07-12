//
//  ATMediaVideoCustomEvent.h
//  AnyThinkMediaVideo
//
//  Created by li zhixuan on 2024/3/7.
//  Copyright © 2024 AnyThink. All rights reserved.
//

#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AnyThinkMediaVideo/AnyThinkMediaVideo.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ATMediaVideoCustomEventVideoProgress) {
    ATMediaVideoCustomEventVideoProgress25Percent,
    ATMediaVideoCustomEventVideoProgress50Percent,
    ATMediaVideoCustomEventVideoProgress75Percent,
};

@interface ATMediaVideoCustomEvent : ATAdCustomEvent

- (NSDictionary *)delegateExtra;

/// callback to developer when ad is loaded
/// @param adObject - ad object
/// @param adExtra - extra data
- (void)trackMediaVideoAdLoaded:(id)adObject adExtra:(NSDictionary *_Nullable)adExtra;

- (void)trackMediaVideoAdLoadFailed:(NSError *)error;

- (void)trackMediaVideoAdClick;

- (void)trackMediaVideoAdShow;

- (void)trackMediaVideoAdVideoStart;
- (void)trackMediaVideoAdVideoProgress:(ATMediaVideoCustomEventVideoProgress)progress;
- (void)trackMediaVideoAdVideoEnd;

- (void)trackMediaVideoShowAPICallTK;


@end

NS_ASSUME_NONNULL_END
