//
//  MSBannerViewDelegate.h
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/7/21.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#ifndef MSBannerViewDelegate_h
#define MSBannerViewDelegate_h

@class MSBannerView;

@protocol MSBannerViewDelegate <NSObject>

@optional
/**
   平台广告准备就绪，可以进行展示
 */
- (void)msBannerAdReadySuccess:(MSBannerView *)msBannerAd;
/**
 * 请求广告失败后调用
 */
- (void)msBannerError:(MSBannerView *)msBannerAd error:(NSError *)error;
/**
   广告渲染成功
 */
- (void)msBannerAdRenderSuccess:(MSBannerView *)msBannerAd;
/**
   广告渲染失败
 */
- (void)msBannerAdRenderFail:(MSBannerView *)msBannerAd error:(NSError *)error;
/**
 * banner广告曝光
 */
- (void)msBannerShow:(MSBannerView *)msBannerAd;
/**
 *  banner条点击回调
 */
- (void)msBannerClicked:(MSBannerView *)msBannerAd;
/**
 *  banner条被用户关闭时调用
 */
- (void)msBannerClosed:(MSBannerView *)msBannerAd;
/**
 *  banner广告点击以后弹出全屏广告页完毕
 */
- (void)msBannerDetailShow:(MSBannerView *)msBannerAd;
/**
 *  全屏广告页已经被关闭
 */
- (void)msBannerDetailClosed:(MSBannerView *)msBannerAd;

@end
#pragma mark banner扩展功能回调（包含统计、获取个性化参数等回调）
@protocol MSBannerViewExtensionFunctionDelegate <NSObject>

@optional
/**
 * 加载成功回调
 * 回调说明：广告加载成功时触发
 * 使用场景：媒体如需要统计广告加载成功数可通过实现该回调来统计数据
 */
- (void)msBannerLoaded:(MSBannerView *)msBannerAd;
/**
 渠道加载失败回调
* 回调说明：当前广告平台请求失败后调用，为保证填充，该广告位可能配置多家渠道，当前渠道请求失败后触发该回调，注意此回调并不代表本次请求动作已经结束且可能存在多次回调的情况
* 使用场景：媒体如需要统计渠道加载失败数可通过实现该回调来统计数据
 */
- (void)msBannerPlatformError:(MSPlatform)platform
                     bannerAd:(MSBannerView *)msBannerAd
                        error:(NSError *)error;
@end
#endif /* MSBannerViewDelegate_h */
