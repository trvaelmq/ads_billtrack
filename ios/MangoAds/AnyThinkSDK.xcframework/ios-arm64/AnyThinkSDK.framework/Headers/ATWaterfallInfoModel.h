//
//  ATTempWaterfallWrapper.h
//  AnyThinkSDK
//
//  Created by GUO PENG on 2022/10/20.
//  Copyright © 2022 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/ATAd.h>


NS_ASSUME_NONNULL_BEGIN
@class ATUnitGroupModel;
@class ATPlacementModel;
@class ATWaterfallModel;


typedef enum : NSUInteger {
    ATwaterfallModuleTypeStart = 1,
    ATWaterfallModuleTypeNext,
    ATWaterfallModuleTypeAdvance,
    ATWaterfallModuleTypeDynamic,
} ATWaterfallModuleType;

typedef enum : NSUInteger {
    ATLoadedCallbackTypeAdSourceStatusCached,
    ATLoadedCallbackTypeNormalRequest
} ATLoadedCallbackType;



@interface ATWaterfallInfoModel : NSObject
//use in delegate call back success

@property (nonatomic, assign) BOOL isSharePlacementSucceeded;

@property (nonatomic, strong) NSString *requestID;

@property (nonatomic, assign) ATWaterfallModuleType waterfallModuleType;

@property(nonatomic, assign) BOOL waterFallfinished;

@property(nonatomic, assign) BOOL finished;

@property(nonatomic, strong) NSDate *loadStartDate;

@property(nonatomic, assign, getter=isFilled) BOOL filled;

@property(nonatomic, strong) ATWaterfallModel *waterfall;
@property(nonatomic, strong) ATWaterfallModel *finalWaterfall;
@property(nonatomic, strong) ATWaterfallModel *defaultWaterfall;

/// 默认为waterfall,当为兜底模式时,为defaultWaterfall
@property(nonatomic, strong) ATWaterfallModel *currentUwaterfall;

@property(nonatomic, assign) BOOL headerBiddingFired;
@property(nonatomic, assign) BOOL headerBiddingFailed;
@property(nonatomic, assign) BOOL hasBeenShowInWaterfall;

@property(nonatomic, assign) NSInteger numberOfCachedOffers;

@property(nonatomic, assign) BOOL isFillTimeout;
// TODO: ADX 位置??
@property(nonatomic, strong) id<ATAd> _Nullable adxOfferCached;

@property(nonatomic, assign) ATLoadedCallbackType loadedCallbackType;

@property (nonatomic, assign) NSInteger highestPriorityOfShownAd;
/// bid 是否短超时
@property (nonatomic, assign) BOOL isBidingShortTimeout;
/// bid 是否长超时
@property (nonatomic, assign) BOOL isBidingLongTimeout;

- (void)finish;
- (void)fill;
- (void)hasBeenShow;
- (void)markUnfinished;
- (void)destroy;


- (void)removeAdxOfferCached;

/// 获取所有瀑布流 已填充最低价格
- (ATUnitGroupModel*)filledUnitGroupWithMaximumPrice;
- (ATUnitGroupModel *)filledUnitGroupPriceNextLoadWithExpectedIndex:(NSInteger)expectedIndex isNeedBeyondEmpty:(BOOL)isNeedBeyondEmpty;

+ (instancetype)waterfallInfoWithWaterfallModel:(ATWaterfallModel *)waterfallModel;

#pragma mark - status
/// 初始化 普通广告源状态 ATWaterFallLoader
- (void)initializeNormalAdSourceStatusUnitGroupArray:(NSArray <ATUnitGroupModel *>*)unitGroupArray;
/// 初始化 竞价广告源状态
- (void)initializeHBAdSourceStatusUnitGroupArray:(NSArray <ATUnitGroupModel *>*)unitGroupArray;

/// 更新 未返回结果的广告源 为失败 ATWaterFallLoader
- (void)updateAllAdSourceFailure;

/// 获取所有 请求ing 请求成功 竞价广告源  ATWinLossSendTool
- (NSArray<ATUnitGroupModel *> *)bidFilledAndRequestingStateMode;


/// 获取bid成功,但未发起请求的广告源 ATWinLossSendTool
- (NSArray<ATUnitGroupModel *> *)unUsedbidinfo;

/// 判断请求ing中的竞价广告源价格  是否比指定价格大
- (BOOL)existHigherPriceBiddingAdSourceRequestingWithCurrentUnitGroup:(ATUnitGroupModel *)unitGroup;

/// 判断请求ing中的 广告源价格是否比指定价格大
- (BOOL)existHigherPriceAdSourceRequestingWithCurrentUnitGroup:(ATUnitGroupModel *)unitGroup;

/// 返回值: 1:正在请求ing,2:正在bidding中 判断请求ing中的广告源价格是否比指定价格大 ATGeneralTool
- (NSArray *)existHigherPriceRequestingAdWithCurrentUnitGroup:(ATUnitGroupModel *)unitGroup;

/// 获取bid成功,未发起请求的最高价 ATGeneralTool
- (ATUnitGroupModel *)higherPriceAdSourceBidSuccess;

/// 获取请求成功最高价
- (ATUnitGroupModel *)higherPriceAdSourceRequestSuccessful;

/// 获取请求成功最高价,不包括指定ad
- (ATUnitGroupModel *)higherPriceAdSourceRequestSuccessfulExcludeUnitID:(nullable NSString *)unitID;

/// 判断是否所有的广告,请求完成 ATWaterFallLoader ATWaterfallInfoModel
- (BOOL)isAllAdSourceFinish;

/// 判断是否所有的HB广告源,竞价完成,用于成功失败回调
- (BOOL)isAllAdSourceBiddingFinish;

/// 获取bid完成,但是没发请求的广告源
- (NSArray<ATUnitGroupModel *> *)getBidFinishNORequest;

/// 获取价格最大的 待发送广告源
- (ATUnitGroupModel *)getPrepareRequestingMaxhuaPriceStateModeWithCallSuccessfulType:(ATCallSuccessType)callSuccessfulType;

/// 更新 ug unitGroupLoadStatus
- (void)updateAdSourceStatus:(ATUnitGroupLoadStatus)unitGroupLoadStatus unitGroupModel:(ATUnitGroupModel *)unitGroupModel;

/// 获取S2S 请求失败的广告源,用于发起重试
- (NSArray *)getAdSourceBiddingFailure;

@end

NS_ASSUME_NONNULL_END
