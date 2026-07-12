//
//  ATEcwfRuleModel.h
//  AnyThinkSDK
//
//  Created by Captain on 2024/11/12.
//  Copyright © 2024 AnyThink. All rights reserved.
//

#import <AnyThinkSDK/ATModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATEcwfRuleModel : ATModel
@property (nonatomic, assign) NSInteger networkFirmID;
@property (nonatomic, assign) NSTimeInterval t;// 毫秒
@property (atomic, strong) NSArray <NSString *>*codes; // error codes
@property (atomic, strong) NSDictionary<NSString *, NSArray<NSString *> *> *msgs;


@end

NS_ASSUME_NONNULL_END
