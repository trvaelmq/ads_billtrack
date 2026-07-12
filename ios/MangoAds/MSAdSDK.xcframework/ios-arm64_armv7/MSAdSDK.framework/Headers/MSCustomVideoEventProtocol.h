//
//  MSCustomVideoEventProtocol.h
//  MSAdSDK
//
//  Created by leej on 2022/5/18.
//  Copyright © 2022 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSCustomVideoEventProtocol <NSObject>

@required
/**
 *  视频广告加载成功调用
 */
- (void)msCustomVideoLoad;
/**
 *  视频广告成功展示调用
 */
- (void)msCustomVideoShow:(UIView *)videoAd;
/**
    视频广告播放失败调用
 */
-(void)msCustomVideoPlayingError:(UIView *)videoAd error:(NSError *)error;
/**
 *  视频广告加载失败调用
 */
- (void)msCustomVideoError:(NSError *)error;
/**
 *  视频广告点击调用
 */
- (void)msCustomVideoClick:(UIView *)videoAd;
/**
 *  视频广告点击关闭调用
 */
- (void)msCustomVideoClose:(UIView *)videoAd;
/**
 *  视频广告size更新调用
 */
- (void)msCustomVideoResize:(UIView *)videoAd adSize:(CGSize)adSize;
/**
 *  视频广告播放完成调用
 */
- (void)msCustomVideoCompletion:(UIView *)videoAd;
@end

NS_ASSUME_NONNULL_END
