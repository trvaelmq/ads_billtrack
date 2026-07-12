//
//  MSConfig.h
//  MSAdSDK
//
//  Created by zzq on 2020/3/11.
//  Copyright © 2020 yang. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MSAdSensorConfigSetting : NSObject
//美数广告交互（摇一摇/扭一扭）开关 默认开启 全局生效 YES：代表开启 NO：代表关闭
@property(nonatomic,assign)BOOL msShakableSwitch;
//美数传感器开关 全局生效 默认开启 如禁用传感器功能，则广告交互（摇一摇/扭一扭）也失效 YES：代表开启 NO：代表关闭
@property(nonatomic,assign)BOOL msSensorSwitch;
//广点通广告交互（摇一摇/扭一扭）开关 默认开启 全局生效 YES：代表开启 NO：代表关闭
@property(nonatomic,assign)BOOL gdtShakableSwitch;
//广点通传感器开关 全局生效 YES：代表开启 NO：代表关闭
@property(nonatomic,assign)BOOL gdtSensorSwitch;
//百度广告交互（摇一摇/扭一扭）开关 默认开启 全局生效 YES：代表开启 NO：代表关闭
@property(nonatomic,assign)BOOL bdShakableSwitch;
//ks广告交互（摇一摇）开关 默认开启 仅开屏生效⚠️⚠️⚠️ YES：代表开启 NO：代表关闭
@property(nonatomic,assign)BOOL ksShakableSwitch;
//ks广告交互（扭一扭）开关 默认开启 仅开屏生效⚠️⚠️⚠️ YES：代表开启 NO：代表关闭
@property(nonatomic,assign)BOOL ksRotatableSwitch;
//ks广告交互（手势滑动）开关 默认开启 仅开屏生效⚠️⚠️⚠️ YES：代表开启 NO：代表关闭
@property(nonatomic,assign)BOOL ksSlidableSwitch;
@end

@interface MSConfig : NSObject
/**
  是否使用聚合功能（默认开启聚合功能）
  注意⚠️
 1、设置时机：sdk初始化block中调用
 2、务必优先设置setUseMediation开关
 示例
 [MSAdSDK startSDKWithAppid:appid configBlock:^{
     [MSConfig setUseMediation:self.model.sdkMediationSwitch];//务必优先设置setUseMediation开关
     [MSAdSDK setLogLevel:MSLogNone];
     [MSConfig setSdkPermissionEnable:YES];
 }];
 */
+ (void)setUseMediation:(BOOL)useMediation;
/**
 获取聚合功能开关（默认开启）
 */
+ (BOOL)canUseMediation;
/**
 性别:(-1:未知、男:01、女:10)
 */
+ (void)setGender:(MSGender)gender;
+ (MSGender)getGender;
+ (NSString*)genderStr;
/**
 4 位数字出生年
 */
+ (void)setYob:(NSString *)yob;
+ (NSString *)getYob;
/**
 用户感兴趣关键词多个用英文逗号隔(Get 请求需做 urlencode)
 */
+ (void)setKeywords:(NSString *)keywords;
+ (NSString *)getKeywords;
+ (NSArray <NSString*>*)getKeywordArray;
// 备用字段 示例：[MSConfig setExt:@"{\"features\":[{\"key\":\"key名称\",\"value\":[value1,value2]}]}"];
+ (void)setExt:(NSString *)ext;
+ (NSString *)getExt;
+ (void)setAder_ids:(NSArray<NSString *> *)ader_ids;
+ (NSArray<NSString *> *)getAder_ids;
/**
 屏蔽策略注意事项⚠️
 1、以下参数为全局参数，一经设置，所有广告类型都将生效（仅屏蔽MS平台下广告），当再次设置，上一次设置将会失效。
 2、如需取消屏蔽策略，将参数传入nil即可生效
 3、如需上次设置生效可将上次传入的ID置于当前集合中传入
 4、务必在加载广告前传入
 */
//设置禁止投放行业ID
+ (void)setDenyCats:(NSArray<NSString *> *)denyCats;
//设置禁止投放创意ID
+ (void)setDenyCids:(NSArray<NSString *> *)cids;
//设置禁止投放广告主ID
+ (void)setDenyAderIds:(NSArray<NSString *> *)ids;
/**
 是否开启设备新标志能力（默认开启 Yes：开启   NO：不开启）
 注意⚠️设置时机：sdk初始化block中调用
 */
+ (void)setSdkPermissionEnable:(BOOL)enable;
/**
 获取sdk是否已开启设备新标志能力
 Yes：已开启   NO：未开启
 */
+ (BOOL)getSdkPermissionEnable;
/**
 是否开启个性化推荐（默认开启推荐 Yes：推荐 NO：不推荐）
 注意⚠️：请在设置appid（setAppId:(NSString *)appId;）后调用
 */
