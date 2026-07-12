//
//  ATInterstitialCustomEvent+ATRotaion.h
//  AnyThinkSDK
//
//  Created by Captain on 2024/11/5.
//  Copyright © 2024 AnyThink. All rights reserved.
//

#import <AnyThinkInterstitial/AnyThinkInterstitial.h>

NS_ASSUME_NONNULL_BEGIN
@class ATTimer, ATAdCacheInfo;
@interface ATInterstitialCustomEvent (ATRotaion)
@property (nonatomic, strong) ATTimer *rotationActionTimer;
@property (nonatomic, strong) ATTimer *rotationCheckNextTimer;
@property (nonatomic, strong) ATTimer *rotationCheckCloseTimer;// 点击时如果需要点击后关闭 则开启此定时器
@property (nonatomic, strong) ATAdCacheInfo *nextCache;

/// 开启轮播业务检测
- (void)checkStartRotation;

/// 开启点击后自动关闭的检测定时器
- (void)checkCloseAfterClick;

/// 停止轮播业务并强行关闭当前展示广告
- (void)checkAutoClose;

/// 停止轮播计时器 即终止轮播
- (void)invalidateRotaionTimer;

/// 停止点击后自动检测关闭的定时器
- (void)invalidateCheckCloseTimer;

/// 销毁所有定时器并结束轮播, 但是不走close_after_click的逻辑
- (void)cleaerRotation;
@end

NS_ASSUME_NONNULL_END
