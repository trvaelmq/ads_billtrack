//
//  BUMPrivacyConfig.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import <Foundation/Foundation.h>

/// 【可选】NSNumber，是否限制个性化广告:
/// 0-不限制，1-限制，默认为0。
/// 官方维护版本中只适用于CSJ、KS、Sigmob、BAIDU、GDT，Mintegral。
const static NSString *kBUMPrivacyLimitPersonalAds = @"ABUPrivacyLimitPersonalAds";

/// 【可选】NSNumber，是否限制程序化广告:
/// 0-不限制，1-限制，默认为0。
/// 官方维护版本中只适用于KS。
const static NSString *kBUMPrivacyLimitProgrammaticAds = @"ABUPrivacyLimitProgrammaticAds";

/// 【可选】NSNumber，是否禁止IDFA：
/// 0-不禁止，1-禁止，默认为0。
/// 官方维护版本中只适用于GDT，Sigmob，Mintegral。
const static NSString *kBUMPrivacyForbiddenIDFA = @"ABUPrivacyForbiddenIDFA";

/// 【可选】NSNumber，是否在adn中使用位置，如果是，adn将自己获得纬度和经度，而不是使用传入的值（kBUMPrivacyLongitude/kBUMPrivacyLatitude）。
/// 官方维护版本中只适用于CSJ，KS。
const static NSString *kBUMPrivacyCanLocation = @"ABUPrivacyCanLocation";

/// 【可选】NSNumber，经度的值。
/// 默认值是0.0。
/// 官方维护版本中只适用于CSJ，GDT，KS。
const static NSString *kBUMPrivacyLongitude = @"ABUPrivacyLongitude";

/// 【可选】NSNumber，纬度的值。
/// 默认值是0.0。
/// 官方维护版本中只适用于CSJ，GDT，KS。
const static NSString *kBUMPrivacyLatitude = @"ABUPrivacyLatitude";

/// 【可选】NSNumber，是成人或者儿童，
/// 2-儿童(＜15),1-儿童(15-18岁), 0-成人，默认为0(成人)。
/// 官方维护版本中适用于CSJ，sigmob。
const static NSString *kBUMPrivacyNotAdult = @"ABUPrivacyNotAdult";

/// 【可选】NSString，用户对广告商跟踪的同意，
/// @"0"-不同意，@"1"-同意，默认@"0"。
/// 官方维护版本中适用于GDT。
const static NSString *kBUMPrivacyAdvertiserTrackingEnabled = @"bum_advertiser_tracking_enabled";

/// 【可选】NSString，实时的地理位置获取时间，
/// 值为字符串格式的unix时间戳，单位秒，比如@"1639450944"，默认nil代表未设置过。
/// 官方维护版本中适用于GDT。
const static NSString *kBUMPrivacyLocTime = @"bum_loc_time";

/// 【可选】NSString，表示是否允许传感器采集数据，
/// @"0": 不允许，@"1": 允许，默认@"1"。
/// 官方维护版本中只适用于CSJ，GDT，BAIDU。
const static NSString *kBUMPrivacyMotionInfo = @"motion_info";

/// 【可选】NSString，表示是否限制个性化CPU，
/// @"0": 不限制，@"1":  限制，默认@"0"。
/// 官方维护版本中只适用于BAIDU。
const static NSString *kBUMPrivacyLimitPersonalCPUs = @"bum_limit_personal_cpus";

/// 【可选】NSString，表示是否禁用使用电话状态，
/// @"0": 不禁用，@"1":  禁用，默认@"0"。
/// 官方维护版本中只适用于KS。
const static NSString *kBUMPrivacyDisableUsePhoneStatus = @"bum_disable_use_phone_status";

/// 【可选】NSString，是否禁止IDFV：
/// 0-不禁止，1-禁止，默认为0。
/// 官方维护版本中只适用于Mintegral。
const static NSString *kBUMPrivacyForbiddenIDFV = @"bum_forbidden_idfv";

/// 【可选】NSString，自定义IDFV：
/// 默认nil代表未设置过。
/// 官方维护版本中只适用于KS，Mintegral。
const static NSString *kBUMPrivacyCustomIDFV = @"bum_custom_idfv";
