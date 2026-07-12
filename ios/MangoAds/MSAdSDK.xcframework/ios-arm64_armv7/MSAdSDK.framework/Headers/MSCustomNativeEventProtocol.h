//
//  MSCustomNativeEventProtocol.h
//  MSAdSDK
//
//  Created by leej on 2022/5/20.
//  Copyright © 2022 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSCustomNativeEventProtocol <NSObject>
/**
 *  原生广告加载广告成功调用
 */
- (void)msCustomNativeLoaded:(NSArray *)nativeAdDataArray;
/**
 *  原生广告加载广告失败调用
 */
- (void)msCustomNativeError:(NSError *)error;
/**
 *  原生广告即将展现调用
 *  adContainerView为添加广告的容器
 */
- (void)msCustomNativeShow:(id<MSFeedAdMeta>)feedAdData adContainerView:(UIView *)adContainerView;
/**
 *  广告被点击调用
 */
- (void)msCustomNativeClick:(id<MSFeedAdMeta>)feedAdData;
/**
 *  广告被关闭调用
 */
- (void)msCustomNativeClosed:(id<MSFeedAdMeta>)feedAdData adView:(UIView *)adView;
/**
 *  原生广告落地页已展现调用
 */
- (void)msCustomNativeDetailShow;
/**
 * 落地页关闭时调用
 */
- (void)msCustomNativeDetailClosed;
@end

NS_ASSUME_NONNULL_END
