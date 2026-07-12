//
//  ATPlacementModel.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 11/04/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <AnyThinkSDK/ATModel.h>
#import <AnyThinkSDK/ATUnitGroupModel.h>
#import <AnyThinkSDK/ATMyOfferOfferModel.h>
#import <AnyThinkSDK/ATMyOfferSetting.h>
#import <AnyThinkSDK/ATADXPlacementSetting.h>
#import <UIKit/UIKit.h>

#import <AnyThinkSDK/ATStorage.h>
#import <AnyThinkSDK/ATModelProtocol.h>
#import <AnyThinkSDK/ATDynamicWaterfallParams.h>
#import <AnyThinkSDK/ATPlatfromInfo.h>
#import <AnyThinkSDK/ATPlacementModelExtra.h>

#import <AnyThinkSDK/ATEcwfModel.h>
#import <AnyThinkSDK/ATAdsLgStModel.h>

typedef NS_ENUM(NSInteger, ATADShowType) {
    /**
     * priority -> show times -> added time
     */
    ATADShowTypePriority = 0,
    /**
     * show times -> priority -> added time
     */
    ATADShowTypeSerial = 1
};

typedef enum : NSUInteger {
    ATLoadingRequestConcurrentFixedType = 1,
    ATLoadingRequestConcurrentEqualPriceType = 2,
} ATLoadingRequestModelType;

typedef NS_ENUM(NSInteger, ATNativeMixBannerStyleType) {
    ATNativeMixBannerStyleTypeToponOne = 1,
};

/// 广告请求类型
typedef NS_ENUM(NSInteger, ATLoadingAdApiType) {
    ATLoadingAdApiTypeDefault = 0, // 默认
    ATLoadingAdApiTypeRefresh = 1, // 刷新
    ATLoadingAdApiTypePlayAgain = 2, 
    ATLoadingAdApiTypeAutoLoadInitiation = 3,// 自动请求: 初始化或创建广告对象
    ATLoadingAdApiTypeAutoLoadLoadFailed = 4, // 自动请求: 加载失败
    ATLoadingAdApiTypeAutoLoadNotReady  = 5,// 自动请求: isReady 为false
    ATLoadingAdApiTypeAutoLoadShowStart = 6,// 自动请求: 开始展示
    ATLoadingAdApiTypeAutoLoadShowFailed = 7,// 自动请求: 展示失败
    ATLoadingAdApiTypeFailedRetry = 8,// 非全自动加载模式: 加载失败自动请求
    ATLoadingAdApiTypeSerialMultiCachMode  = 9,// 串行多缓存
    ATLoadingAdApiTypeSharedPlacementPreload    = 10,// 共享广告位: 启动预加载
    ATLoadingAdApiTypeSharedPlacementTimer     = 11,//共享广告位: 定时任务请求
    // 共享广告位:：绑定了共享池的广告位在生命周期内首次回调Load结果后执行相同广告类型共享池的预加载
    ATLoadingAdApiTypeSharedPlacementSameFormatLoad     = 12,
    ATLoadingAdApiTypePresetCool    = 13,// 使用SDK内置策略执行WF后，额外增加使用线上冷启动策略发起请求
    ATLoadingAdApiTypePresetNormal  = 14,// 使用SDK内置策略执行WF后，额外增加使用线上非冷启动策略发起请求
};

typedef NS_ENUM(NSInteger, ATCallSuccessType) {
    ATCallSuccessShowPriorityType = 1,
    ATCallSuccessPricePriorityType = 2,
};
extern NSString *const kATPlacementModelCacheDateKey;
extern NSString *const kATPlacementModelCustomDataKey;

typedef NS_ENUM(NSUInteger, ATPlacementModelUserValueTimingType) {
    ATPlacementModelUserValueTimingTypeNone = 0,
    ATPlacementModelUserValueTimingTypeShow = 1,
};

typedef NS_ENUM(NSUInteger, ATPlacementModelUserValueStrategyIndexType) {
    ATPlacementModelUserValueStrategyIndexTypeLocal = 0,
    ATPlacementModelUserValueStrategyIndexTypeShowPrice = 1,
};

