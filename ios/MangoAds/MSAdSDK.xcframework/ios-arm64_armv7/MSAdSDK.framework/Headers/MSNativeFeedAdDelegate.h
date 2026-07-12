//
//  MSNativeFeedAdDelegate.h
//  MSAdSDK
//
//  Created by leej on 2021/7/31.
//  Copyright © 2021 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MSNativeFeedAdModel;
@class MSNativeFeedAd;

@protocol MSNativeFeedAdDelegate <NSObject>

@optional
/**
 *  新原生广告加载广告数据成功回调，返回为广告物料的数组
 *
 */
- (void)msNativeFeedAdLoaded:(MSNativeFeedAd *)nativeFeedAd feedAds:(NSArray <MSNativeFeedAdModel *> *)feedAds;
/**
 *  新原生广告加载广告数据失败回调
 */
- (void)msNativeFeedAdError:(MSNativeFeedAd *)nativeFeedAd withError:(NSError *)error;
/**
 *  广告素材预处理成功回调
 */
- (void)msNativeFeedAdMaterialMetaReadySuccess:(MSNativeFeedAd *)nativeFeedAd feedAd:(MSNativeFeedAdModel *)feedAd;
/**
 *  广告素材预处理失败回调
 */
- (void)msNativeFeedAdMaterialMetaReadyError:(MSNativeFeedAd *)nativeFeedAd feedAd:(MSNativeFeedAdModel *)feedAd error:(NSError *)error;
/**
 *注意⚠️：当该广告物料是⚠️[模版广告]⚠️时触发此回调
 *  广告被关闭
 *  详解:广告点击关闭后回调
 */
- (void)msNativeFeedAdClosed:(MSNativeFeedAdModel *)feedAd;
/**
 *  新原生广告即将展现
 */
- (void)msNativeFeedAdShow:(MSNativeFeedAdModel *)feedAd;
/**
 *  新原生广告展现失败
 */
- (void)msNativeFeedAdShowFailed:(MSNativeFeedAdModel *)feedAd error:(NSError *)error;
/**
 *  广告被点击
 */
- (void)msNativeFeedAdClick:(MSNativeFeedAdModel *)feedAd;
/**
 模版视频播放状态
 注意：仅ms、广点通、穿山甲会回调
 */
- (void)msNativeFeedAdVideoStateDidChanged:(MSPlayerPlayState)playerState
                                    feedAd:(MSNativeFeedAdModel *)feedAd;
/**
 *注意⚠️：当该广告物料是⚠️自渲染广告⚠️时触发此回调
 *  原生广告点击之后将要展示内嵌浏览器或应用内AppStore回调
 */
- (void)msNativeFeedAdDetailShow;
/**
 *注意⚠️：当该广告物料是⚠️自渲染广告⚠️时触发此回调
 * 新原生广告点击以后，内置AppStore或是内置浏览器被关闭时回调
 */
- (void)msNativeFeedAdDetailClosed;

@end
#pragma mark 信息流混合广告扩展功能回调（包含统计、获取个性化参数等回调）

@protocol MSNativeFeedAdExtensionFunctionDelegate <NSObject>

@optional
/**
   渠道加载失败回调
 * 回调说明：当前广告平台请求失败后调用，为保证填充，该广告位可能配置多家渠道，当前渠道请求失败后触发该回调，注意此回调并不代表本次请求动作已经结束且可能存在多次回调的情况
 * 使用场景：媒体如需要统计渠道加载失败数可通过实现该回调来统计数据
 */
- (void)msNativeFeedAdPlatformError:(MSPlatform)platform nativeFeedAd:(MSNativeFeedAd *)nativeFeedAd error:(NSError *)error;
@end

NS_ASSUME_NONNULL_END
