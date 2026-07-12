//
//  ATDebuggerBridgingAPI.h
//  AnyThinkSDK
//
//  Created by GUO PENG on 2024/7/9.
//  Copyright © 2024 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/ATPlacementModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface ATDebuggerBridgingAPI : NSObject

+ (instancetype)sharedInstance;
/// 获取广告位 信息
- (void)debuggerOnlinePlacementInfo:(NSString *)debugkey completion:(void (^)(NSArray *responseArray))block;
/// 获取 WF 分组ID
- (void)debuggerOnlinePlacementWatllfull:(NSString *)debugkey placementID:(NSString *)placementID completion:(void (^)(NSDictionary *responseDic))block;
/// 获取广告源
- (void)debuggerOnlinePlacementAdSourcefull:(NSString *)debugkey placementID:(NSString *)placementID extraDic:(NSDictionary *)extraDic completion:(void (^)(ATPlacementModel *placementModel))block;


@end

NS_ASSUME_NONNULL_END