+ (void)setEnablePersonalRecommend:(BOOL)isRecommend;
/**
 是否展示广告品牌及广告标识 默认YES
 注意⚠️：此参数一经设置，全局生效即所有广告类型都将被设置(可能存在第三方广告设置无效的情况)
 */
+(void)setIsShowLogo:(BOOL)isShowLogo;
/**
 展示视频广告时设置音频category。
 注意：此设置为全局有效，媒体可按实际需求进行设置
 AVAudioSessionCategoryAmbient          //支持多个声源同时播放（锁屏/静音模式会静音）。
 AVAudioSessionCategorySoloAmbient      //仅支持当前声音播放（锁屏/静音模式会静音）。
 AVAudioSessionCategoryPlayback         //锁屏后依然支持播放声音
 AVAudioSessionCategoryRecord           //仅录制且需要声音中断场景使用。
 AVAudioSessionCategoryPlayAndRecord    //播放且录制场景使用。
 AVAudioSessionCategoryMultiRoute       //支持多个设备输入输出。
 AVAudioSessionCategoryAudioProcessing  //用于音频格式处理。
 */
+ (void)setAudioSessionCategory:(AVAudioSessionCategory)category;
/**
 禁用IDFA 默认 NO
 注意⚠️：禁用IDFA后会影响广告收益
 仅ms、百度、京东、广点通、快手支持设置
 设置时机：加载广告前
 */
+ (void)forbiddenIDFA:(BOOL)forbiddened;
/**
 媒体自定义idfa
 仅ms、csj平台、快手、京东支持设置
 设置时机：加载广告前
 */
+ (void)setCustomIDFA:(NSString *)idfa;
/**
 媒体自定义广告参数
 设置时机：sdk初始化时
 注意⚠️：
 adDict 添加参数规则
 如媒体通过其他方式获取ad参数，该接口会返回两个新老版本的ad，媒体传入时务必传入两个ad，返回结构如下：
 // ad算法升级期间会同时下发新老版本，用版本号来区分,
 [
     {
     "version" : "20211207",
     "ad"."f1e86165032663ad1ad22095916846"
     },
     {
     "version":"20220111",
     "ad"."2aec028e5020e955c39473ce422a195"
     }
 ]
 已支持key：
 @"oldADValue" ：老ad值
 @"oldADVersion": 老ad版本
 @"newADValue"：新ad值
 @"newADVersion" 新ad版本
 示例：adDict = @{
                @"oldADValue":@"f1e86165032663ad1ad22095916846",
                @"oldADVersion":@"20211207",
                @"newADValue":@"2aec028e5020e955c39473ce422a195",
                @"newADVersion":@"20220111"
               }
 
 */
+ (void)setCustomAdParams:(NSDictionary<NSString *,NSString *> *)adDict;
/**
 是否开启定位权限 默认开启（如媒体默认开启该权限，不必再调用该权限接口）
 注意：
 1、仅支持ms、京东、快手、穿山甲、百度该设置
 2、如果关闭定位功能后，不传入经纬度，则默认为0处理，可能会影响三方投放广告策略，请谨慎设置该权限
 注意⚠️设置时机：sdk初始化block中调用
 */
+ (void)canUseLocation:(BOOL)isOpen;
/**
 自定义经纬度 （如媒体默认使用sdk内部经纬度，不必再调用该接口）
 注意：仅支持ms、京东、快手、穿山甲、广点通该设置
 */
+ (void)setUpLatitude:(CLLocationDegrees)latitude Longitude:(CLLocationDegrees)longitude;
/**
 是否获取ip地址 默认开启 （如媒体默认开启该权限，不必再调用该权限接口）
 注意：仅支持ms、京东该设置
 */
+ (void)canUseIPAddress:(BOOL)isCanUseIP;
/**
 是否使用穿山甲聚合统计功能 默认不开启
 注意：
 开启该功能前，请媒体查看穿山甲SDK文档以便更全面了解该功能
 */
+ (void)canUseCSJPrimeRit:(BOOL)isPrimeRit;
/**
 *注意：如果媒体自定义userAgent且全局生效时，务必传入系统默认的userAgent，否则影响广告投放效果
 * 设置UserAgent 设置一次即可
 * 设置时机：初始化sdk前传入
 */
+ (void)setDefaultUserAgent:(NSString *)userAgent;
/**
 * 接口说明：传感器相关配置 （禁用传感器、 广告交互（摇一摇/扭一扭））
 * 默认开启
 * 设置时机：sdk初始化block中调用
 */
+ (void)configAdSensorFunction:(void(^)(MSAdSensorConfigSetting *config))configBlock;
@end