typedef NS_ENUM(NSUInteger, ATPlacementModelWaterfallModeType) {
    ATPlacementModelWaterfallModeTypeSerialMultiCach = 1,
    ATPlacementModelWaterfallModeTypeNormal = 2,
};


typedef NS_ENUM(NSUInteger, ATBannerAutoRefreshType) {
    ATBannerAutoRefreshTypePlacementStrategy = 1,
    ATBannerAutoRefreshTypeAdSourceStrategy = 2,
};

typedef NS_ENUM(NSInteger, ATPlacementModelBaiduReportType) {
    ATPlacementModelBaiduReportTypeUnKonw = 0,
    ATPlacementModelBaiduReportTypeNormalWin = 1 << 0,
    ATPlacementModelBaiduReportTypeNormalLoss = 1 << 1,
    ATPlacementModelBaiduReportTypeBiddingWin = 1 << 2,
    ATPlacementModelBaiduReportTypeBiddingLoss = 1 << 3,

};

typedef NS_ENUM(NSUInteger, ATPlacementSettingType) {
    ATPlacementSettingTypeNormal,
    ATPlacementSettingTypePreset,
    ATPlacementSettingTypeCool,
};

typedef NS_ENUM(NSInteger, ATPlacementModelAutoLoadType) {
    ATPlacementModelAutoLoadTypeUnKonw = 0,
    ATPlacementModelAutoLoadTypeLoadFailed = 1 << 0,
    ATPlacementModelAutoLoadTypeIsReadyFalse = 1 << 1,
    ATPlacementModelAutoLoadTypeShow = 1 << 2,
    ATPlacementModelAutoLoadTypeShowFailed = 1 << 3,

};

#pragma mark - ATPlacementModel
@interface ATPlacementModel : ATModel <ATModelProtocol, ATStorageEntityProtocol>

-(instancetype) initWithDictionary:(NSDictionary *)dictionary associatedCustomData:(NSDictionary*)customData placementID:(NSString*)placementID;
-(instancetype) initWithDictionary:(NSDictionary *)dictionary placementID:(NSString*)placementID;

@property (nonatomic, strong) NSDictionary *originalPlacementDic;
@property (nonatomic, strong) NSDictionary *cachedDic;
@property (nonatomic, strong) NSDictionary *updateCachedDic;

@property (nonatomic, assign) ATCallSuccessType callSuccessType;

@property(nonatomic, readonly) NSDictionary *associatedCustomData;
@property(nonatomic, readonly) BOOL cachesPlacementSetting;
@property(nonatomic, readonly) ATAdFormat format;
/// ad名称: 比如:(native,splash......)
@property(nonatomic, strong) NSString *formatNameString;
/// ad 枚举字符串: 比如: @"1"
@property(nonatomic, strong) NSString *formatString;

@property(nonatomic, readonly) NSString *placementID;
@property(nonatomic, readonly) BOOL adDeliverySwitch;
@property(nonatomic, readonly) NSInteger groupID;
/**
 Auto refresh is for banner.
 */
@property(nonatomic, readonly) BOOL autoRefresh;
@property(nonatomic, readonly) NSTimeInterval autoRefreshInterval;
@property (nonatomic, assign) ATBannerAutoRefreshType bannerAutoRefreshType;
/**
 * How many unit groups to be loaded concurrently
 */

@property(nonatomic, readonly) ATLoadingRequestModelType loadingRequestModelType;
@property(nonatomic, readonly) NSInteger fixedMaxConcurrentRequestCount;
@property(nonatomic, readonly) NSInteger equalPriceMaxConcurrentRequestCount;

@property(nonatomic, readonly) NSString *psID;
@property(nonatomic, readonly) NSString *sessionID;
@property(nonatomic, readonly) ATADShowType showType;
/**
 Max showing times allowed in a day with -1 meaning no limitation
 */
@property(nonatomic, readonly) NSInteger unitCapsByDay;
/**
 Max showing times allowed in a hour with -1 meaning no limitation
 */
