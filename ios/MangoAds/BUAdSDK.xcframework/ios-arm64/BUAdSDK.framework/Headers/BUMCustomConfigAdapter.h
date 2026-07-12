//
//  BUMCustomConfigAdapter.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import <Foundation/Foundation.h>
#import "BUMSdkInitConfig.h"

#import "BUMCustomBannerAdapter.h"
#import "BUMCustomInterstitialAdapter.h"
#import "BUMCustomRewardedVideoAdapter.h"
#import "BUMCustomFullscreenVideoAdapter.h"
#import "BUMCustomDrawAdapter.h"
#import "BUMCustomSplashAdapter.h"
#import "BUMCustomNativeAdapter.h"
#import "BUMCustomAdapterVersion.h"

NS_ASSUME_NONNULL_BEGIN

/// 自定义adapter的基本配置协议
@protocol BUMCustomConfigAdapter <NSObject>
@required

/// 该自定义adapter是基于哪个版本实现的，填写编写时的最新值即可，GroMore会根据该值进行兼容处理
- (BUMCustomAdapterVersion *)basedOnCustomAdapterVersion;

/// adn初始化方法
/// @param initConfig 初始化配置，包括appid、appkey基本信息和部分用户传递配置
- (void)initializeAdapterWithConfiguration:(BUMSdkInitConfig *_Nullable)initConfig;

/// adapter的版本号
- (NSString *_Nonnull)adapterVersion;

/// adn的版本号
- (NSString *_Nonnull)networkSdkVersion;

/// 用于统计adn的初始化相关信息，结构是字典，例：@{"status":@(YES),@"duration":@(200)}
/// 其中status代表初始化结果，YES成功，NO失败；duration代表耗时，单位是ms。
- (NSMutableDictionary *)adnInitInfo;

/// 隐私权限更新，用户更新隐私配置时触发，初始化方法调用前一定会触发一次
- (void)didRequestAdPrivacyConfigUpdate:(NSDictionary *)config;

/// 收到配置更新请求时触发，如主题更新，初始化时设定配置不会触发，具体修改项需自行校验
- (void)didReceiveConfigUpdateRequest:(BUMUserConfig *)config;

@optional

/// 无需实现
@property (nonatomic, assign) BOOL isCustomAdapter;
@end

NS_ASSUME_NONNULL_END
