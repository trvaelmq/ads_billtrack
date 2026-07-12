//
//  SMDeviceTool.h
//  SigmobDemo
//
//  Created by happyelements on 2018/3/27.
//  Copyright © 2018年 Codi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SMDeviceTool : NSObject

+ (instancetype)sharedInstance;
//app的方向
@property (nonatomic,strong, readonly) NSNumber *orientation;
//app版本号
@property (nonatomic, strong, readonly) NSString *appVerion;
//app name
@property (nonatomic, strong, readonly) NSString *appname;
//电池电量
@property (nonatomic, assign, readonly) CGFloat batteryLevel;
//电池状态
@property (nonatomic, assign, readonly) uint32_t batteryState;
//获取时区
@property (nonatomic, strong, readonly) NSString *timeZone;
@property (nonatomic, strong, readonly) NSString *secondsFromGMT;
/**ua*/
@property (nonatomic, copy, readonly) NSString *userAgent;
/**位置信息*/
@property (nonatomic,assign, readonly) float lat;
@property (nonatomic,assign, readonly) float lon;
@property (nonatomic,assign, readonly) BOOL hasLocation;
//当前系统版本号
@property (nonatomic, strong, readonly) NSString *systemVersion;
//device_model
@property (nonatomic, strong, readonly) NSString *device_model;
@property (nonatomic, strong, readonly) NSString *device_name;
//广告位标识符idfa
@property (nonatomic, strong, readonly) NSString *idfa;
@property (nonatomic, assign, readonly) BOOL isCustomIdfa;
//广告位标识符idfv
@property (nonatomic, strong, readonly) NSString *idfv;
@property (nonatomic, strong, readonly) NSString *bundleID;
@property (nonatomic, strong, readonly) NSString *internalName;
@property (nonatomic, strong, readonly) NSNumber *dpi;
@property (nonatomic, strong, readonly) NSString *locale;
@property (nonatomic,assign, readonly) BOOL isJailBreak;
@property (nonatomic,assign, readonly) BOOL battery_saver_state;
@property (nonatomic, assign, readonly) CGFloat screen_width;//pixeis
@property (nonatomic, assign, readonly) CGFloat screen_height;//pixeis
/**运营商*/
@property (nonatomic,strong, readonly) NSString *carrier;
@property (nonatomic,strong, readonly) NSString *carrierName;
/**国家代码*/
@property (nonatomic, strong, readonly) NSString *countryCode;
/**语言*/
@property (nonatomic, strong, readonly) NSString *languageCode;
/// 客服端自己生成的udid
@property (nonatomic,strong, readonly) NSString *udid;
/// 后端生成的uid
@property (nonatomic,strong, readonly) NSString *uid;
/// 系统的更新时间
@property (nonatomic, strong, readonly) NSString *systemUpdateTime;
/// 系统的开机时间
@property (nonatomic, assign, readonly) int64_t uptime;
//adx使用
@property (nonatomic, strong, readonly) NSString *bootMark;
@property (nonatomic, strong, readonly) NSString *updateMark;

/// mntId
@property (nonatomic, strong, readonly) NSString *mntId;
/// 设备初始化时间
@property (nonatomic, strong, readonly) NSString *fileInitTime;



#pragma mark - Disk Space
///=============================================================================
/// @name Disk Space
///=============================================================================
// 系统总内存空间
@property (nonatomic, assign, readonly) int64_t totalDiskSpack;

@property (nonatomic, assign, readonly) int64_t freeDiskSpack;

@property (nonatomic, assign, readonly) int64_t totalMemory;


#pragma mark - Network Information
///=============================================================================
/// @name Network Information
///=============================================================================
- (UIWindow *)getKeyWindow;
/** 获取设备支持的方向 */
- (UIInterfaceOrientationMask)supportOrientationMask;
- (NSString *)getDcSessionId;
//每次会生成一个unique id
- (NSString *)getUniqueId;
/**获取设备类型(1:iphone;2:ipad;3:ipod;0:未知)*/
-(uint32_t)getDeviceType;
-(NSUInteger) getWindSeqId;
- (NSUInteger)getSigSeqId;
/**获取网络状态(100:wifi;2:2g;3:3g;4:4g;0:未知)*/
-(uint32_t)getNetStatus;
- (BOOL)hasAlwaysKey;
- (BOOL)hasWhenInUseKey;
/**获取系统当前时间戳(s)*/
- (long)getCurrentTimestamp;
/**获取系统当前时间戳(ms)*/
- (long long)currentTimeMillis;
/* 判断是否是iphone x系列的手机 */
- (BOOL)isIPhoneXSeries;
- (BOOL)isHTTPEnable;
- (void)updateUid:(NSString *)uid;
- (NSMutableArray<NSString*> *)getSKAdNetworkIdsArray;
- (BOOL)isAdvertisingTrackingEnabled;
- (NSUInteger)trackingAuthorizationStatus;
- (CGRect)getForecastBounds:(NSUInteger)forecastOri;
@end