@property(nonatomic, readonly) NSInteger unitCapsByHour;
@property(nonatomic, readonly) NSTimeInterval unitPacing;
@property(nonatomic, readonly) BOOL wifiAutoSwitch;
@property(nonatomic, readonly) BOOL autoloadingEnabled;
@property(atomic, readonly) NSArray<ATUnitGroupModel*>* allUnitGroups;
@property(atomic, readonly) NSArray<ATUnitGroupModel*>* unitGroups;
@property(atomic, readonly) NSArray<ATUnitGroupModel*>* headerBiddingUnitGroups;
@property(atomic, readonly) NSArray<ATUnitGroupModel*>* S2SHeaderBiddingUnitGroups;
@property(atomic, readonly) NSArray<ATUnitGroupModel*>* olApiUnitGroups;
@property(atomic, readonly) NSArray<ATUnitGroupModel*>* inhouseUnitGroups;
@property(atomic, readonly) NSArray<ATUnitGroupModel*>* bksUnitGroups;
@property(atomic, readonly) NSArray<ATUnitGroupModel*>* bottomListUnitGroups;
@property(atomic, readonly) NSArray<ATUnitGroupModel*>* directOfferHeaderBiddingUnitGroups;
@property(nonatomic, readonly) NSArray<ATUnitGroupModel*>* adxUnitGroups;
@property(nonatomic, readonly) NSArray<ATUnitGroupModel*>* adxOpenUnitGroups;

@property(nonatomic, readonly) NSArray<ATUnitGroupModel*>* dynamicHeaderBiddingUnitGroups;
/// 动态出价客户端竞价广告源列表
@property(nonatomic, readonly) NSArray<ATUnitGroupModel*>* dynamicBiddingC2SUnitGroups;
/// 动态出价服务端竞价广告源列表
@property(nonatomic, readonly) NSArray<ATUnitGroupModel*>* dynamicBiddingS2SUnitGroups;

@property(nonatomic, readonly) NSDictionary *dynamicHBAdUnitIds;

@property(nonatomic, readonly) NSTimeInterval bottomRreqts;     // bottomAd dalay request time

@property(nonatomic, readonly) NSTimeInterval headerBiddingRequestLongTimeout;

@property(nonatomic, readonly) NSTimeInterval headerBiddingRequestShortTimeout;

@property(nonatomic, readonly) NSString *S2SBidRequestAddress;
@property(nonatomic, readonly) NSString *waterFallBidRequestAddress;

@property(nonatomic, readonly) NSTimeInterval loadCapDuration;
@property(nonatomic, readonly) NSInteger loadCap;

@property(nonatomic, readonly) NSInteger expectedNumberOfOffers;


@property(nonatomic, readonly) NSTimeInterval bidWaitTimeout;
@property(nonatomic, readonly) NSTimeInterval reqWaitTimeout;

@property(nonatomic, readonly) NSTimeInterval loadFailureInterval;
@property(nonatomic, readonly) NSTimeInterval offerLoadingTimeout;
@property(nonatomic, readonly) NSTimeInterval statusValidDuration;//Upstatus
@property(atomic, strong) NSString *asid;//generated by server side
@property(nonatomic, readonly) NSString *trafficGroupID;

@property(nonatomic, readonly) ATPlacementModelExtra *extra;

@property(nonatomic, readonly) NSInteger defaultNetworkFirmID;
@property(nonatomic, readonly) NSTimeInterval defaultAdSourceLoadingDelay;

/*
 */
@property(nonatomic, readonly) NSTimeInterval updateTolerateInterval;
/// 自定义流量分组策略变更时，新增的超时时间ps_ct_out_cus
@property(nonatomic, readonly) NSTimeInterval waitUpdateTimeoutInterval;

@property(nonatomic, readonly) NSTimeInterval cacheValidDuration;
@property(nonatomic, readonly) NSDate *cacheDate;

