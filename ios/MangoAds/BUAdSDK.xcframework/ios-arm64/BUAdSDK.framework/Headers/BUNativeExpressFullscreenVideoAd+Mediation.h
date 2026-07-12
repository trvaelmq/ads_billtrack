//
//  BUNativeExpressFullscreenVideoAd+Mediation.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUNativeExpressFullscreenVideoAd.h"
#import "BURewardedVideoModel.h"
#import "BUMRitInfo.h"
#import "BUMAdLoadInfo.h"

@protocol BUMNativeExpressFullscreenVideoAdDelegate;
@protocol BUNativeExpressFullscreenVideoAdMediationProtocol;
typedef NSObject<BUNativeExpressFullscreenVideoAdMediationProtocol> BUNativeExpressFullscreenVideoAdMediation;

NS_ASSUME_NONNULL_BEGIN

@interface BUNativeExpressFullscreenVideoAd (Mediation)

// 当使用聚合广告位时，存在该属性，可获取聚合维度相关功能
@property (nonatomic, strong, nullable, readonly) BUNativeExpressFullscreenVideoAdMediation *mediation;

// 为delegate增加聚合维度相关回调
@property (nonatomic, weak, nullable) id<BUMNativeExpressFullscreenVideoAdDelegate> delegate;

@end



@protocol BUNativeExpressFullscreenVideoAdMediationProtocol <NSObject>

///  optional 激励模型，用于全屏视频广告服务端激励回调；目前支持的adn:GDT
@property (nonatomic, strong) BURewardedVideoModel *rewardModel;

/// 是否已经准备广告展示，理论上在广告加载回调后即为YES，但受一些因素的影响（例如广告失效），可能为NO。建议在广告展示前调用该方法进行是否可以展示
@property (nonatomic, assign, readonly) BOOL isReady;

/// 返回显示广告对应的披露信息，当没有权限访问时Ecpm会返回'-3'
- (nullable BUMRitInfo *)getShowEcpmInfo;

/// 填充后可调用，返回当前最佳广告的ecpm；当为server bidding ad时访问需要白名单权限；nil为无权限
- (nullable BUMRitInfo *)getCurrentBestEcpmInfo;

/// 填充后可调用，但推荐展示后调用，返回竞价广告的ecpm；当为server bidding ad时访问需要白名单权限；
- (nullable NSArray<BUMRitInfo *> *)multiBiddingEcpmInfos;

/// 填充后可调用, 返回广告缓存池内所有信息；nil为无权限
- (nullable NSArray<BUMRitInfo *> *)cacheRitList;

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



@protocol BUMNativeExpressFullscreenVideoAdDelegate <BUNativeExpressFullscreenVideoAdDelegate>

@optional
/// 广告展示失败回调
/// @param fullscreenVideoAd 广告管理对象
/// @param error 展示失败的原因
- (void)nativeExpressFullscreenVideoAdDidShowFailed:(BUNativeExpressFullscreenVideoAd *_Nonnull)fullscreenVideoAd error:(NSError *_Nonnull)error;

/// 即将弹出广告详情页回调
/// @param fullscreenVideoAd 广告管理对象
- (void)nativeExpressFullscreenVideoAdWillPresentFullScreenModal:(BUNativeExpressFullscreenVideoAd *_Nonnull)fullscreenVideoAd;

/// 目前支持的adn:GDT
- (void)nativeExpressFullscreenVideoAdServerRewardDidSucceed:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd verify:(BOOL)verify;

/// 目前支持的adn:GDT
- (void)nativeExpressFullscreenVideoAdServerRewardDidFail:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd error:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
