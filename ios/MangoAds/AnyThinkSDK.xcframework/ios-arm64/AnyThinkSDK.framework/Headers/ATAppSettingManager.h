//
//  ATAppSettingManager.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 09/04/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/ATAPI+Internal.h>
#import <AnyThinkSDK/ATModel.h>


NS_ASSUME_NONNULL_BEGIN
//The keyed value stores the flag as to whether or not clients are expected to upload the offer metadata
extern NSString *const kATAppSettingGDPAFlag;
extern NSString *const kATAppSettingGDPRPolicyURLKey;
extern NSString *const kATSDKCustomChannel;

extern NSString *const kATGeoLongitudeKey;
extern NSString *const kATGeoDimensionKey;

@class ATTrackingSetting;
@class ATADXSetting;
@class ATOnlineApiSetting;
@class ATPlacementModel;
@class ATSharePlacementSetting;
@class ATSharePlacementItem;

@interface ATAppSettingManager : NSObject

+(instancetype)sharedManager;

- (void)checkShareAdPlacementSetting;

- (void)setPropertyValue;

// v6460 扫描三方聚合SDK
- (void)startCheckAggSDK;

/**
 * The following setting accessing methods are thread-safe.
 */
- (BOOL)currentSettingExpired;
- (NSTimeInterval)splashTolerateTimeout;
- (BOOL)usesServerDataConsentSet;
- (BOOL)complyWithCOPPA;
- (BOOL)complyWithCCPA;
- (NSTimeInterval)psIDInterval;
- (NSTimeInterval)psIDIntervalForHotLaunch;
- (ATDataConsentSet)serverDataConsentSet;
- (ATDataConsentSet)commonTkDataConsentSet;
- (NSUInteger)myOfferMaxResourceLength;
- (NSArray *)preinitInfoArr;
- (NSDictionary *)userValueDQLWithPlacement:(ATPlacementModel *)placementId;

@property(nonatomic, strong) NSDictionary *currentSetting;

@property(nonatomic, readonly) NSDictionary *defaultSetting;

@property(nonatomic, readonly) ATTrackingSetting *trackingSetting;

@property(nonatomic, readonly) ATADXSetting *adxSetting;

@property(nonatomic, readonly) ATOnlineApiSetting *onlineApiSetting;

@property(nonatomic, readonly) NSString *ABTestID;

@property(nonatomic, readonly) NSString *s2sAddress;

@property(nonatomic, readonly) NSString *placementURLString;

@property(nonatomic, readonly) BOOL needToReportCrash;

@property(nonatomic, assign,getter=isAdmobMediationStatus) BOOL admobMediationStatus;

@property (nonatomic, strong) NSDictionary *appListDic;

@property(atomic,strong) ATSharePlacementSetting *sharePlacementSetting_impl;

/*
 *up id
 */
@property(nonatomic, readonly) NSString* ATID;
/**
 * sysid
 */
@property(nonatomic, readonly) NSString* SYSID;
/**
 * bkupid
 */
@property(nonatomic, readonly) NSString* BKUPID;
/// 是否允许adx原生自渲染提供图片宽高获取能力(sdk6.2.94) 1：允许，2：不允许，默认为2
@property (nonatomic, assign) BOOL isPermitAdGetImagWH;

@property(nonatomic, readonly) NSString *clickNotificationName;
@property(nonatomic, readonly) NSString *showNotificationName;
// 6.1.10
@property (nonatomic, strong) NSString *showDelayUrl;
@property (nonatomic, strong) NSString *showDelayText;

@property (nonatomic, readonly) NSDictionary *requestFailIntervalRuleDic;

@property (nonatomic, strong) NSDictionary *appSettingABDic;

@property (nonatomic, strong) NSDictionary *cachedDic;
@property (nonatomic, strong) NSDictionary *updateCachedDic;

@property (nonatomic, strong) NSArray *guidedClickFodderArray;
@property (nonatomic, strong) NSArray *redPacketFodderArray;
@property (nonatomic, strong) NSArray *cardFodderArray;
// v6435 是否给当前广告平台回传完整的竞价信息 空或不下发代表：关闭授权 在这个里面的算是授权
@property (nonatomic, strong) NSArray *bidIsw;

@property (nonatomic, strong) NSArray <UIImage *>*cardImageFodderArray;

@property (nonatomic, assign) BOOL isLimitFrequentRequest;
@property (nonatomic, assign) BOOL sensSwitch;

@property (nonatomic, strong) NSArray *allAnimationFodderArray;
/// cap info Dic
@property (nonatomic, strong) NSDictionary *capInfoDic;
/// 是否禁用adx持久化广告存储和读取
@property (nonatomic, assign) BOOL adxLocalCacheDisableSwitch;

/// v6460
/// 风险标签
@property (nonatomic, strong) NSString *riskTag;
/// 防刷数据共享开关
@property (nonatomic, assign) BOOL fdSSwitch;

- (NSString *)wxAppOpenid;
- (NSString *)wxOpenUniversallink;

/* v6430 */
// 素材监测TK上报开关
@property (nonatomic, assign) BOOL material_tk_sw;
// 智能瀑布流地址
@property (nonatomic, copy) NSString *smartWFUrl;
/* v6430 */

