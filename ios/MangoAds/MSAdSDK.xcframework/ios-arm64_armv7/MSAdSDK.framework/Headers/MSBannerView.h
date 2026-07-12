//
//  MSBannerAd.h
//  MSAdSDK
//
//  Created by Liumaos on 2020/7/21.
//  Copyright © 2020 Adxdata. All rights reserved.
//


#import "MSBaseViewAd.h"
#import "MSBannerViewDelegate.h"
#import "MSBaseAdConfigParams.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSBannerView : MSBaseViewAd
/**
 * banner基础回调代理
 */
@property(nonatomic,weak) id<MSBannerViewDelegate> delegate;
/**
 * banner扩展回调代理
 * 如不需要扩展回调相关功能，可不用指定
 */
@property(nonatomic,weak) id<MSBannerViewExtensionFunctionDelegate> extDelegate;
/**
 *  构造方法
 *  详解：frame - banner 展示的位置和大小
 */
- (instancetype)initWithFrame:(CGRect)frame;
/**
 *  拉取并展示广告
 *  @param pid                                             广告位id   [必传]
 *  @param currentViewController     弹出vc      [必传]
 *  @param adParams                                  广告参数  [必传]
 */
- (void)loadAdAndShowWithPid:(NSString *)pid presentVC:(UIViewController*)currentViewController adParams:(MSBannerAdConfigParams *)adParams;
/**
 *  关闭广告
 *  详解：在不需要展示横幅广告或横幅广告关闭按钮被点击时调用该方法
 */
- (void)dismiss;
/**
   是否显示关闭按钮
   传入时机：加载广告前
   注意：如不设置则以MSBannerAdConfigParams 实例化参数为准
 */
- (void)showCloseBtn:(BOOL)showCloseBtn;
/**
 广告是否有效
 注意：展示广告前建议先检测广告是否有效
 */
- (BOOL)isAdValid;
/**
 广告价格  单位：分 [C2S下，返回渠道出价，非C2S下，返回平台填写的固价]
 注意：广告加载成功后获取
 */
- (NSInteger)ecpm;
@end

NS_ASSUME_NONNULL_END
