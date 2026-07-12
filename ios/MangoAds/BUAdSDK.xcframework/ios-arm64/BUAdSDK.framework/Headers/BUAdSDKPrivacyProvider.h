//
//  BUAdSDKPrivacyProvider.h
//  Pods
//
//  Created by ByteDance on 12/11/24.
//

/// Provide a protocol for custom private data
/// Only valid in the CN environment
@protocol BUAdSDKPrivacyProvider <NSObject>

@optional

/// Specify whether to allow the SDK to use location data
/// @Note :  聚合广告维度下，生效的adn为：CSJ，KS，Sigmob
- (BOOL)canUseLocation;
/// Return a latitude value
/// @Note :  聚合广告维度下，生效的adn为：CSJ，GDT，KS，Sigmob
- (CLLocationDegrees)latitude;
/// Return a longitude value
/// @Note :  聚合广告维度下，生效的adn为：CSJ，GDT，KS，Sigmob
- (CLLocationDegrees)longitude;
/// Specify whether to allow the SDK to use WiFi BSSID. Defaults to YES if the protocol method is not implemented.
- (BOOL)canUseWiFiBSSID;
/// Configure privacy information
///  @"motion_info" -> 表示是否允许传感器采集数据 ，
///                value为NSString类型，@"0": 不允许，@"1": 允许，默认不传时允许采集，其他值或不实现该协议方法认为允许采集，
///                聚合维度下生效的adn为：CSJ，GDT，BAIDU，Sigmob。
///
/// @Note :  聚合广告维度下，可设置如下key
///        @"bum_advertiser_tracking_enabled" -> 用户对广告商跟踪的同意 ，
///                                      value为NSString类型，@"1"代表同意，@"0"代表不同意，默认@"0"，
///                                      生效的adn为：GDT。
///        @"bum_loc_time" -> 实时的地理位置获取时间，值为字符串格式的unix时间戳，单位秒，比如@"1639450944"，
///                       value为NSString类型，默认nil，
///                       生效的adn为：GDT。
///        @"bum_limit_personal_cpus"  -> 限制个性化CPU，
///                                value为NSString类型，@"1"代表限制，@"0"代表不限制，默认@"0"，
///                                生效的adn为：BAIDU。
///        @"bum_disable_use_phone_status"  -> 禁用使用电话状态，
///                                     value为NSString类型，@"1"代表禁用，@"0"代表不禁用，默认@"0"，
///                                     生效的adn为：KS。
///        @"bum_custom_idfv"  -> 设置自定义idfv，
///                           value为NSString类型，默认nil。
///                           生效的adn为：KS，Mintegral，Sigmob。
///        @"bum_forbidden_idfv"  -> 是否禁止IDFV，
///                            value为NSString类型，@"1"代表禁用，@"0"代表不禁用，默认@"0"，
///                            生效的adn为：Mintegral，Sigmob。
- (nullable NSDictionary *)privacyConfig;
@end
