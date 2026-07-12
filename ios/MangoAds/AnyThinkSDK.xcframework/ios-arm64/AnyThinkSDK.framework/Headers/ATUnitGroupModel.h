//
//  ATUnitGroupModel.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 11/04/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <AnyThinkSDK/ATModel.h>
#import <UIKit/UIKit.h>
#import <AnyThinkSDK/ATMyOfferOfferModel.h>
#import <AnyThinkSDK/ATBidInfo.h>
#import <AnyThinkSDK/ATModelProtocol.h>
#import <AnyThinkSDK/ATAdapter.h>
#import <AnyThinkSDK/ATStorage.h>


#define ATBaiDuUnitIDKey @"ATBaiDuUnitIDKey"
#define ATBaiDuplacementIdKey @"ATBaiDuplacementIdKey"
#define ATBaiDuUpdateExposureNotificationKey @"ATBaiDuUpdateExposureNotificationKey"


typedef NS_ENUM(NSInteger, ATRenderingType) {
    ATRenderingTopOnType = 1,    //TopOn SDK渲染，默认
    ATRenderingSelfType = 2,     // 开发者自渲染
};

typedef NS_ENUM(NSInteger, ATMixRewardGiveOutType) {
    ATMixRewardGiveOutTypeClose = 1,
    ATMixRewardGiveOutTypeClick = 2,
};

typedef NS_ENUM(NSInteger, ATRequestFiledType) {
    ATRequestFiledAdFodderDataType = 1,
    ATRequestFiledAdMetaDataType = 2,
};


typedef NS_ENUM(NSInteger, ATAdListType) {
    ATAdListTypeNormal = 1,
    ATAdListTypeC2S = 2,
    ATAdListTypeS2S = 3,
    ATAdListTypeAdx = 4,
    ATAdListTypeDsp = 5,
    ATAdListTypeOnLine = 6,
    ATAdListTypeInhouse = 7,
    ATAdListTypeDirect = 8,
    ATAdListTypeDynamicBid = 9,
    ATAdListTypeBottom = 10,
    ATAdListTypeBKS = 11,
    ATAdListTypeDynamicBidC2S = 12,
    ATAdListTypeDynamicBidS2S = 13,

};


typedef NS_ENUM(NSInteger, ATNetworkEstimatePriceType) {
    ATNetworkEstimatePriceTypeSort = 0,
    ATNetworkEstimatePriceTypeEstimate,
    ATNetworkEstimatePriceTypeReal,
    ATNetworkEstimatePriceTypeRealPriceNil,
    ATNetworkEstimatePriceTypeTimeOut,

};

typedef NS_ENUM(NSInteger, ATShowAutoLoadType) {
    ATShowAutoOneAdSupportLoadType = 1,
    ATShowAutoOneAdNotSupportLoadType,
    ATShowAutoOneNetWorkNotSupportLoadType,
};
/// ad type：0 Native, 1 Rewarded, 2 Banner, 3 Interstitial, 4 Splash
typedef NS_ENUM(NSInteger, ATUnitGroupJointAdType) {
    ATUnitGroupJointAdOtherType = -1,
    ATUnitGroupJointAdNativeType = 0,
    ATUnitGroupJointAdRewardedType = 1,
    ATUnitGroupJointAdBannerType = 2,
    ATUnitGroupJointAdInterstitialType = 3,
    ATUnitGroupJointAdSplashType = 4,
};

typedef NS_ENUM(NSInteger, ATNetworkCurrencyType) {
    ATNetworkCurrencyCNYType = 0,
    ATNetworkCurrencyUSDType,
};

typedef NS_ENUM(NSInteger, ATNUrlAuctionBidToWinType) {
    ATNUrlAuctionBidToWinTypeUseCurrentPrice = 1,
    ATNUrlAuctionBidToWinTypeUseZeroPrice = 2
};



typedef NS_ENUM(NSInteger, ATNativeMaterialType) {
    ATNativeMaterialTypeCrossPic = 1,
    ATNativeMaterialTypeVerticalPic = 2,
    ATNativeMaterialTypeCrossVideo = 3,
    ATNativeMaterialTypeVerticalVideo = 4,
    ATNativeMaterialTypeThreePic = 5,
    ATNativeMaterialTypeBanner = 6,
    ATNativeMaterialTypeOther = 7,
};

