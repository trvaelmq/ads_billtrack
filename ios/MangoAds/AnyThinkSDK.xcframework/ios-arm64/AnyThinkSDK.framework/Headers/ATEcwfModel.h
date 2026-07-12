//
//  ATEcwfModel.h
//  AnyThinkSDK
//
//  Created by Captain on 2024/11/12.
//  Copyright © 2024 AnyThink. All rights reserved.
//

#import <AnyThinkSDK/ATModel.h>
#import <AnyThinkSDK/ATEcwfRuleModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATEcwfModel : ATModel
@property (atomic, strong) NSArray *oe_ids; // 规则ID列表
@property (nonatomic, assign) NSTimeInterval dt;// 动态广告源列表有效期，毫秒
@property (nonatomic, assign) BOOL sd_switch; // sd_sw 1-等待 2-不等待，sdk是否等待动态广告源列表返回
@property (nonatomic, assign) BOOL ss_switch; // ss_sw 1-等待 2-不等待，sdk是否使用步进间隔
@property (atomic, strong) NSDictionary<NSString *, ATEcwfRuleModel *> *oe;
@end

NS_ASSUME_NONNULL_END
