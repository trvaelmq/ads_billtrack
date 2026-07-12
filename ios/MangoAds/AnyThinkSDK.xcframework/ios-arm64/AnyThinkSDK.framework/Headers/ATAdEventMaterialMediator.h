//
//  ATAdEventMaterialMediator.h
//  AnyThinkSDK
//
//  Created by Captain on 2025/2/24.
//  Copyright © 2025 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/ATAdDeveloperMaterialInfo.h>
#import <AnyThinkSDK/ATDeveloperMaterialDelegate.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATAdEventMaterialMediator : NSObject
+ (instancetype)sharedManager;

/// 添加事件观察者 请实现 ATDeveloperMaterialDelegate 相关方法
/// - Parameters:
///   - delegate: 代理, 注意每个placementID 只能设置一次, 每一次设置都会覆盖上一次设置
///   - placementID: placementID
- (void)setObserverDelegate:(id<ATDeveloperMaterialDelegate>)delegate
                placementID:(NSString *)placementID;

@end

NS_ASSUME_NONNULL_END
