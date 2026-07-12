//
//  BUAdSDKConfiguration+Mediation.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUAdSDKConfiguration.h"
#import "BUMUserInfoForSegment.h"

@class BUAdSDKConfigurationMediation;

NS_ASSUME_NONNULL_BEGIN

@interface BUAdSDKConfiguration (Mediation)

/// 开启聚合维度功能，默认NO
/// @warning 1. 需配合导入CSJMediation.framework使用
///          2. 如过不使用聚合功能，可使用默认值或置为NO，减少聚合组件的初始化时间
///          3. 仅支持调用SDK初始化方法前设置，SDK初始化成功后不支持修改
@property (nonatomic, assign) BOOL useMediation;

/// 调用该接口，用于继续设置聚合维度相关属性
@property (nonatomic, strong, readonly) BUAdSDKConfigurationMediation *mediation;

@end



@interface BUAdSDKConfigurationMediation : NSObject

/// 配置用户分组信息，可随时更新，更新时请重新set新对象，但用户分组信息更新将触发配置重新加载，请谨慎使用
@property (nonatomic, strong, nullable) BUMUserInfoForSegment *userInfoForSegment;

/// 是否限制个性化广告: 0-不限制，1-限制，默认为0。官方维护版本中只适用于CSJ，Ks、Sigmob、BAIDU、GDT，Mintegral
@property (nonatomic, strong, nullable) NSNumber *limitPersonalAds;

/// 是否限制程序化广告: 0-不限制，1-限制，默认为0。官方维护版本中只适用于Ks
@property (nonatomic, strong, nullable) NSNumber *limitProgrammaticAds;

/// 是否禁止IDFA：0-不禁止，1-禁止，默认为0。官方维护版本中只适用于GDT，Sigmob，Mintegral。
@property (nonatomic, strong, nullable) NSNumber *forbiddenIDFA;

/// 设置预先从平台下载的SDKConfig文件路径，当首次安装网络请求SDKConfig失败时会使用，需在SDK初始化前设置
@property (nonatomic, copy, nullable) NSString *advanceSDKConfigPath;

/// 设置扩展设备信息，如不了解该功能，请勿使用。 如@"[{\"device_id\":\"62271333038\"}]"
@property (nonatomic, copy, nullable) NSDictionary *extraDeviceMap;

/// 已设定参数获取
@property (nonatomic, copy, nullable, readonly) NSDictionary *extraData;

/// 传递特定初始化参数
- (void)setExtraData:(nonnull id)data forKey:(nonnull NSString *)key;

/// 是否允许采集设备信息，用于个性化配置
@property (nonatomic, assign) BOOL allowUploadDeviceInfo;

@end

NS_ASSUME_NONNULL_END
