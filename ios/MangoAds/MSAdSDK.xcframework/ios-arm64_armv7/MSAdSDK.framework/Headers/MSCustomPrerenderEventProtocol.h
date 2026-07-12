//
//  MSCustomPrerenderEventProtocol.h
//  MSAdSDK
//
//  Created by leej on 2022/5/20.
//  Copyright © 2022 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSCustomPrerenderEventProtocol <NSObject>

@required
/**
 *  广告加载成功后调用
 */
- (void)msCustomPrerenderLoaded:(NSArray<UIView*>*)adViewArray;
/**
 *  广告加载失败后调用
 */
- (void)msCustomPrerenderError:(NSError *)error;
/**
 *  广告视图渲染成功调用
 */
- (void)msCustomPrerenderRenderSuccess:(UIView *)adView adInfo:(NSDictionary *)adInfo;
/**
 *  广告视图渲染失败调用
 */
- (void)msCustomPrerenderRenderError:(UIView *)adView error:(NSError *)error;
/**
 *  广告曝光调用
 */
- (void)msCustomPrerenderShow:(UIView *)adView;
/**
 *  广告点击时调用
 */
- (void)msCustomPrerenderClicked:(UIView *)adView;
/**
 *  广告被关闭时调用
 */
- (void)msCustomPrerenderClosed:(UIView *)adView;
/**
   视频播放状态
 */
- (void)msCustomPrerenderPlayerStatus:(MSPlayerPlayState)status adView:(UIView *)adView;
@end

NS_ASSUME_NONNULL_END