typedef NS_ENUM(NSInteger, ATCallBackPriceType) {
    ATCallBackPriceTypeCurrentPrice        = 1,   // 返回price
    ATCallBackPriceTypeSortPriorityLevel   = 2,   // 返回sortPriorityLevel，本期先当price处理，后续再补充。
    ATCallBackPriceTypeZeroPrice           = 3    // 返回0
};

typedef NS_ENUM(NSInteger, ATWinpriceForLossToPMPDealType) {
    ATWinpriceForLossToPMPDealTypeRandomPrice         = 1,  // 竞败方最高价格*130%内随机取值（默认值，默认不下发该字段）
    ATWinpriceForLossToPMPDealTypeHighestPricePlus    = 2,  // 竞败方最高价格+0.01
    ATWinpriceForLossToPMPDealTypeRealPMPPrice        = 3,  // 传真实PMP价格
    ATWinpriceForLossToPMPDealTypeZeroPrice           = 4,  // 设置为0
    ATWinpriceForLossToPMPDealTypeNegativeOnePrice    = 5   // 设置为-1
};

// v6450 竞价链路上报
typedef NS_ENUM(NSInteger, ATAdSourceLoadLinkNode) {
    ATAdSourceLoadLinkNodeBid = 1,
    ATAdSourceLoadLinkNodeBidReponse,
    ATAdSourceLoadLinkNodeLoad,
    ATAdSourceLoadLinkNodeFill,
    ATAdSourceLoadLinkNodeSendWL,
    ATAdSourceLoadLinkNodeShow
};


typedef NS_ENUM(NSInteger, ATUnitGroupLoadStatus) {
    ATUnitGroupLoadAwaitSendStatus = 0,
    ATUnitGroupLoadBiddingStatus = 1,
    ATUnitGroupLoadBidSucceedStatus = 2,
    ATUnitGroupLoadBidFailureStatus = 3,
    
    ATUnitGroupLoadBidShortTimeoutStatus,// 废弃
    ATUnitGroupLoadBidLongTimeoutStatus,// 废弃
    
    ATUnitGroupLoadRequestingStatus = 6,
    
    ATUnitGroupLoadRequestSucceedStatus = 7,
    ATUnitGroupLoadRequestFailureStatus = 8,
    ATUnitGroupLoadRequestTimeoutStatus,// 废弃
};

@interface ATUnitGroupModel : ATModel <ATModelProtocol, ATStorageEntityProtocol>
-(instancetype) initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, assign) ATRequestFiledType requestFiledType;
@property (nonatomic, assign) ATAdListType adListType;

@property(nonatomic, strong) NSString *tpBidID;
@property(nonatomic, readonly, weak) Class adapterClass;
@property(nonatomic, readonly) NSString *adapterClassString;
@property(nonatomic, readonly) NSInteger capByDay;
@property(nonatomic, readonly) NSInteger capByHour;
@property(nonatomic, assign) NSTimeInterval networkCacheTime;
@property(nonatomic, readonly) NSInteger networkFirmID;

@property(nonatomic, strong) NSString *networkFirmString;

@property(nonatomic, readonly) NSString *networkName;
@property (nonatomic, strong) NSString *unitName;
@property(nonatomic, readonly) NSInteger networkRequestNum;
@property(nonatomic, readonly) NSTimeInterval networkDataTimeout; //  5.1.0 双回调数据超时
@property(nonatomic, readonly) NSTimeInterval networkTimeout;
@property(nonatomic, readonly) NSTimeInterval skipIntervalAfterLastLoadingFailure;
@property(nonatomic, readonly) NSTimeInterval skipIntervalAfterLastBiddingFailure;
/// 废弃
@property(nonatomic, readonly) NSString *unitGroupID;
@property(nonatomic, readonly) NSString *unitID;
@property(nonatomic, readonly) NSDictionary *content;
// v6435 新增对 tk1,4,6,11 上报networkid, 后续新增广告平台需适配该字段
@property(nonatomic, readonly) NSString *network_placementId;
@property(nonatomic, readonly) NSTimeInterval showingInterval;//minimum interval between previous request & last impression
@property(nonatomic, readonly) CGSize adSize;
@property(nonatomic, readonly) NSTimeInterval autoRefreshInterval;

