//
//  ATAdObject.h
//  AnyThinkSDK
//
//  Created by li zhixuan on 2024/1/11.
//  Copyright © 2024 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/AnyThinkSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATAdObject : NSObject<ATAd>

@property (nonatomic, strong) ATPlacementModel *placementModel;
@property (nonatomic, strong) ATUnitGroupModel *unitGroup;
@property (nonatomic, strong) NSMutableArray<NSDictionary*> *unitGroupInfos;

/**
 Priority is calculate by the index of the unit group in the placement's unit group list; zero is the highest
 */
@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, assign) NSInteger priorityLevel;//the order in witch this ad has been requested
@property (nonatomic, strong) NSString *requestID;

@property (nonatomic, strong) NSString *originalRequestID;
@property (nonatomic, assign) NSInteger showTimes;
@property (nonatomic, strong) NSDate *expireDate;
@property (nonatomic, strong) NSDate *cacheDate;
/**
 * Third-party network native ad object.
 */
@property (nonatomic, strong, nullable) id customObject;
@property (nonatomic, strong) NSString *unitID;
@property (nonatomic, strong) NSString *appID;

@property (nonatomic, assign) BOOL filledByReady;
@property (nonatomic, assign) BOOL filledByAutoloadOnClose;
@property (nonatomic, assign) NSInteger fillByfreshType;
@property (nonatomic, assign) BOOL defaultPlayIfRequired;
@property (nonatomic, assign) BOOL defaultAdxOfferCached;
@property (nonatomic, assign) BOOL renewed;
@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSString *sortPriorityLevel;

@property (nonatomic, strong) NSString *bidId;
@property (nonatomic, strong) NSString *tpBidId;
@property (nonatomic, weak) ATWaterfallModel *finalWaterfall;
@property (nonatomic, assign) NSInteger autoReqType;
@property (nonatomic, assign) BOOL adReportClicked;

@property (nonatomic, assign) BOOL isSharePlacementOffer;

/// placementMode maybe is share placement, so this save true placment id,
@property (nonatomic, strong) NSString *placementId;

@property (nonatomic, strong) ATAdCustomEvent *customEvent;
@property (nonatomic, strong) NSString *scene;
@property (nonatomic, strong) NSString *showCustomExt;
@property (nonatomic, strong) ATCustomContentResult *customContentResult;

@property(nonatomic) BOOL isUserSetAd;
@property (nonatomic, strong) NSDictionary *developer_extraDic;

@property(nonatomic) BOOL adHasReportImpression;

- (void)setupPriority:(NSInteger) priority placementModel:(ATPlacementModel*)placementModel requestID:(NSString*)requestID assets:(NSDictionary*)assets unitGroup:(ATUnitGroupModel*)unitGroup finalWaterFall:(ATWaterfallModel *)finalWaterFall;
- (void)renewAdWithPlacementModel:(ATPlacementModel*)placementModel requestID:(NSString*)requestID;
- (void)releasCustomObject;
- (NSString *)ecpm;
- (NSString *)bidFloor;

- (BOOL)ready;



@end

NS_ASSUME_NONNULL_END
