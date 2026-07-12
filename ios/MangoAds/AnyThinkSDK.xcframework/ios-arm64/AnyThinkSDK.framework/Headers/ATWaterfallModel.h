//
//  ATTempWaterfall.h
//  AnyThinkSDK
//
//  Created by GUO PENG on 2022/10/20.
//  Copyright © 2022 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/ATUnitGroupModel.h>
#import <AnyThinkSDK/ATPlacementModel.h>




typedef NS_ENUM(NSInteger, ATWaterfallType) {
    ATWaterfallTypeWaterfall = 0,
    ATWaterfallTypeFinal = 2
};

typedef NS_ENUM(NSInteger, ATUnitGroupFinishType) {
    ATUnitGroupFinishTypeFinished = 0,
    ATUnitGroupFinishTypeTimeout = 1,
    ATUnitGroupFinishTypeFailed = 2
};

NS_ASSUME_NONNULL_BEGIN

@interface ATWaterfallModel : NSObject

@property(nonatomic, strong) NSString *requestID;
@property(nonatomic, strong) NSString *placementID;
@property(nonatomic, strong) NSMutableArray <ATUnitGroupModel*> *unitGroups;
// HB提前请求 UG
@property(nonatomic, strong) NSMutableArray <ATUnitGroupModel*> *advanceSendUGArray;
// 动态出价 UG
@property(nonatomic, strong) NSMutableArray <ATUnitGroupModel*> *dynamicSendUGArray;
// 发送请求的 UG
@property(nonatomic, strong) NSMutableArray <ATUnitGroupModel*> *requestSentUnitGroups;
// 请求 超时 数量
@property(nonatomic, assign) NSUInteger numberOfTimeoutRequests;
// 瀑布流类型
@property(nonatomic, assign) ATWaterfallType type;
// 瀑布流 是否结束
@property(nonatomic, assign, getter=isLoading) BOOL loading;
// TODO 请求类型
@property(nonatomic, assign) ATLoadingAdApiType loadingApiType;
// TODO 广告位策略
@property (nonatomic, weak) ATPlacementModel *placement;

// init
- (instancetype)initWithUnitGroups:(nullable NSArray<ATUnitGroupModel*>*)unitGroups placementID:(NSString*)placementID requestID:(NSString*)requestID;

- (instancetype)initWithPlacementID:(NSString*)placementID requestID:(NSString*)requestID;

/// 添加 排序后请求 UG
- (void)addRankedAndShuffledUnitGroups:(NSArray<ATUnitGroupModel *> *)unitGroups;
/// 标记 UG 为已发起请求
- (void)requestUnitGroup:(ATUnitGroupModel*)unitGroup;
/// 标记 UG 为 发送请求完成
- (void)finishUnitGroup:(ATUnitGroupModel*)unitGroup withType:(ATUnitGroupFinishType)type;
/// 添加 待发送的 UG
- (void)addUnitGroup:(ATUnitGroupModel*)unitGroup;
/// 插入待发送的UG 内部会排序
- (void)insertUnitGroup:(ATUnitGroupModel*)unitGroup;
- (void)insertUnitGroupArray:(NSArray<ATUnitGroupModel*>*)unitGrous;
/// 移除 已完成的请求UG
- (void)removeFinishedRequestObject:(ATUnitGroupModel *)unitGroup;
/// 获取 已填充的UG
- (NSArray *)getRequestFilledUnitGroups;

/// 根据 unitID 获取UG
- (ATUnitGroupModel*)unitGroupWithUnitID:(NSString*)unitID;
/// 获取价格最大的 UG
- (ATUnitGroupModel*)unitGroupWithMaximumPrice;
/// 获取价格最小的 UG
- (ATUnitGroupModel*)unitGroupWithMinimumPrice;
/// 获取 瀑布流中所有 UG
- (NSMutableArray<ATUnitGroupModel *> *)getWaterfallAllUnitGroups;
/// 获取瀑布流中为发送请求的 UG
- (NSMutableArray<ATUnitGroupModel *> *)getWaterfallAllNotRequestUnitGroups;
/// 获取ug在final waterfall中的优先级
- (NSInteger)getPriorityInFinalWaterfallWithUnitGroup:(ATUnitGroupModel *)unitGroup;
/// 请求中最大价格(过滤指定的UG)
- (ATUnitGroupModel *)requestingUnitGroupMaxPriceWithFilteredUnitID:(NSString *)unitID;

#pragma mark - 提前请求
/// 获取 HB 提前请求 发送数量
- (NSInteger)getAdvanceSendCount;
///  获取 HB 提前请求 最大价格
- (ATUnitGroupModel*)advanceUnitGroupWithMaximumPrice;
/// HB 提前请求 插入 待发送 数组
- (void)insertAdvanceUnitGroup:(ATUnitGroupModel*)unitGroup;
/// 标记 UG 为 已发送
- (void)markAdvanceRequestSendUnitGroup:(ATUnitGroupModel*)unitGroup;
/// 标记 UG为 已填充
- (void)markAdvanceRequestFillUnitGroup:(ATUnitGroupModel*)unitGroup;
/// 获取 提前请求 已填充的 UG 数组
- (NSArray *)getAdvanceRequestFillUnitGroups;

#pragma mark - 动态出价
/// 获取 动态出价 提前请求 发送数量
- (NSInteger)getDynamicSendCount;
/// 获取 动态出价  已填充的 UG 数组
- (NSArray *)getDynamicRequestFillUnitGroups;
/// 获取 动态出价  最大价格
- (ATUnitGroupModel*)dynamicUnitGroupWithMaximumPrice;
/// 标记 UG 为 已发送
- (void)markDynamicRequestSendUnitGroup:(ATUnitGroupModel*)unitGroup;
/// 动态出价 插入 待发送 数组
- (void)insertDynamicUnitGroup:(ATUnitGroupModel*)unitGroup;
/// 标记 UG为 已填充
- (void)markDynamicRequestFillUnitGroup:(ATUnitGroupModel*)unitGroup;

#pragma mark - other
- (ATUnitGroupModel*)firstPendingNonHBUnitGroupWithNetworkFirmID:(NSInteger)nwFirmID;

- (NSString *)getNextPrice:(NSString *)price array:(NSArray *)priceArray;
/// 获取 同价格 UG 数量
- (NSInteger)getEqualPriceRequestsQueuedWithSpacing:(NSInteger)divisionSpacing;
/// 判断 瀑布流是否继续请求
- (BOOL)canContinueLoading:(BOOL)waitForSentRequests;
/// 遍历 请求超时 的 UG
- (void)enumerateTimeoutUnitGroupWithBlock:(void(^)(ATUnitGroupModel*unitGroup))block;


#pragma mark - status
- (void)updateUnitGroupStatus:(ATUnitGroupModel *)unitGroupModel unitGroupLoadStatus:(ATUnitGroupLoadStatus)unitGroupLoadStatus;


@end

NS_ASSUME_NONNULL_END
