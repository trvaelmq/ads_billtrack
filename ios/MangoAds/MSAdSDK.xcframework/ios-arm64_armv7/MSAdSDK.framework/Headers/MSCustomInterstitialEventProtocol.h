//
//  MSCustomInterstitialEventProtocol.h
//  MSAdSDK
//
//  Created by leej on 2022/5/16.
//  Copyright © 2022 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSCustomInterstitialEventProtocol <NSObject>

@required
/**
 *  广告加载成功调用
 */
- (void)msCustomInterstitialEventLoaded;
/**
 *  广告加载失败调用
 */
- (void)msCustomInterstitialEventError:(NSError *)error;
/**
 *  广告渲染成功调用
 */
- (void)msCustomInterstitialEventRenderSuccess;
/**
 *  广告渲染失调用
 */
- (void)msCustomInterstitialEventRenderFailed:(NSError *)error;
/**
 *  插屏广告视图展示成功调用
 */
- (void)msCustomInterstitialEventShow;
/**
   平台广告展示失败调用
 */
- (void)msCustomInterstitialEventShowFail:(NSError *)error;
/**
 *  插屏广告展示结束调用
 */
- (void)msCustomInterstitialEventClosed;
/**
 *  插屏广告点击调用
 */
- (void)msCustomInterstitialEventClicked;
/**
 *  广告落地页被关闭调用
 */
- (void)msCustomInterstitialEventDetailClosed;
@end

NS_ASSUME_NONNULL_END