@property(nonatomic, readonly) BOOL splashZoomOut;
@property(nonatomic, strong) NSString *price;
@property(nonatomic, strong) NSString *ecpmByCurrency;
@property(nonatomic, readonly) NSInteger ecpmLevel;
@property(nonatomic, readonly) NSTimeInterval headerBiddingRequestTimeout;
@property(nonatomic, strong) NSString *bidPrice;
@property(nonatomic, strong) NSString *bidToken;
@property(nonatomic, assign) BOOL headerBidding;
@property(atomic, assign) ATUnitGroupType unitGroupType;
@property(nonatomic, readonly) NSTimeInterval bidTokenTime;
@property(nonatomic, readonly) NSTimeInterval statusTime;
@property(nonatomic, readonly) NSString *clickTkAddress;
@property(nonatomic, readonly) NSTimeInterval clickTkDelayMin;
@property(nonatomic, readonly) NSTimeInterval clickTkDelayMax;
@property(nonatomic, readonly) BOOL postsNotificationOnShow;
@property(nonatomic, readonly) BOOL postsNotificationOnClick;
@property(nonatomic, strong) NSString *precision;
@property(nonatomic, readonly) BOOL canAutoReady;
@property(nonatomic, readonly) BOOL waterfallTimeOutSW;
@property(nonatomic, readonly) BOOL reportBidPriceSW;
@property(nonatomic, assign) BOOL bidRealTimeLoadSW;
@property(nonatomic, readonly) BOOL returnHBEcpmSW;
@property(nonatomic, strong) ATBidInfo *bidInfo;

@property(nonatomic, readonly, getter=isBidInfoNoPrice) BOOL bidInfoNoPrice;
@property(nonatomic, readonly) BOOL unitGroupS2SSW;

@property(nonatomic) BOOL s2sRewardEnabled;

// v5.7.61+
@property(nonatomic, readonly) NSInteger weight;

@property(nonatomic, copy) NSString *directOfferOid;
// v6.1.10
@property (nonatomic,readonly) NSTimeInterval showDelay;

@property(nonatomic, assign) ATShowAutoLoadType showAutoLoadType;


@property(nonatomic) NSInteger priority; // when ad is filterd

/// ad type：0 Native, 1 Rewarded, 2 Banner, 3 Interstitial, 4 Splash
@property(nonatomic, assign) ATUnitGroupJointAdType jointAdType;

@property(nonatomic, assign) BOOL isHBAdvanceRequest;

@property (nonatomic,strong) NSString *bidFloor;

// 排序价格
@property (nonatomic, strong) NSString *sortPriorityLevel;

@property (nonatomic, strong) NSDecimalNumber *sortPriorityLevelNumber;


//reference 6.1.42
@property(nonatomic) NSInteger s2sSendLossPosition;

@property (nonatomic, strong) NSString *bidinfoEcpmStr;

@property (nonatomic, assign) ATNetworkCurrencyType networkCurrencyType;

/// 仅在展示时发送Win
@property (nonatomic, assign) BOOL onlyDisplaySendWin;


@property (nonatomic, assign) BOOL networkEstimatePriceSwitch;

@property (nonatomic, assign) ATNetworkEstimatePriceType networkEstimatePriceType;

@property (nonatomic, strong) NSString *networkEstimatePresentShowEcpmPrice;


@property (nonatomic, strong) NSArray *mixAdClickAreaArray;
@property (nonatomic, strong) NSArray<NSString *> *contentURLStrings;

/// C2S 广告加载成功 时间戳
@property (nonatomic, strong) NSDate *adDataSucceedDate;
/// C2S 渲染成功 时间戳
@property (nonatomic, strong) NSDate *adRenderSucceedDate;
/// 广告 开始请求 时间戳
@property (nonatomic, strong) NSDate *requestStartDate;

