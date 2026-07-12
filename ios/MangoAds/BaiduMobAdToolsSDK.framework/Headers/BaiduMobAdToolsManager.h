//
//  BaiduMobAdToolsManager.h
//  BaiduMobAdToolsSDK
//
//  Created by sunmingzhe01 on 2024/7/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <BaiduMobAdToolsSDK/BaiduMobAdToolsConfig.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaiduMobAdToolsManager : NSObject

+ (BaiduMobAdToolsManager *)sharedInstance;

// 配置测试工具信息，需在展示前调用
- (void)setupConfig:(BaiduMobAdToolsConfig *)config;

// 展示测试工具
- (void)showTestToolsWithController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
