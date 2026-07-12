//
//  MSSplashAd.h
//  MSAdSDK
//  开屏广告
//  Created by yang on 2019/8/13.
//  Copyright © 2019 yang. All rights reserved.
//


#import "MSBaseAd.h"
#import "MSSplashAdDelegate.h"
#import "MSBaseAdConfigParams.h"

NS_ASSUME_NONNULL_BEGIN
/**
 开屏图片或者视频素材尺寸
 提示：
 1、width & height 代表像素值
 2、支持平台：【ms】
 */
extern NSString *const kMSAdMediaAdSplashSizeKey;

@interface MSSplashAd : MSBaseAd
/**
 * 开屏广告基础回调代理对象
 */
@property(nonatomic,weak) id<MSSplashAdDelegate> delegate;
/**
 * 开屏广告扩展回调代理对象
 * 如不需要扩展回调相关功能，可不用指定
 */
@property(nonatomic,weak) id<MSSplashAdExtensionFuctionDelegate> extDelegate;
/**
 获取广告是否正在显示
 */
@property(nonatomic,assign,readonly) BOOL adShow;
/**
 加载并显示
 详解：调用此接口，sdk内部会加载广告并在成功获取到广告物料后进行展示
 注意：调用此接口后无需再调用show接口
 @param pid                     广告位id    [必传]
 @param configParams 广告参数    [必传]
 @param window 展示广告的window [必传]
 */
- (void)loadAndShowSplashAdWithPid:(NSString *)pid adParam:(MSSplashAdConfigParams *)configParams inWindow:(UIWindow *)window;
/**
 加载广告
 详解：调用该接口加载广告
 注意：如果调用此接口加载广告，请在收到msSplashAdReadySuccess回调后调用show接口
 [@param pid                       广告位id    [必传]
 @param configParams 广告参数   [必传]
 */
- (void)loadSplashAdWithPid:(NSString *)pid adParam:(MSSplashAdConfigParams *)configParams;
/**
 广告价格  单位：分 [C2S下，返回渠道出价，非C2S下，返回平台填写的固价]
 注意：广告加载成功后获取
 */
- (NSInteger)ecpm;
/**
 广告是否有效
 注意：调用show接口前建议先检测广告是否有效
 */
- (BOOL)isAdValid;
/**
 显示在指定window上
 @param window 指定window，该window需设置rootViewController后传入，否则会存在广告落地页无法弹出的情况
 提示：
 1、注意⚠️为保证开屏广告正常展示，请在收到msSplashAdReadySuccess回调后调用该接口，加载广告方式请务必调用- (void)loadSplashAd:(NSString *)pid;接口
 */
- (void)showSplashAdInWindow:(UIWindow *)window;
/**
 移除开屏广告（2.4.5.0版本及以上新增接口）
 提示：
 1、开发者主动移除开屏广告后，广告及广告落地页将不再展示，后续相关回调将不再触发
 2、返回值YES代表移除成功 NO代表移除失败
 3、此接口不兼容百度开屏
 */
- (BOOL)removeSplashAdView;
/**
 取消加载
 注意：广告加载成功后无法取消
 */
-(void)cancel;

@end

NS_ASSUME_NONNULL_END
