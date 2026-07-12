//
//  MSVideoAdDelegate.h
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/7/23.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#ifndef MSVideoAdDelegate_h
#define MSVideoAdDelegate_h

@class MSVideoAd;

@protocol MSVideoAdDelegate <NSObject>

@optional
/**
 平台广告准备就绪，可以进行展示
 */
- (void)msVideoReadySuccess:(MSVideoAd *)videoAd;
/**
 *  视频广告成功展示
 */
- (void)msVideoShow:(MSVideoAd *)videoAd;
/**
    视频广告播放失败
 */
-(void)msVideoPlayingError:(MSVideoAd *)videoAd error:(NSError *)error;
/**
 *  视频广告加载失败
 */
- (void)msVideoError:(MSVideoAd *)videoAd error:(NSError *)error;
/**
 *  视频广告点击回调
 */
- (void)msVideoClick:(MSVideoAd *)videoAd;
/**
 *  视频广告点击关闭
 *  注意：只有广点通、穿山甲广告才会触发
 */
- (void)msVideoClose:(MSVideoAd *)videoAd;
/**
 *  视频广告size更新
 *  注意：只有广点通广告才会触发
 */
- (void)msVideoResize:(MSVideoAd *)videoAd adSize:(CGSize)adSize;
/**
 *  视频广告播放完成
 */
- (void)msVideoCompletion:(MSVideoAd *)videoAd;

@end
#pragma mark 贴片扩展功能回调（包含统计、获取个性化参数等回调）
@protocol MSVideoAdExtensionFunctionDelegate <NSObject>

@optional
/**
 * 加载成功回调
 * 回调说明：广告加载成功时触发
 * 使用场景：媒体如需要统计广告加载成功数可通过实现该回调来统计数据
 */
- (void)msVideoLoad:(MSVideoAd *)videoAd;
/**
   渠道加载失败回调
 * 回调说明：当前广告平台请求失败后调用，为保证填充，该广告位可能配置多家渠道，当前渠道请求失败后触发该回调，注意此回调并不代表本次请求动作已经结束且可能存在多次回调的情况
 * 使用场景：媒体如需要统计渠道加载失败数可通过实现该回调来统计数据
 */
- (void)msVideoPlatformError:(MSPlatform)platform ad: (MSVideoAd *)videoAd error:(NSError *)error;

@end

#endif /* MSVideoAdDelegate_h */
