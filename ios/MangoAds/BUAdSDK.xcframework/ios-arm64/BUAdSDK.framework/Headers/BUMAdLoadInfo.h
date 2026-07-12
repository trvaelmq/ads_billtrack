//
//  BUMAdLoadInfo.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUInterfaceBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface BUMAdLoadInfo : BUInterfaceBaseObject

/// network的广告位ID
@property (nonatomic, copy, readonly) NSString *mediationRit;

/// network的名称，同平台配置
@property (nonatomic, copy, readonly) NSString *adnName;

/// network的自定义名称，同平台配置，非自定义时为nil
@property (nonatomic, copy, readonly, nullable) NSString *customAdnName;

/// 错误码
@property (nonatomic, assign, readonly) NSInteger errCode;

/// 错误描述
@property (nonatomic, copy, readonly) NSString *errMsg;

@end

NS_ASSUME_NONNULL_END
