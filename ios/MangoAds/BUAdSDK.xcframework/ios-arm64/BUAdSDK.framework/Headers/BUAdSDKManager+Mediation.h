//
//  BUAdSDKManager+Mediation.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUAdSDKManager.h"
#import "BUMUserInfoForSegment.h"

@protocol BUAdSDKManagerMediationProtocol;
typedef Class<BUAdSDKManagerMediationProtocol> BUAdSDKManagerMediation;

NS_ASSUME_NONNULL_BEGIN

@interface BUAdSDKManager (Mediation)

/// 初始化后，可调用该接口，用于继续调用聚合维度相关方法
@property (class) BUAdSDKManagerMediation mediation;

@end



@protocol BUAdSDKManagerMediationProtocol <NSObject>

/// 获取各类补充信息
+ (NSDictionary * _Nullable)getMediationExtraInfo;

/// 触发首次预缓存,针对特定广告位
/// @param infos 广告对象
/// @param interval 指定每轮请求的时间间隔, 允许时间范围:1-10
/// @param concurrent 并发请求的广告数, 允许个数范围:1-20
+ (void)preloadAdsWithInfos:(NSArray *)infos andInterval:(NSInteger)interval andConcurrent:(NSInteger)concurrent;

/// 个性化配置类
+ (void)configAdapterWithKey:(NSString *)key andBlock:(void(^)(void))block;

/// 流量分组信息
+ (BUMUserInfoForSegment *)userInfoForSegment;

@end

NS_ASSUME_NONNULL_END
