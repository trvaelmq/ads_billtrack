//
//  MSDrawAdManager.h
//  MSAdSDK
//
//  Created by leej on 2022/2/21.
//  Copyright © 2022 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSDrawAd.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MSDrawAdManagerDelegate <NSObject>

@optional
/**
 广告加载成功
 */
-(void)msDrawAdManagerLoadSuccess:(NSArray<MSDrawAd *> *)drawAds;
/**
 最终失败回调
 */
-(void)msDrawAdManagerLoadFailed:(NSError *)error;
/**
*  获取平台加载错误信息
*  详解:该回调仅表示当前平台加载失败，并不代表当次请求过程已结束，请勿在此回调中释放广告请求对象
   可能会调用多次
   @param platform 平台标识 代表当前哪个平台加载失败
   @param drawAd   广告请求对象
   @param error    平台错误信息
*/
-(void)msDrawAdManagerPlatformError:(MSPlatform)platform
                            videoAd:(MSDrawAd *)drawAd
                              error:(NSError *)error;
/**
 视频缓存成功
 */
- (void)msDrawAdVideoCacheSuccess:(MSDrawAd *)drawAd;
/**
 视频缓存失败
 */
- (void)msDrawAdVideoCacheFailed:(MSDrawAd *)drawAd withError:(NSError *)error;
@end

@interface MSDrawAdManager : NSObject
/**
 加载广告
 @param pid             广告位id  必传
 @param adParams  广告参数  必传
 @param adCount   广告请求个数，默认拉取1条 建议不要拉取过多
 @param delegate  回调接受delegate 必传
 */
-(void)loadAdWithPid:(NSString *)pid
               count:(NSInteger)adCount
            adParams:(MSDrawAdConfigParams *)adParams
            delegate:(id<MSDrawAdManagerDelegate>)delegate;
      
@end

NS_ASSUME_NONNULL_END