@property(nonatomic, readonly) NSArray<ATMyOfferOfferModel*>* offers;
@property(nonatomic, readonly) ATMyOfferSetting *myOfferSetting;
@property(nonatomic, readonly) NSInteger usesDefaultMyOffer;
@property(nonatomic, readonly) BOOL preloadMyOffer;
//extra
@property(nonatomic, readonly) NSDictionary *callback;

@property(nonatomic, readonly) NSInteger FBHBTimeOut;

@property(nonatomic, readonly) NSDictionary* adxSettingDict;

@property(nonatomic, readonly) NSDictionary* olApiSettingDict;

@property(nonatomic, readonly) NSTimeInterval waterfallFillTime;

@property(nonatomic, readonly) NSString *currency;
@property(nonatomic, readonly) NSString *exchangeRate;

@property(nonatomic, readonly) NSArray *bURLNotificationFirms;

// v5.7.10
@property(nonatomic, readonly) NSString *campaign;


@property (nonatomic, assign) BOOL isShowSendMTG;

@property (nonatomic, assign) BOOL isMediationIDSendGDT;

@property (atomic, strong) NSDictionary *placementABDic;
@property (nonatomic, assign) BOOL isDisplayPriceSwitch;

@property (nonatomic, assign) NSInteger networkEstimatePriceNum;

@property (nonatomic, readonly) NSInteger bidImprssionExtraNum;

@property (nonatomic, strong) NSString *sharePlacementId;

@property (nonatomic, assign) BOOL hasSharePlacementId;
@property (nonatomic, assign) BOOL isSharePlacement;

@property (atomic, strong) NSDictionary *baiduReportDic;

/* v6430 支持插屏轮播 */
@property (nonatomic, assign) NSInteger rotationNum; // 轮播数量
@property (nonatomic, assign) NSTimeInterval rotationInter; // 轮播间隔
@property (nonatomic, assign) NSTimeInterval rotationCacheTs; // 查询缓存时间
@property (atomic, strong) ATEcwfModel *ecwfModel; // 智能瀑布流所需的数据
/* v6430 支持插屏轮播 */
//@property (nonatomic, assign) NSTimeInterval event_rotation_real_inter; // 用于上报 轮播过程中 实际使用的轮播间隔

/* v6435 */
@property (nonatomic, assign) BOOL iRSwitch; // sdk impression事件发生后，是否发起impression请求，用于激励视频反作弊。1:开启. 2关闭
@property (nonatomic, strong) NSDictionary *addrSt; // impression的url从这里拿
@property (nonatomic, copy) NSString *impT; // impression的url
/* v6435 */

/// 是否超过最大有效时长,默认24小时
@property (nonatomic, assign) BOOL isExceedMaxValidity;
/// ADX bidding独立请求开关SDK v6.4.42 以上支持，1开 2关
@property (nonatomic, assign) BOOL adxIndependentBiddingSwitch;


-(Class) adManagerClass;

- (NSDictionary *)revenueToPlatforms;

/**
 In order to solve the problem of inconsistency in legal tender. If the current ecpm currency is USD, this method returns NO.
 */
//- (BOOL)needConvertPrice;

/**
 If the current legal currency of ecpm is not USD, this method will calculate the corresponding price according to the latest exchange rate.
 */
//- (NSString *)convertedPrice:(NSString *)price;

//todo: just for in-house list. It's not a good solution.
@property(nonatomic, copy) NSArray<ATUnitGroupModel*>* allUnitGroupArray;


@property(nonatomic, copy) NSArray *directOfferUnitIDArray;


// v5.7.56+
@property(nonatomic, readonly) NSInteger encryptFlag;
@property(nonatomic, readonly, copy) NSString *encryptPublicKey;
@property(nonatomic, readonly, copy) NSDictionary *encryptApiDynamicInfoDic;

/**
 Maximum waiting time for s2s HB adSource to get buyeruid
 */
@property(nonatomic, readonly) NSInteger getBuyeruIdWaitTime;

@property(nonatomic, readonly, copy) NSString *inhouseUrl;
@property(nonatomic, readonly, copy) NSString *thirdInhouseUrl; // bks url of third plantforms

