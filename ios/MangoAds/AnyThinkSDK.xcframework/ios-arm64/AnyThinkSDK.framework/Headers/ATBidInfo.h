//
//  ATBidInfo.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 2020/4/27.
//  Copyright © 2020 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/ATModel.h>

@class ATUnitGroupModel;

NS_ASSUME_NONNULL_BEGIN

#define kATBiddingInitiatingFailedCode -2
#define kATBiddingNetworkTimeoutCode -3
#define KATBiddingS2SConnectionErrorCode -4
#define kATBiddingBiddingFailedByCapCode -5
#define kATBiddingBiddingFailedByPacingCode -6
#define kATBiddingBiddingFailedIntervalCode -7
#define kATBiddingBiddingFailedByExcludedCode -8
#define kATBiddingBiddingFailedIntegrationErrorCode -9
#define kATBiddingBiddingFailedBidFloor -11
#define kATBiddingBiddingFailedHighPrices -12

#define kATBaiduOriginalObjKey @"kATBaiduOriginalObj"
#define kATBaiduOriginalErrorCodeKey @"kATBaiduOriginalErrorCode"

typedef NS_ENUM(NSInteger, ATHBAdvanceRequestType) {
    ATHBAdvanceRequestUnknownType = 0,
    ATHBAdvanceRequestYesType,
    ATHBAdvanceRequestNOType,
};

typedef NS_ENUM(NSInteger, ATADXMixType) {
    ATADXMixTypeDefault              = -1, // 下发-1或与原广告位类型一致表示不混用
    ATADXMixTypeNativeSelfRender     = 0,  // 原生（自定义渲染）
    ATADXMixTypeBanner               = 2,  // Banner
    ATADXMixTypeSplash               = 4,  // Splash
    ATADXMixTypeVideo                = 5,  // 视频
    ATADXMixTypeNativeExpress        = 7   // 原生（模板）
};

typedef NS_ENUM(NSInteger, ATADXDealType) {
    ATADXDealTypeDefault  = 0, // 默认,旧逻辑
    ATADXDealTypePDB      = 1,
    ATADXDealTypePD       = 2,
    ATADXDealTypePA       = 3,
};

@interface ATBidInfo : ATModel

@property (atomic, readonly) NSString *unitID;
@property (nonatomic, readonly) NSDate *expireDate;
@property (nonatomic, readonly) NSDictionary *offerDataDict;
@property (nonatomic, readonly) NSString *bidId;
@property (nonatomic, readonly) NSString *bidIdMd5;
@property (nonatomic, readonly) NSString *tpBidId;
@property (nonatomic, readonly) ATBiddingCurrencyType currencyType;
@property (nonatomic, readonly) id customObject;
@property (nonatomic, readonly) NSString *placementID;
@property (nonatomic, readonly) NSString *adapterClassString;
@property (nonatomic, readonly) NSString *lURL;
@property (nonatomic, readonly) NSString *nURL;
@property (nonatomic, readonly) NSString *bURL;
@property (nonatomic, readonly) NSString *bURLWin;
@property (nonatomic, readonly) NSString *reqURL;
@property (nonatomic, readonly) BOOL bidResultCanRequest;
@property (nonatomic, readonly) ATUnitGroupType unitGroupType;
@property (nonatomic, readonly, getter=isValid) BOOL valid;
@property (nonatomic, readonly, getter=isExpired) BOOL expired;
@property (nonatomic, readonly, getter=isSendNotif) BOOL sendNotif;
@property (nonatomic, readonly, getter=isNoPrice) BOOL noPrice;
@property (nonatomic, assign) NSInteger networkFirmID;
@property (nonatomic, strong) NSString *ksOriginPrice;
@property (nonatomic, strong) NSString *networkOriginPrice;
@property (nonatomic, strong) NSString *sortPriorityLevel;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *ecpmApi;
@property (nonatomic, strong) NSString *precision;
///用来发送win/loss,转换三方平台所需要币种汇率
@property (nonatomic, strong) NSString *curRate;
@property (nonatomic, readwrite) NSTimeInterval bidTime;
@property (nonatomic, readwrite) BOOL bidPriceSmallerlast;
@property (nonatomic, readwrite) BOOL bidResultIsFailed;
@property (nonatomic, strong) NSError *error;
// for load success retry send tk&da auto_req
@property (nonatomic, readwrite) BOOL isLoadSuccessRetry;
@property (nonatomic, assign) ATHBAdvanceRequestType HBAdvanceRequestType;
@property (nonatomic, assign) BOOL isC2SNotNeedLoad;
@property (nonatomic, strong) id c2sCustomObject;
@property (nonatomic, strong) id c2SCustomEvent;
// for send win notification
@property (nonatomic, strong) NSString *nextUGPrice;
@property (nonatomic, strong) NSString *nextUGPriceNetworkName;
@property (nonatomic, strong) NSString *nextUGID;
@property (nonatomic, weak) ATUnitGroupModel *nextUG;
// for send loss notification
@property (nonatomic, weak) ATUnitGroupModel *winUG;

