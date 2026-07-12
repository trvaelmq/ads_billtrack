//
//  BUNativeAdsManager+Mediation.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUNativeAdsManager.h"
#import "BUMAdLoadInfo.h"

@protocol BUMNativeAdsManagerDelegate;
@protocol BUMNativeExpressAdViewDelegate;
@protocol BUNativeAdsManagerMediationProtocol;
typedef NSObject<BUNativeAdsManagerMediationProtocol> BUNativeAdsManagerMediation;

NS_ASSUME_NONNULL_BEGIN

@interface BUNativeAdsManager (Mediation)

// 当使用聚合广告位时，存在该属性，可获取聚合维度相关功能
@property (nonatomic, strong, nullable, readonly) BUNativeAdsManagerMediation *mediation;

// 为delegate增加聚合维度相关回调
@property (nonatomic, weak, nullable) id<BUMNativeAdsManagerDelegate> delegate;

@end



@protocol BUNativeAdsManagerMediationProtocol <NSObject>

/// 必要，设置广告详情跳转控制器
@property (nonatomic, weak) UIViewController *rootViewController;

/// 不再使用加载成功后回调的视图对象组时，可调用该方法释放占用的内存
- (void)destory;

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



@protocol BUMNativeAdsManagerDelegate <BUNativeAdsManagerDelegate>

@optional

/// 暂不开放使用
- (void)nativeAdsManager:(BUNativeAdsManager *_Nonnull)adsManager didWaitingBiddingResultWithParameters:(NSDictionary *)parameters andResumeHandler:(void(^)(NSDictionary *_Nullable data, NSError *_Nullable error))handler;

/// 暂不开放使用
- (void)nativeAdsManagerDidFinishLoadAdnAd:(BUNativeAdsManager *_Nonnull)adsManager nativeAd:(BUNativeAd *_Nullable)nativeAd error:(NSError *_Nullable)error;

@end

NS_ASSUME_NONNULL_END
