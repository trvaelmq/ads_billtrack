//
//  MSCustomSplashEventProtocol.h
//  MSAdSDK
//
//  Created by leej on 2022/4/26.
//  Copyright © 2022 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSCustomSplashEventProtocol <NSObject>

@required
/**
 * 开屏广告加载成功调用
 */
- (void)msCustomSplashEventSplashLoaded;
/**
 *  开屏广告失败调用
 */
- (void)msCustomSplashEventError:(NSError *)error;
/**
 *  开屏广告渲染成功调用
 */
- (void)msCustomSplashEventRenderSuccess;
/**
 *  开屏广告渲染失败调用
 */
- (void)msCustomSplashEventRenderFailedError:(NSError *)error;
/**
 * 开屏广告投屏成功调用
 */
- (void)msCustomSplashEventSplashPresent;
/**
 *  开屏广告曝光成功调用
 */
- (void)msCustomSplashEventSplashShow;
/**
 *  开屏广告曝光失败调用
 */
- (void)msCustomSplashEventSplashAdShowFail:(NSError *)error;
/**
 *  开屏广告点击调用
 */
- (void)msCustomSplashEventSplashClicked;
/**
 *  开屏广告将要关闭调用
 */
- (void)msCustomSplashEventSplashWillClosed;
/**
 *  开屏广告关闭调用
 */
- (void)msCustomSplashEventSplashClosed;
/**
 *  点击以后全屏广告页已经关闭调用
 */
- (void)msCustomSplashEventSplashDetailClosed;
/**
 * 当用户点击跳过按钮时触发调用
 */
- (void)msCustomSplashEventSplashSkip;

@end

NS_ASSUME_NONNULL_END