/// TopOn SDK允许京媒平台竞价广告源返回的最大bid price
@property (nonatomic, assign) CGFloat permitMaxBidPrice;
/// 对京媒平台竞价广告源返回的bid price进行价格扣量的系数
@property (nonatomic, assign) CGFloat quantityDiscountRate;

/// 是否使用topon的账号，注意：暂时只有京媒平台使用（sdk6_2_95）
@property (nonatomic, assign) BOOL isUseTopOnAccount;

#pragma mark - NewDepart

@property (nonatomic, readonly) ATAdapter *adapter;

@property (nonatomic, strong) NSDictionary *dictionary;

/// see -[ATUnitGroup updateSamePriceWeight]
@property (atomic, assign, readonly) CGFloat samePriceWeight;

@property (nonatomic, readonly) NSInteger adsMaxCacheNum;

@property (nonatomic, assign) BOOL isPermitSendWin;

@property (nonatomic, assign) BOOL isPermitSendLoss;

@property (nonatomic, strong) NSString *admobRequestAgent;
@property (nonatomic, assign) BOOL isNativeShakeSwitch;

// v6.2.69
@property(nonatomic, readonly) NSInteger admobBibType;
@property(nonatomic, readonly) BOOL isAdmobHybrid;
@property(nonatomic, readonly) NSInteger networkId;


@property (nonatomic, strong) NSString *customExtString;
@property (nonatomic, strong) NSArray<NSNumber *> *supportExpressType;

// v6.2.96
// 混用原生渲染类型
@property(nonatomic, readonly) ATRenderingType renderingType;
@property(nonatomic, readonly) ATAdOfferInterType interType;

@property (nonatomic, assign) BOOL isHBInfoDaSwitch;

@property (nonatomic, assign) ATMixRewardGiveOutType mixRewardGiveOutType;

// 动态竞价底价开关，默认下发为2，关
@property (nonatomic, readonly) BOOL isDynamicBidFloorSwitch;

//优量汇堆栈信息上报开关（sdk6.3.45新增），暂时只有优量汇用到，枚举说明
//1：开启（默认）
//2：关闭
@property (nonatomic, readonly) BOOL isGdtStackSwitch;

@property (nonatomic, assign) ATNUrlAuctionBidToWinType nUrlAuctionBidToWinType;

// 用于标记每次广告位策略请求标识，每个广告源在每次广告位策略请求中都会获得唯一的unique_id
@property (nonatomic, strong) NSString *uniqueId;
// 用于ecpm加密的密钥数据
// 服务端密钥对应的唯一标识
@property (nonatomic, assign) NSInteger serverKeyId;
// 客户端密钥对应的唯一标识
@property (nonatomic, assign) NSInteger clientKeyId;
// 客户端竞价广告源非对称加密算法的公钥
@property (nonatomic, strong) NSString *clientPubKey;
// ecpm加密后的(ecpm+unitid)数据
@property (nonatomic, strong) NSString *clientSideEcpmKeyString;
// 动态出价底价
@property (nonatomic, strong) NSString *dynamicFloorPrice;
/// 广告源加载限制,请求次数的周期
@property(nonatomic, assign) NSTimeInterval loadCapDuration;
/// 广告源请求次数上限
@property(nonatomic, assign) NSInteger loadCapTime;
/// 延迟发起竞价时间
@property(nonatomic, assign) NSInteger bidReqDelayDuration;

/// 广告源或广告平台价格系数
@property(nonatomic, assign) CGFloat sptyCoefficient;
/// 缓存排序价格,客户端排序价格=填充价格(s_pty)*p_coef
@property (nonatomic, strong) NSString *showCacheSortPriorityLevel;
#pragma mark - 三方广告信息
/// 原生广告素材类型(百度需要)
@property (nonatomic, assign) ATNativeMaterialType nativeMaterialType;
/// 广告源请求时间戳
@property (nonatomic, strong) NSNumber *requestTimesTamp;
/// 三方广告 请求ID
@property (nonatomic, strong) NSString *network_requestID;

