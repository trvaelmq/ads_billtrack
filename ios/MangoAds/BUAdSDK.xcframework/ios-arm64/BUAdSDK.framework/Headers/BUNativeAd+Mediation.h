//
//  BUNativeAd+Mediation.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUNativeAd.h"
#import "BUMRitInfo.h"
#import "BUMCanvasView.h"
#import "BUDictionary.h"
#import "BUPlayerPublicDefine.h"

@protocol BUMNativeAdDelegate;
@protocol BUNativeAdMediationProtocol;
typedef NSObject<BUNativeAdMediationProtocol> BUNativeAdMediation;

typedef NS_ENUM(NSUInteger, BUNativeCouponFlipType) {
    BUNativeCouponFlipDefault       = 0
};

typedef NS_ENUM(NSUInteger, BUNativeCouponSuspensionType) {
    BUNativeCouponSuspensionDefault       = 0,
    BUNativeCouponSuspensionCard          = 1,
    BUNativeCouponSuspensionIcon          = 2
};


NS_ASSUME_NONNULL_BEGIN

@interface BUNativeAd (Mediation)

// 当使用聚合广告位时，存在该属性，可获取聚合维度相关功能
@property (nonatomic, strong, nullable, readonly) BUNativeAdMediation *mediation;

// 为delegate增加聚合维度相关回调
@property (nonatomic, weak, readwrite, nullable) id<BUMNativeAdDelegate> delegate;

@end



@protocol BUNativeAdMediationProtocol <NSObject>

/// 是否是模板广告，由adapter开发者实现
@property (nonatomic, assign, readonly) BOOL isExpressAd;

/// 如果是模板广告可直接将该视图添加到需要展示的位置，如果是非模板广告可对该视图内部控件进行布局操作
@property (nonatomic, strong, readonly, nonnull)BUMCanvasView *canvasView;

/// 自渲染视频类广告事件上报对象，仅采用自定义视频播放器时需要上报，部分ADN需申请白名单
@property (nonatomic, strong, readonly) BUMVideoAdReporter *videoAdReporter;

/// [必要]渲染模板广告，开发者调用前无需区分是否为模板广告，GroMore会自行处理
- (void)render;

/// [保留方法]更新模板媒体视图大小
- (void)reSizeMediaView;

/// 是否已经准备广告展示，理论上在广告加载回调后即为YES，但受一些因素的影响（例如广告失效），可能为NO。建议在广告展示前调用该方法进行是否可以展示
@property (nonatomic, assign, readonly) BOOL isReady;

/// 返回显示广告对应的披露信息，当没有权限访问时Ecpm会返回'-3'
- (nullable BUMRitInfo *)getShowEcpmInfo;

/// 广告的扩展信息，可能为nil
- (BUDictionary *_Nullable)extraData;

/// 填充后可调用，但推荐展示后调用，返回竞价广告的ecpm；当为server bidding ad时访问需要白名单权限；
- (NSArray<BUMRitInfo *> *)multiBiddingEcpmInfos;

/// 填充后可调用, 返回广告缓存池内所有信息；nil为无权限
- (NSArray<BUMRitInfo *> *)cacheRitList;

/// 填充后可调用，返回当前最佳广告的ecpm；当为server bidding ad时访问需要白名单权限
- (BUMRitInfo *)getCurrentBestEcpmInfo;

/// 广告视图的唯一标识
@property (nonatomic, copy, readonly) NSString *adViewID;

@end



@protocol BUMNativeAdDelegate <BUNativeAdDelegate>

/// 广告即将展示全屏页面/商店时触发
/// @param nativeAd 广告视图
- (void)nativeAdWillPresentFullScreenModal:(BUNativeAd *_Nonnull)nativeAd;

/// 聚合维度混出模板广告时渲染成功回调，可能不会回调
/// @param nativeAd 模板广告对象
- (void)nativeAdExpressViewRenderSuccess:(BUNativeAd *_Nonnull)nativeAd;

/// 聚合维度混出模板广告时渲染失败回调，可能不会回调
/// @param nativeAd 模板广告对象
/// @param error 渲染出错原因
- (void)nativeAdExpressViewRenderFail:(BUNativeAd *_Nonnull)nativeAd error:(NSError *_Nullable)error;

/// 当视频播放状态改变之后触发
/// @param nativeAd 广告视图
/// @param playerState 变更后的播放状态
- (void)nativeAdVideo:(BUNativeAd *_Nullable)nativeAd stateDidChanged:(BUPlayerPlayState)playerState;

/// 广告视图中视频视图被点击时触发
/// @param nativeAd 广告视图
- (void)nativeAdVideoDidClick:(BUNativeAd *_Nullable)nativeAd;

/// 广告视图中视频播放完成时触发
/// @param nativeAd 广告视图
- (void)nativeAdVideoDidPlayFinish:(BUNativeAd *_Nullable)nativeAd;

/// 广告摇一摇提示view消除时调用该方法
/// @param nativeAd 广告视图
- (void)nativeAdShakeViewDidDismiss:(BUNativeAd *_Nullable)nativeAd;

/// 激励信息流视频进入倒计时状态时调用
/// @param nativeAdView 广告视图
/// @param countDown : 倒计时
/// @Note : 当前该回调仅适用于CSJ广告 - v4200
- (void)nativeAdVideo:(BUNativeAd *_Nullable)nativeAdView rewardDidCountDown:(NSInteger)countDown;

@end

NS_ASSUME_NONNULL_END
