//
//  ATBidInfoCacheManager.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 2020/4/28.
//  Copyright © 2020 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/ATBidInfo.h>



NS_ASSUME_NONNULL_BEGIN

#define ATHeaderBiddingListKey @"headerBiddingList"
#define ATHbParmeterErrorsKey @"hbParmeterErrors"
#define ATCurrentUnitGroupsKey @"currentUnitGroups"

@class ATUnitGroupModel;
@class ATPlacementModel;
@class ATBidWaterFallModel;
@class ATBidNotifSendModel;
@class ATWaterfallModel;
//@class ATWinLossSendTool;

typedef NS_ENUM(NSUInteger, ATLossType) {
    ATLossAdExpiteType = 1,
    ATLossAdCheckCacheType, 
    ATLossAdWaterFallFinshType,
    ATLossAdC2SHBTimeOutType,
    ATLossAdLoadFailedtype,
    ATLossAdBidFloorFilterType,
    ATLossAdUserRemove,
    ATLossAdLoadedType,
    ATLossAdLoadFailedSendLoss, //由于 加载失败 而发送loss 目前支持百度
    ATLossAdShowOrClickKSLoss, // 曝光或点击时发送快手的loss
    ATLossAdDeveloerEcpmFilter // 开发者ecpm过滤

};
typedef void(^StartBidBlock)(NSDictionary * headerBiddingListDic);

@interface ATBidInfoCacheManager : NSObject

+ (instancetype)sharedManager;

- (void)saveBidInfo:(ATBidInfo*)bidInfo;
- (void)invalidateBidInfoForPlacementID:(NSString*)placementID unitGroupModel:(ATUnitGroupModel*)unitGroupModel;
- (ATBidInfo*)getBidInfoCachedForPlacementID:(NSString*)placementID unitGroup:(ATUnitGroupModel*)unitGroup;

- (NSArray<ATUnitGroupModel*>*)unitGroupWithHistoryBidInfoAvailableForPlacementID:(NSString*)placementID unitGroups:(NSArray<ATUnitGroupModel*>*)unitGroupsToInspect inhouseUnitGroups:(NSArray<ATUnitGroupModel*>*)inhouseUnitGroupsToInspect s2sUnitGroups:(NSArray<ATUnitGroupModel*>*)s2sUnitGroupsToInspect bksUnitGroups:(NSArray<ATUnitGroupModel*>*)bksUnitGroupsToInspect  directUnitGroups:(NSArray<ATUnitGroupModel*>*)directUnitGroups requestID:(NSString*)requestID placementModel:(ATPlacementModel *)placementModel;

/**
 Used for send hb loss notification
 */
- (BOOL)saveWithBidNotifSendModel:(ATBidNotifSendModel*)bidNotifSendModel forRequestID:(NSString*)requestID;
- (ATBidNotifSendModel*)getBidNotifSendModelForRequestID:(NSString*)requestID;

+ (NSString *)getPriceToSendHBNotifiForUnitGroup:(ATUnitGroupModel*)unitGroupModel;
+ (NSString *)getSortPriorityPriceToSendHBNotifiForUnitGroup:(ATUnitGroupModel*)unitGroupModel;

- (void)removeBidInfoWithDiskForPlacementID:(NSString*)placementID bidInfos:(NSArray<ATBidInfo*>*)bidInfos;


#pragma mark - bid List
- (void)saveBidRequestHBList:(NSDictionary *)hbListExtra forKeyStr:(NSString *)keyStr;
- (NSDictionary *)getBidRequestHbListAndRemoveHBListForKeyStr:(NSString *)keyStr;


- (NSDictionary *)getBidRequestHbListForKeyStr:(NSString *)keyStr;



@end

NS_ASSUME_NONNULL_END
