//
//  BUNativeExpressAdView.h
//  BUAdSDK
//
//  Created by bytedance on 2019/1/20.
//  Copyright © 2019年 bytedance. All rights reserved.
//

#import "BUInterfaceBaseView.h"
#import "BUAdClientBiddingProtocol.h"
#import "BUDictionary.h"

NS_ASSUME_NONNULL_BEGIN

@class BUGestureConfiguration;
 __attribute__((objc_subclassing_restricted))
@interface BUNativeExpressAdView : BUInterfaceBaseView<BUAdClientBiddingProtocol>
/**
 * Whether render is ready
 */
@property (nonatomic, assign, readonly) BOOL isReady;

/// media configuration parameters.
@property (nonatomic, copy, readonly, nullable) BUDictionary *mediaExt;

/// video duration.
@property (nonatomic,assign, readonly) NSInteger videoDuration;

/// Get the already played time.
@property (nonatomic,assign, readonly) CGFloat currentPlayedTime;

/*
 required.
 Root view controller for handling ad actions.
 */
@property (nonatomic, weak, nullable) UIViewController *rootViewController;

/**
 required
 */
- (void)render;
/**
 Ad slot material id
 */
- (NSString *)getAdCreativeToken;

/*
 Register a set of rects in ad view that can respond to click events
 NSValue:[NSValue valueWithCGRect:rect]
 */
- (void)registerClickableRects:(NSArray<__kindof NSValue *> *_Nullable)clickableRects
                 configuration:(BUGestureConfiguration *)configuration;
/*
 Unregister rects from the ad view
*/
- (void)unregisterRects;

@end

typedef NS_ENUM(NSInteger, BUGestureRecognizerType) {
    BUGestureRecognizerType_Slide = 1 // 滑动手势
};

typedef NS_ENUM(NSInteger, BUSlideGestureDirection) {
    BUSlideGesturesDirection_Left = 1 << 1, // 左滑
    BUSlideGesturesDirection_Right = 1 << 2, // 右滑
    BUSlideGesturesDirection_Up = 1 << 3, // 上滑
    BUSlideGesturesDirection_Down = 1 << 4, // 下滑
};


@interface BUGestureConfiguration : NSObject

@property (nonatomic, assign) BUGestureRecognizerType gestureRecognizerType; // 手势类型
@property (nonatomic, assign) BUSlideGestureDirection slideDirection; // 滑动手势触发方向
@property (nonatomic, assign) CGFloat slideThreshold; // 滑动手势触发阈值

@end

NS_ASSUME_NONNULL_END
