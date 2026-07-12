//
//  BUMUserConfig.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUInterfaceBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

// Theme mode for iOS.
typedef NS_ENUM(NSInteger, BUMAdSDKThemeStatus) {
    BUMAdSDKThemeStatus_None = -1,
    BUMAdSDKThemeStatus_Normal = 0,
    BUMAdSDKThemeStatus_Night  = 1,
};

@interface BUMUserConfig : BUInterfaceBaseObject

/// 设置广告主题，扩展暗黑模式
@property (nonatomic, assign) BUMAdSDKThemeStatus themeStatus;

/// 设置扩展设备信息，如不了解该功能，请勿使用。 如@"[{\"device_id\":\"62271333038\"}]"
@property (nonatomic, copy) NSDictionary *extraDeviceMap;

/// 自定义IDFA，格式需与IDFA格式相同，xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx，官方adapter中CSJ，KS，Sigmob，Mintegral支持
@property (nonatomic, copy, nullable) NSString *customIDFA;

@end

NS_ASSUME_NONNULL_END
