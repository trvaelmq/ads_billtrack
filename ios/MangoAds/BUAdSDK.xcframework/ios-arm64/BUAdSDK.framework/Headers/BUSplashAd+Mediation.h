//
//  BUSplashAd+Mediation.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUSplashAd.h"
#import "BUMSplashUserData.h"
#import "BUMAdLoadInfo.h"
#import "BUMRitInfo.h"

@protocol BUMSplashAdDelegate;
@protocol BUSplashAdMediationProtocol;
typedef NSObject<BUSplashAdMediationProtocol> BUSplashAdMediation;

// 开屏点击区域类型
typedef NS_ENUM(NSInteger, BUMSplashButtonType) {
  BUMSplashButtonTypeFullScreen = 1, // The whole area of splash view will respond to click event
  BUMSplashButtonTypeDownloadBar = 2  // The area of download bar in splash view will respond to click event
};

NS_ASSUME_NONNULL_BEGIN

@interface BUSplashAd (Mediation)

// 当使用聚合广告位时，存在该属性，可获取聚合维度相关功能
@property (nonatomic, strong, nullable, readonly) BUSplashAdMediation *mediation;

// 为delegate增加聚合维度相关回调
@property (nonatomic, weak, nullable) id<BUMSplashAdDelegate> delegate;

@end



@protocol BUSplashAdMediationProtocol <NSObject>

/// 自定义底部视图，可以设置一些自定义元素，例如LOGO。如果不设置，广告将按照全屏展示。底部视图最大高度不能超过屏幕高度的25%，否则将按照约定最大高度适配
/// @warning 设置该属性会忽略初始化传入的adsize，根据传入customBottomView视图的宽高从新计算adSize以保证得到最佳展示效果。
@property (nonatomic, strong, nullable) UIView *customBottomView;

/// 销毁广告，建议在不需要展示广告时调用，如close时
- (void)destoryAd;

/// optional. Config the behaviour of click splash view.Deafult value is BUMSplashButtonTypeFullScreen.Now only valid for adn: baidu.
@property (nonatomic, assign) BUMSplashButtonType splashButtonType;

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



@protocol BUMSplashAdDelegate <BUSplashAdDelegate>

@optional

/// 广告展示失败回调
/// @param splashAd 广告管理对象
/// @param error 展示失败原因
- (void)splashAdDidShowFailed:(BUSplashAd *_Nonnull)splashAd error:(NSError *)error;

/// 广告即将展示广告详情页回调
/// @param splashAd 广告管理对象
- (void)splashAdWillPresentFullScreenModal:(BUSplashAd *)splashAd;

@end

NS_ASSUME_NONNULL_END
