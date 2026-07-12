//
//  BUMCustomRewardedVideoAdapter.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import <Foundation/Foundation.h>
#import "BUMCustomAdapter.h"
#import "BUMCustomRewardedVideoAdapterBridge.h"

NS_ASSUME_NONNULL_BEGIN
/// 自定义激励视频广告的adapter广告协议
@protocol BUMCustomRewardedVideoAdapter <BUMCustomAdapter>

/// 加载广告的方法
/// @param slotID adn的广告位ID
/// @param parameter 广告加载的参数
- (void)loadRewardedVideoAdWithSlotID:(NSString *)slotID andParameter:(NSDictionary *)parameter;

/// 展示广告的方法
/// @param viewController 控制器对象
/// @param parameter 展示广告的参数，由GroMore接入媒体配置
- (BOOL)showAdFromRootViewController:(UIViewController *_Nonnull)viewController parameter:(NSDictionary *)parameter;

/// 当前加载的广告的状态
- (BUMMediatedAdStatus)mediatedAdStatus;

@optional
/// 代理，开发者需使用该对象回调事件，Objective-C下自动生成无需设置，Swift需声明
@property (nonatomic, weak, nullable) id<BUMCustomRewardedVideoAdapterBridge> bridge;

/// 回调信息补充
@property (nonatomic, copy, nullable, readonly) NSDictionary *extroInfoMap;

@end

NS_ASSUME_NONNULL_END
