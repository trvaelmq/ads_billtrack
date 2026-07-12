//
//  ATTracker.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 19/04/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/ATAd.h>
#import <AnyThinkSDK/ATTrackerInfo.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ATADTrackType) {
    ATADTrackTypeADRequest = 1, // 广告源请求
    ATADTrackTypeADRecalledSuccessfully = 2, // 广告源填充
    ATADTrackTypeADRecallFailed = 3,
    ATADTrackTypeADImpression = 4, // 广告展示
    ATADTrackTypeADRefreshShow = 5,
    ATADTrackTypeADClicked = 6, // 广告点击
    ATADTrackTypeVideoPlayed = 7,
    ATADTrackTypeVideoStart = 8,
    ATADTrackTypeVideoEnd = 9,
    ATADTrackTypeLoad = 10,
    ATADTrackTypeBidSort = 11, // bid结果上报
    ATADTrackTypeLoadResult = 12,// 加载成功
    ATADTrackTypeShowAPICall = 13, // 广告show API
    ATADTrackTypeEntryScenario = 16,// 上报场景
    ATADTrackTypeEntryLaunch = 21,
    ATADTrackTypeWin = 22,     // 比价SDK竞胜
    ATADTrackTypeLoss = 23,    // 比价SDK竞败
    ATADTrackTypeWinLoss = 24,    // win loss
    ATADTrackTypeRewarded = 25,    // 触发激励
    ATADTrackTypeComparePrice = 26, // 多聚合比价
    ATADTrackTypeUploadBrush = 27, // 刷子上报
};


@class ATSafeThreadDictionary;
@interface ATTracker : NSObject

+ (instancetype)sharedTracker;

- (void)trackWithPlacementID:(NSString *)placementID requestID:(NSString *)requestID trackType:(ATADTrackType)trackType extra:(nullable NSDictionary *)extra;
// TK6
- (void)trackClickWithAd:(nonnull id<ATAd>)ad extra:(nullable NSDictionary *)extra;
// TK21
- (void)sendLaunchTrackWithPsId:(NSString *)psId;
// TK22
- (void)trackWinWithPlacementID:(nonnull NSString *)placementID extra:(nullable NSDictionary *)extra;
// TK23
- (void)trackLossWithPlacementID:(nonnull NSString *)placementID extra:(nullable NSDictionary *)extra;
//TK24
- (void)trackWinLossWithPlacementID:(nonnull NSString *)placementID requestId:(NSString *)requestId extra:(nullable NSDictionary *)extra;


+ (nullable NSDictionary *)headerBiddingTrackingExtraWithAd:(id<ATAd>)ad requestID:(NSString *)requestID;

+ (NSDictionary *)replaceBidPrice:(NSDictionary *)originalTKDic unitGroup:(ATUnitGroupModel *)unitGroup;
/// 公共TK参数
+ (NSDictionary *)getTKCommonParameter:(nullable ATUnitGroupModel *)unitGroup placementModel:(nullable ATPlacementModel *)placementModel extraDic:(nullable NSDictionary *)extraDic trackType:(ATADTrackType)trackType;


@end

NS_ASSUME_NONNULL_END