//+(NSDictionary*)parameters;

- (nullable NSArray *)cardImageFodder;
@end



@interface ATTrackingSetting:ATModel
+(instancetype) defaultSetting;
@property(nonatomic, readonly) NSString *trackerAddress;
@property(nonatomic, readonly) NSInteger trackerNumberThreadhold;
@property(nonatomic, readonly) NSTimeInterval trackerInterval;
@property(nonatomic, readonly) BOOL sendsDataEveryInterval;
@property(nonatomic, readonly) NSString *agentEventAddress;
@property(nonatomic, readonly) NSInteger agentEventNumberThreadhold;
@property(nonatomic, readonly) NSTimeInterval agentEventInterval;
@property(nonatomic, readonly) NSArray<NSString*>* agentEventDropNetworks;
@property(nonatomic, readonly) NSDictionary<NSString*, NSArray<NSString*>*>* agentEventDropFormats;
@property(nonatomic, readonly) NSDictionary<NSString*, NSArray<NSString*>*>* agentEventRTFormats;

@property(nonatomic, readonly) NSDictionary<NSString*, NSDictionary*>* trackRealTimeFormatDic;
@property(nonatomic, readonly) NSDictionary<NSString*, NSDictionary*>* agentRealTimeFormatDic;



/*
 *for batch upload
 */
@property(nonatomic, readonly) NSInteger agentEventBatNumberThreadhold;
@property(nonatomic, readonly) NSInteger agentEventBatInterval;


//TCP
@property(nonatomic, readonly) NSString *trackerTCPAddress;
@property(nonatomic, readonly) NSInteger trackerTCPPort;
@property(nonatomic, readonly) NSInteger trackerTCPType;
@property(nonatomic, readonly) NSString *trackerTCPRate;

//TC
@property(nonatomic, readonly) NSArray<NSString*>* tcHosts;
@property(nonatomic, readonly) NSDictionary<NSString*, NSArray<NSString*>*>* tcTKSkipFormats;
@property(nonatomic, readonly) NSArray<NSString*>* tcTKSkipNetworks;



@end

@interface ATADXSetting:ATModel
+(instancetype) defaultSetting;
@property(nonatomic, readonly) NSString *reqHttpAddress;
@property(nonatomic, readonly) NSString *reqTCPAdress;

@property(nonatomic, readonly) NSInteger reqTCPPort;
@property(nonatomic, readonly) NSInteger reqNetType;

@property(nonatomic, readonly) NSString *bidHttpAddress;
@property(nonatomic, readonly) NSString *bidTCPAdress;
@property(nonatomic, readonly) NSInteger bidTCPPort;
@property(nonatomic, readonly) NSInteger bidNetType;

@property(nonatomic, readonly) NSString *trackerHttpAdress;
@property(nonatomic, readonly) NSString *trackerTCPAdress;
@property(nonatomic, readonly) NSInteger trackerTCPPort;
@property(nonatomic, readonly) NSInteger trackerNetType;

@end

@interface ATOnlineApiSetting:ATModel
+(instancetype) defaultSetting;
@property(nonatomic, readonly) NSString *reqHttpAddress;

@property(nonatomic, readonly) NSString *reqTCPAdress;
@property(nonatomic, readonly) NSInteger reqTCPPort;
@property(nonatomic, readonly) NSInteger reqNetType;

@property(nonatomic, readonly) NSString *trackerHttpAdress;
@property(nonatomic, readonly) NSString *trackerTCPAdress;
@property(nonatomic, readonly) NSInteger trackerTCPPort;
@property(nonatomic, readonly) NSInteger trackerNetType;

@end

#pragma mark - ATSharePlacementSetting
@interface ATSharePlacementItem : ATModel
/// 共享广告位 聚合渠道
@property (nonatomic, strong) NSString *shareAdChannelSource;
@property (nonatomic, strong) NSString *placementId;
@property (nonatomic, assign) ATAdFormat format;
@property (nonatomic, assign) NSTimeInterval timingLoadInterval;
@property (nonatomic, assign) NSInteger cacheNumberThreshold;
@property (nonatomic, strong) NSString *ecpmThreshold;

@end

#pragma mark - ATSharePlacementSetting

typedef NS_ENUM(NSUInteger, ATSharePlacementSettingPreLoadType) {
    ATSharePlacementSettingPreLoadTypeStart = 1,
    ATSharePlacementSettingPreLoadTypeBinding,
};

@interface ATSharePlacementSetting : ATModel
+ (instancetype)defaultSetting;
@property (nonatomic, assign) NSTimeInterval loadInterval;
@property (nonatomic, assign) NSInteger loadNubmer;
@property (nonatomic, assign) NSTimeInterval shortTimeOutInterval;

@property (nonatomic, strong) NSMutableDictionary<NSString *, ATSharePlacementItem *> *itemDict;
@property (nonatomic, strong) NSMutableArray<ATSharePlacementItem *> *sharePlacementList;

@property (nonatomic, assign) ATSharePlacementSettingPreLoadType preLoadType;

@end
NS_ASSUME_NONNULL_END
