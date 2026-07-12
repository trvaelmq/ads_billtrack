//
//  BUNativeExpressAdManager+Mediation.h
//  BUAdSDK
//
//  Created by 🦁 on 2023/12/18.
//

#import "BUNativeExpressAdManager.h"
#import "BUNativeExpressAdViewDelegate.h"
#import "BUMAdLoadInfo.h"
#import "BUMNativeExpressAdViewDelegate.h"
#import "BUMCanvasView.h"

@protocol BUNativeExpressAdManagerMediationProtocol;
typedef NSObject<BUNativeExpressAdManagerMediationProtocol> BUNativeExpressAdManagerMediation;

NS_ASSUME_NONNULL_BEGIN

@interface BUNativeExpressAdManager (Mediation)

// 当使用聚合广告位时，存在该属性，可获取聚合维度相关功能
@property (nonatomic, strong, nullable, readonly) BUNativeExpressAdManagerMediation *mediation;

// 为delegate增加聚合维度相关回调
@property (nonatomic, weak, nullable) id<BUMNativeExpressAdViewDelegate> delegate;

@end



@protocol BUNativeExpressAdManagerMediationProtocol <NSObject>

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

NS_ASSUME_NONNULL_END