@property(nonatomic, readonly) NSString *exchRateC2U;
@property (nonatomic,readonly) NSString *bidFloor;

@property (nonatomic,readonly) NSInteger s2sBidMax;

@property(nonatomic, assign) BOOL isExistHBAdSource;
@property(nonatomic, assign) BOOL loadSuccessRetrySwitch;
@property(nonatomic, assign) BOOL loadFailRetrySwitch;
@property (nonatomic,assign) BOOL requestMerge;

@property(nonatomic, readonly) NSDictionary *gspRatesDic;
@property (nonatomic,readonly) NSString *adxExtJson;

@property (nonatomic, readonly) NSArray *loaddingTypeSwitchArray;

@property (nonatomic, readonly) BOOL isSetPangleRequestId;

/// 当使用SDK预置策略（或 开屏内置广告源）请求WF时,在WF结束后TopOn SDK根据广告位策略参数(presetwf_reload_sw)判断本次是否需要在WF结束后使用线上返回的广告位策略再执行一次WF
@property (nonatomic, assign) BOOL shouldLoadMoreWhenPresetLoaded;
@property (nonatomic, assign) BOOL hasCoolPlacementSettings;
@property (nonatomic, assign) ATPlacementSettingType type;

@property (nonatomic, assign) BOOL isUsePlacementSettingsFirst;
@property (nonatomic, assign) BOOL isSaveUserValueData;

@property (nonatomic, readonly) ATPlacementModelUserValueTimingType userValueTimingType;
@property (nonatomic, readonly) ATPlacementModelUserValueStrategyIndexType userValueStrategyIndex;
@property (nonatomic, readonly) NSInteger userValueReportCount;
@property (nonatomic, readonly) NSArray<NSArray<NSNumber *> *> *userValuePriceRanges;

@property (nonatomic, readonly) ATPlacementModelWaterfallModeType waterfallModeType;
@property (nonatomic, readonly) NSInteger serialMultiCachModeMaxConcurrentRequsetCount;
@property (nonatomic, readonly) ATLoadingRequestModelType serialMultiCachModeRequestModelType;
@property (nonatomic, readonly) NSTimeInterval LoadFailedAutoRetryLoadInterval;
@property (nonatomic, readonly) NSInteger statusNum;
@property (nonatomic, readonly) ATPlacementModelBaiduReportType baiduReportType;

@property(nonatomic, readonly) BOOL s2sSwitch;

@property (nonatomic, assign) ATNativeMixBannerStyleType nativeMixBannerStyleType;

@property (nonatomic, strong) NSValue *developerBannerSizeValue;
@property (nonatomic, assign) CGSize developerBannerSize;
@property (nonatomic, strong) NSArray *mixAdClickAreaArray;

//动态瀑布流开关
@property (nonatomic, assign) BOOL dynamicWaterfallSwitch;
@property (nonatomic, strong) ATDynamicWaterfallParams *dynamicWaterfall;

/// 缓存最大过期时间，默认：604800(秒），7天
@property (nonatomic, readonly) NSTimeInterval maxCacheExpirationTime;
//开屏广告SDK API传入超时时间，毫秒
//大于0：开屏广告SDK API传入超时时间优先采用广告位策略下发的该参数
//小于0或不下发：不使用该超时时间，即开关为关
@property (nonatomic, readonly) NSTimeInterval splashSdkPriorityTimeOut;


@property (nonatomic, readonly) NSTimeInterval biddingWaitOtherTime;
@property (nonatomic, readonly) NSTimeInterval adjustWaterFallHbTime;

@property (nonatomic, assign) ATPlacementModelAutoLoadType placementModelAutoLoadType;

/* v6450 **/
// 激励防刷 相关参数
@property (nonatomic, strong) ATAdsLgStModel *adsLgSetting;
/* v6450 **/



- (CGFloat)getNetworkgspRate:(NSString *)networkFirmID;
- (void)parsingUnitGroupsWithDictionary:(NSDictionary *)dictionary;
#pragma mark -NewDepart




- (ATMyOfferOfferModel *)miniCapForMyOffers;

@end