// only for Adx DirectOffer
@property (nonatomic, strong) NSString *offerID;
@property (nonatomic, strong) NSString *offerDspID;
@property (nonatomic, assign) BOOL isAdxNetworkDeveloperSend;
/// adx 折扣策略
@property (nonatomic, assign) CGFloat adxRate;
@property (nonatomic, copy) NSDictionary *bidResult;
// 用于ecpm加密的密钥数据
// 服务端密钥的唯一标识
@property (nonatomic, readonly, assign) NSInteger serverKeyId;
// ecpm加密后的(ecpm+unitid)数据
@property (nonatomic, strong) NSString *clientSideEcpmKeyString;
// adx模板最终需要渲染的广告类型
@property (nonatomic, assign) ATADXMixType adxMixType;

@property (nonatomic, assign) BOOL abnormalWinLoss;
@property (nonatomic, strong) NSString *abnormalPrice;
/// 第一次生成bidInfo时候,requestID
@property (nonatomic, strong) NSString *original_requestID;
/// PMP订单offer信息
/// 用于标识deal的类别
@property (nonatomic, assign) ATADXDealType dealType;
@property (nonatomic, strong) NSString *dealTypeString;
/// 用于标识订单的唯一ID
@property (nonatomic, strong) NSString *dealId;
/// PDB – 服务端使用订单的信息计算一个曝光的单价
/// PD – 根据订单的配置，使用订单的设置结算价格
/// PA – 使用广告主的报价
@property (nonatomic, strong) NSString *dealPrice;
/// PDB 订单的优先级
@property (nonatomic, assign) NSInteger dealPDBPrio;
/// adx请求维度的策略AB实验ID
@property (nonatomic, strong) NSArray *adxABTestIdList;
/// v6460 添加c2s 添加的splashBottomContainer 要在加载广告时拿到
@property (nonatomic, strong) UIView *splashBottomContainer;

/// C2S
/// - Parameters:
///   - placementID: placementID
///   - unitGroupUnitID: unitGroupUnitID
///   - adapterClassString: adapterClassString
///   - price:used to estimate prices and callback prices,The currency is in US dollars or Chinese yuan
///   - sortPrice: the sort price used in waterfall request,The currency is in US dollars or Chinese yuan
///   - currencyType: currency type
///   - expirationInterval: expiration Interval
///   - customObject: customObject, as ad source object
+ (instancetype)bidInfoC2SWithPlacementID:(NSString *)placementID
                          unitGroupUnitID:(NSString *)unitGroupUnitID
                       adapterClassString:(NSString *)adapterClassString
                                    price:(NSString *)price
                                sortPrice:(NSString *)sortPrice
                             currencyType:(ATBiddingCurrencyType)currencyType
                       expirationInterval:(NSTimeInterval)expirationInterval
                             customObject:(_Nullable id)customObject;

/// C2S
/// - Parameters:
///   - placementID: placementID
///   - unitGroupUnitID: unitGroupUnitID
///   - adapterClassString: adapterClassString
///   - price:used to estimate prices and callback prices,The currency is in US dollars or Chinese yuan
///   - currencyType: currency type
///   - expirationInterval: expiration Interval
///   - customObject: customObject, as ad source object
+ (instancetype)bidInfoC2SWithPlacementID:(NSString *)placementID
                          unitGroupUnitID:(NSString *)unitGroupUnitID
                       adapterClassString:(NSString *)adapterClassString
                                    price:(NSString *)price
                             currencyType:(ATBiddingCurrencyType)currencyType
                       expirationInterval:(NSTimeInterval)expirationInterval
                             customObject:(_Nullable id)customObject;

/// S2S
- (instancetype)initS2SWithDictionary:(NSDictionary *)dictionary
                          placementID:(NSString *)placementID
                       unitGroupModel:(ATUnitGroupModel *)unitGroupModel
                         currencyType:(ATBiddingCurrencyType)currencyType;

/// adx cache 
- (instancetype)initWithCacheDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)serializationToDictionary;

- (void)hasBeenSendNotif;
- (void)saveOfferModelDspID:(NSString *)offerDspID withOfferID:(NSString *)offerID;
- (void)encryptedC2SFilledPriceWithRequestID:(NSString *)requestID publicKey:(NSString *)publicKey;
- (void)releasCustomObject;
- (BOOL)isPMPType;
+ (NSString *)getExchRateC2U:(NSString *)placementID;

@end

NS_ASSUME_NONNULL_END