@property (nonatomic, strong) NSDictionary *winAdInfoDic;
///三方广告 加密价格
@property (nonatomic, strong) NSString *network_en_p;
// 竞价成功
@property (nonatomic, assign) ATCallBackPriceType adSourceBidSuccessCallBackPriceType;
// 广告源请求开始
@property (nonatomic, assign) ATCallBackPriceType adSourceRequestCallBackPriceType;
// 广告源填充成功或者失败
@property (nonatomic, assign) ATCallBackPriceType adSourceRequestResultRCallBackPriceType;
// 查询广告缓存
@property (nonatomic, assign) ATCallBackPriceType checkAdCacheCallBackPriceType;
// 广告展示及展示后行为
@property (nonatomic, assign) ATCallBackPriceType showCallBackPriceType;
// 输给PMP时胜出价上报逻辑
@property (nonatomic, assign) ATWinpriceForLossToPMPDealType winpriceForLossToPMPDealType;

@property (nonatomic, assign) BOOL shouldAdapterLoadedSendWin;
/* 插屏广告点击跳转后，是否自动关闭广告 v6430添加 */
@property (nonatomic, assign) BOOL closeAfterClick;// 轮播启动时点击后是否关闭
@property (nonatomic, assign) BOOL rotationSwitch; // 轮播开关 1开启 2关闭 
@property (nonatomic, assign) NSTimeInterval rotationSpiInter; // 默认值4.5秒，支持填0-10，可置空。下发单位毫秒
@property (nonatomic, assign) NSInteger event_rotation_count; // 用于上报 轮播数
@property (nonatomic, assign) NSInteger event_rotation_close_cache_count; // 用于上报 关闭时可以播的缓存数
@property (nonatomic, assign) NSInteger event_rotation_close_reason; // 用于上报 关闭原因
@property (nonatomic, assign) BOOL rotation_switch; // 用于上报 关闭原因 这个是本地的校验之后的结果对其进行赋值, 不是从服务器上获取的

@property (nonatomic, assign) NSInteger pBfSwitch;
// 智能瀑布
//@property (nonatomic, strong) NSNumber *adSourceSmartTimesTamp;// 只能瀑布流记录时间戳
/* 插屏广告点击跳转后，是否自动关闭广告 v6430添加 */

/* v6450添加 */
// 目前用于tk25
// 激励回调来源 1：广告平台平台回调 2：topon依赖playend事件兜底补充的回调（仅定制版本会兜底，主版本没有兜）
@property (nonatomic, assign) NSInteger rewardFrom; // 目前固定为 1  安卓也是这样的
// 触发激励时, 广告平台是否回调playend
@property (nonatomic, assign) BOOL isPlayend; // csj 使用agin回调 和现有的分开  1:已经触发end 2:未触发end
// 广告平台回调成功或者失败
@property (nonatomic, assign) BOOL isRewarded;   // 激励是否成功 1: 成功  2: 失败 现在ios的设计只能传1 network只有在回调成功时才会向core层发激励成功

@property (nonatomic, copy) NSString *url;   // app策略 s2s_addr

@property (nonatomic, assign) BOOL isAntiCheating; // 是否为开启激励防刷的平台

@property (nonatomic, assign) NSInteger bdIT;

- (void)setLoadLinkNode:(ATAdSourceLoadLinkNode)linkNode;

- (NSString *)getLoadLink;
/*v6450添加 */


/// same price need a order, use samePriceWeight to order, when ad cache return
/// @param newWeight when water fall load, will calculate new weight
- (void)updateSamePriceWeight:(CGFloat)newWeight;


@property(atomic, assign) ATUnitGroupLoadStatus unitGroupLoadStatus;


- (BOOL)saveWithUnitGroup:(ATUnitGroupModel *)unitGroup;
- (void)updateWithUnitGroup:(ATUnitGroupModel *)unitGroup;
- (void)removeWithUnitGroup:(ATUnitGroupModel *)unitGroup;
/// 注意:获取最新加载生成的 UnitGroupModel
- (ATUnitGroupModel *)readUnitGroupWithIdentifier:(NSString *)identifier;

- (BOOL)isAuthNetworkPrivacy;

- (BOOL)isC2SType;
- (BOOL)isS2SType;
- (BOOL)isPMPType;

@end
