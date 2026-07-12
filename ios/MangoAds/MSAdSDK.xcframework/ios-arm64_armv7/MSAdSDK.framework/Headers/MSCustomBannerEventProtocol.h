//
//  MSCustomBannerEventProtocol.h
//  MSAdSDK
//
//  Created by leej on 2022/5/17.
//  Copyright © 2022 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSCustomBannerEventProtocol <NSObject>

@required
/**
 *  广告加载成功调用
 */
- (void)msCustomBannerLoaded:(UIView *)bannerAd;
/**
 *  广告加载失败调用
 */
- (void)msCustomBannerError:(NSError *)error;
/**
    广告渲染成功调用
 */
- (void)msCustomBannerAdRenderSuccess:(UIView *)bannerAd;
/**
    广告渲染失败调用
 */
- (void)msCustomBannerAdRenderFail:(UIView *)bannerAd error:(NSError *)error;
/**
 *  banner广告曝光调用
 */
- (void)msCustomBannerShow:(UIView *)bannerAd;
/**
 *  banner条点击调用
 */
- (void)msCustomBannerClicked:(UIView *)bannerAd;
/**
 *  banner条被用户关闭时调用
 */
- (void)msCustomBannerClosed:(UIView *)bannerAd;
/**
 *  banner广告点击以后弹出全屏广告页完毕调用
 */
- (void)msCustomBannerDetailShow:(UIView *)bannerAd;
/**
 *  全屏广告页已经被关闭调用
 */
- (void)msCustomBannerDetailClosed:(UIView *)bannerAd;
@end

NS_ASSUME_NONNULL_END
