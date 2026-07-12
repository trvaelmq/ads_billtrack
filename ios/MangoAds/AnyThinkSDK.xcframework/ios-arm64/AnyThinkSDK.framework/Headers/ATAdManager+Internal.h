//
//  ATAdManager+Internal.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 04/05/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

/**
 * This file contains methods&properties implemented by ATAdManager intented for internal use only.
 */
#ifndef ATAdManager_Internal_h
#define ATAdManager_Internal_h
#import <AnyThinkSDK/ATAdManager.h>
#import <AnyThinkSDK/ATAd.h>
#import <AnyThinkSDK/ATAPI.h>

@class ATCheckLoadModel;

//The value is (subclass of) UIViewController
extern NSString *const kATAdLoadingExtraRefreshFlagKey;//Defined in loader
extern NSString *const kATAdLoadingExtraBannerAutoRefreshFlagKey;
extern NSString *const kATAdLoadingExtraAutoloadFlagKey;
extern NSString *const kATAdLoadingTrackingExtraStatusKey;
extern NSString *const kATAdLoadingTrackingExtraFlagKey;
extern NSString *const kATAdLoadingExtraDefaultLoadKey;

extern NSString *const kATReadyToShowNotification;

typedef NS_ENUM(NSInteger, ATAdManagerReadyAPICaller) {
    ATAdManagerReadyAPICallerReady = 0,
    ATAdManagerReadyAPICallerShow = 1,
};


@protocol ATBaiduTemplateRenderingAttributeDelegate;

@interface ATAdManager(Internal)
#pragma mark - for inner usage
//TODO: Packing the following method in a category and hide it from the client code.
/**
 The following ps id accessing methods are thread-safe.
 */
//TOOD ZSR 无用的

@property(nonatomic, strong) id<ATBaiduTemplateRenderingAttributeDelegate> baiduTemplateRenderingAttributeValue;


/**
 nil might be returned on one of the following conditions:
 1) No offer's been successfully loaded for the placement;
 2) Pacing/caps has exceeded the limit.
 when this happens, clients are expected to behave as if ad load request has failed.
 */
-(id<ATAd>) offerWithPlacementID:(NSString*)placementID error:(NSError**)error refresh:(BOOL)refresh;

/*
 Check if ad's ready for a placement, context is a storage specific block
 */
- (BOOL)adReadyForPlacementID:(NSString*)placementID scene:(NSString*)scene caller:(ATAdManagerReadyAPICaller)caller context:(BOOL(^)(NSDictionary *__autoreleasing *extra))context;
- (BOOL)adReadyForPlacementID:(NSString*)placementID caller:(ATAdManagerReadyAPICaller)caller context:(BOOL(^)(NSDictionary *__autoreleasing *extra))context;
- (BOOL)adReadyForPlacementID:(NSString*)placementID scene:(NSString*)scene caller:(ATAdManagerReadyAPICaller)caller sendTK:(BOOL)send context:(BOOL(^)(NSDictionary *__autoreleasing *extra))context;
- (BOOL)adReadyForPlacementID:(NSString*)placementID showConfig:(ATShowConfig *)showConfig caller:(ATAdManagerReadyAPICaller)caller sendTK:(BOOL)send context:(BOOL(^)(NSDictionary *__autoreleasing *extra))context;

/*
 *For internal use only
 */
- (BOOL)adReadyForPlacementID:(NSString*)placementID;
- (BOOL)adReadyForPlacementID:(NSString*)placementID sendTK:(BOOL)send;


-(NSDictionary*)extraInfoForPlacementID:(NSString*)placementID requestID:(NSString*)requestID;
-(void) setExtraInfo:(NSDictionary*)extraInfo forPlacementID:(NSString*)placementID requestID:(NSString*)requestID;
-(void) removeExtraInfoForPlacementID:(NSString*)placementID requestID:(NSString*)requestID;
-(NSDictionary*)lastExtraInfoForPlacementID:(NSString*)placementID;
-(void) clearCacheWithPlacementModel:(ATPlacementModel*)placementModel unitGroupModel:(ATUnitGroupModel*)unitGroupModel;


#pragma mark - other
- (BOOL)getInspectAdSourceStatusPlacementModel:(ATPlacementModel*)placementModel loadingUG:(ATUnitGroupModel *)loadingUG finalWaterfall:(ATWaterfallModel*)finalWaterfall requestID:(NSString*)requestID extraInfoArray:(NSArray<NSDictionary *> *__autoreleasing *)adSourceStatusInpectionExtraInfo;

#pragma mark - Data
- (void)unionEntryAdScenarioWithPlacementID:(NSString *)placementID scene:(NSString *)scene;
- (ATCheckLoadModel*)unionCheckAdLoadStatusForPlacementID:(NSString *)placementID;
- (NSArray<NSDictionary *> *)unionGetAdValidAdsForPlacementID:(NSString *)placementID;

#pragma mark - Is Ready

- (BOOL)checkFormatWithPlacementId:(NSString *)placementId format:(ATAdFormat)format;
- (BOOL)unionReadyForPlacementID:(NSString*)placementID showConfig:(ATShowConfig *)showConfig caller:(ATAdManagerReadyAPICaller)caller ad:(id<ATAd> __strong *)adObject extraInfo:(NSDictionary *__autoreleasing *)extraInfo sendTK:(BOOL)send;
- (BOOL)unionReadyForPlacementID:(NSString*)placementID;
- (BOOL)unionReadyForPlacementID:(NSString*)placementID sendTK:(BOOL)send;

#pragma mark - Get Ad
- (id<ATAd>)adHigestPriceWithPosition:(NSInteger)position placementID:(NSString *)placementID;
- (id<ATAd>)adHigestPriceWithPlacementID:(NSString *)placementID;
- (id<ATAd>)adHigestPriceForPlacementID:(NSString*)placementID invalidateStatus:(BOOL)invalidateStatus extra:(NSDictionary*__autoreleasing*)extra atAdInfo:(NSDictionary * _Nullable )atAdInfo;


#pragma mark - auto_refresh
- (void)autoRefreshIsReadyPlacementID:(ATPlacementModel *)placementModel;

#pragma mark - real time TK

+ (NSArray *)getRealTimeNetworkArray;

#pragma mark - send_tracking
- (void)sendEntryScenarioTrackingWithPlacementID:(NSString *)placementID unitGroupModel:(ATUnitGroupModel *)unitGroupModel scene:(NSString *)scene isLoading:(BOOL)isLoading isReady:(BOOL)isReady extraInfo: (NSDictionary *)extraInfo;

@end


#endif /* ATAdManager_Internal_h */
