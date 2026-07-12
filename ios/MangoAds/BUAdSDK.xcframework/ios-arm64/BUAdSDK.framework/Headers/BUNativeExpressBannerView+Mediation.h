//
//  BUNativeExpressBannerView+Mediation.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import <Foundation/Foundation.h>
#import "BUNativeExpressBannerView.h"
#import "BUMCanvasView.h"
#import "BUMRitInfo.h"
#import "BUMAdLoadInfo.h"

@protocol BUMNativeExpressBannerViewDelegate;
@protocol BUNativeExpressBannerViewMediationProtocol;
typedef NSObject<BUNativeExpressBannerViewMediationProtocol> BUNativeExpressBannerViewMediation;

NS_ASSUME_NONNULL_BEGIN

@interface BUNativeExpressBannerView (Mediation)

// 当使用聚合广告位时，存在该属性，可获取聚合维度相关功能
@property (nonatomic, strong, nullable, readonly) BUNativeExpressBannerViewMediation *mediation;

// 为delegate增加聚合维度相关回调
@property (nonatomic, weak, nullable) id<BUMNativeExpressBannerViewDelegate> delegate;

@end



@protocol BUNativeExpressBannerViewMediationProtocol <NSObject>

/// 平台设置的Banner轮播时间间隔, 范围[10, 180], 其他值按0处理, 默认为0，单位秒
@property (nonatomic, assign, readonly) NSInteger refreshTime;

/// 是否已经准备广告展示，理论上在广告加载回调后即为YES，但受一些因素的影响（例如广告失效），可能为NO。建议在广告展示前调用该方法进行是否可以展示
@property (nonatomic, assign, readonly) BOOL isReady;

/// 不再使用加载成功后回调的view时，可调用该方法释放占用的内存
- (void)destory;

/// 返回显示广告对应的披露信息，当没有权限访问时Ecpm会返回'-3'
- (nullable BUMRitInfo *)getShowEcpmInfo;

/// 填充后可调用, 返回广告缓存池内所有信息；nil为无权限
- (nullable NSArray<BUMRitInfo *> *)cacheRitList;

/// 填充后可调用，返回当前最佳广告的ecpm；当为server bidding ad时访问需要白名单权限；nil为无权限
- (nullable BUMRitInfo *)getCurrentBestEcpmInfo;

/// 填充后可调用，但推荐展示后调用，返回竞价广告的ecpm；当为server bidding ad时访问需要白名单权限；
- (nullable NSArray<BUMRitInfo *> *)multiBiddingEcpmInfos;


/// 广告是否加载中
@property (nonatomic, assign, readonly) BOOL isLoading;

/// 添加参数
/// @param param 参数值
/// @param key 参数key
- (void)addParam:(id)param withKey:(NSString *)key;

/// 一次waterfall中各adn代码位加载广告失败原因，建议调用时机：展示广告时/超时时/全部返回报错时；返回nil表示一次加载无代码位加载失败或其加载无响应
- (NSArray<NSDictionary *> *)waterfallFillFailMessages;

/// 同`waterfallFillFailMessages`，返回数据为`BUMAdLoadInfo`类型
- (NSArray<BUMAdLoadInfo *> *)getAdLoadInfoList;

@end


@protocol BUMNativeExpressBannerViewDelegate <BUNativeExpressBannerViewDelegate>

@optional

/// 广告展示回调
- (void)nativeExpressBannerAdViewDidBecomeVisible:(BUNativeExpressBannerView *)bannerAdView;

/// 广告加载成功后为「混用的信息流自渲染广告」时会触发该回调，提供给开发者自渲染的时机
/// @param bannerAd 广告操作对象
/// @param canvasView 携带物料的画布，需要对其内部提供的物料及控件做布局及设置UI
/// @warning 轮播开启时，每次轮播到自渲染广告均会触发该回调，并且canvasView为其他回调中bannerView的子控件
- (void)nativeExpressBannerAdNeedLayoutUI:(BUNativeExpressBannerView *)bannerAd canvasView:(BUMCanvasView *)canvasView;

@end

NS_ASSUME_NONNULL_END
