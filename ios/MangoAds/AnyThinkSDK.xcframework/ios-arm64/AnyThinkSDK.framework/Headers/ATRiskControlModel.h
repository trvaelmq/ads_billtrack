//
//  ATRiskControlModel.h
//  AnyThinkSDK
//
//  Created by Captain on 2025/2/12.
//  Copyright © 2025 AnyThink. All rights reserved.
//

#import <AnyThinkSDK/ATModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATRiskControlModel : ATModel
@property (nonatomic, copy, readonly, nullable) NSString *device_upid;
@property (nonatomic, copy, readonly, nullable) NSString *device_risk_labels;

@end

NS_ASSUME_NONNULL_END
