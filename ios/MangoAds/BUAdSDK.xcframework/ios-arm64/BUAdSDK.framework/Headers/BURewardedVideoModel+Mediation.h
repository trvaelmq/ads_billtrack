//
//  BURewardedVideoModel+Mediation.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BURewardedVideoModel.h"
@class BURewardedVideoModelMediation;

NS_ASSUME_NONNULL_BEGIN

@interface BURewardedVideoModel (Mediation)

/// 调用该接口，用于继续设置聚合维度相关属性
@property (nonatomic, strong, readonly) BURewardedVideoModelMediation *mediation;

@end



@interface BURewardedVideoModelMediation : NSObject

/// adn定义的奖励id
@property (nonatomic, copy, readonly, nullable) NSString *rewardId;

/// 交易的唯一标识
@property (nonatomic, copy, readonly, nullable) NSString *tradeId;

/// 验证奖励发放的媒体名称，官方支持的ADN名称详见`ABUAdnType`注释部分，自定义ADN名称同平台配置
@property (nonatomic, copy, readonly, nullable) NSString *adnName;

/// 验证奖励发放的ecpm，实际返回受规则限制
@property (nonatomic, copy, readonly, nullable) NSString *ecpm;

/// 是否是通过GroMore的S2S的验证
@property (nonatomic, assign, readonly) BOOL verifyByGroMoreS2S;

/// 验证失败的原因
@property (nonatomic, copy, readonly, nullable) NSString *reason;

@end

NS_ASSUME_NONNULL_END
