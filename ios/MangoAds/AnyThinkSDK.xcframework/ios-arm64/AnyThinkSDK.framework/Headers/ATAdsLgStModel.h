//
//  ATAdsLgStModel.h
//  AnyThinkSDK
//
//  Created by Captain on 2025/1/6.
//  Copyright © 2025 AnyThink. All rights reserved.
//

#import <AnyThinkSDK/ATModel.h>
#import <AnyThinkSDK/ATAdsLgStRuleModel.h>
NS_ASSUME_NONNULL_BEGIN


@interface ATAdsLgStModel : ATModel
@property (atomic, strong) NSDictionary<NSString *, ATAdsLgStRuleModel *> *adsLgStRules;

@end

NS_ASSUME_NONNULL_END
