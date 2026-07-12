//
//  ATAdCustomEvent.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 05/07/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AnyThinkSDK/ATAd.h>
#import <AnyThinkSDK/ATTracker.h>
#import <AnyThinkSDK/ATBidInfo.h>
#import <AnyThinkSDK/ATAdManager+Internal.h>

@class ATSafeThreadDictionary;

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kATSDKFailedToLoadSplashADMsg;
extern NSString *const kATSDKFailedToLoadBannerADMsg;
extern NSString *const kATSDKFailedToLoadInterstitialADMsg;
extern NSString *const kATSDKFailedToLoadNativeADMsg;
extern NSString *const kATSDKFailedToLoadRewardedVideoADMsg;
extern NSString *const kATSDKSplashADTooLongToLoadPlacementSettingMsg;
extern NSString *const kATSDKImportIssueErrorReason;
extern NSString *const kATAdAssetsAppIDKey;

extern NSString *const kATAdCustomEventNotificationKey;

typedef NS_OPTIONS(NSInteger, ATCustomEventType) {
    ATCustomEventLoaded = 0,
    ATCustomEventLoadFail = 1,
    ATCustomEventShow = 2,
    ATCustomEventShowFail = 3,
    ATCustomEventClick = 4,
    ATCustomEventClose = 5,
    ATCustomEventDetailViewWillPresentScreen = 6,
    ATCustomEventCloseBeforeViewAppear = 7, 
};

typedef NS_OPTIONS(NSInteger, ATAdCloseType) {
    ATAdCloseUnknow = 1,            // ad close type unknow
    ATAdCloseSkip = 2,              // ad skip to close
    ATAdCloseCountdown = 3,         // ad countdown to close
    ATAdCloseClickcontent = 4,      // ad clickcontent to close
    ATAdCloseShowfail = 99          // ad showfail to close
};

typedef NS_ENUM(NSInteger, ATADXDeepLinkInstallStatus) {
    ATADXDeepLinkInstallStatusUnknow = 0,
    ATADXDeepLinkInstallStatusYES = 1,
    ATADXDeepLinkInstallStatusNO = 2,
    ATADXDeepLinkInstallStatusElse = 3
};

#define ATAdRequestCallBackMode @"ad_s_reqf_mode"

@interface ATAdCustomEvent : NSObject

@property (atomic, copy) void(^requestCompletionBlock)( NSArray<NSDictionary *> * _Nullable assets,  NSError * _Nullable error);
@property (nonatomic, copy) void (^customEventMetaDataDidLoadedBlock)(void);
@property (nonatomic, readonly) NSMutableArray<NSDictionary *> *assets;
@property (nonatomic, readonly) NSDate *showDate;
@property (nonatomic, readonly) NSString *psIDOnShow;
@property (nonatomic, strong) NSNumber *sdkTime;
@property (nonatomic, strong) NSDictionary *serverInfo;
@property (nonatomic, strong) NSDictionary *localInfo;
@property (nonatomic, strong) NSDate *displaySuccessDate;
@property (nonatomic, strong) NSString *networkUnitId;
@property (nonatomic, strong) NSDictionary *networkCustomInfo;
@property (nonatomic, strong) NSString *networkAdvertisingID;
@property (nonatomic, strong) ATSafeThreadDictionary *networkExtarInfoDic;
@property (nonatomic, strong) ATTrackerInfo *trackerExtraInfo;
@property (nonatomic, assign) ATRequestFiledType requestFiledType;
@property (nonatomic, assign) ATOfferClickAdType clickType;
@property (nonatomic, assign) ATAdCloseType closeType;
@property (nonatomic, assign) NSInteger requestNumber;
/**
 * Failed or successful, a request's considered finished.
 */
@property (nonatomic, assign) NSInteger numberOfFinishedRequests;
@property (nonatomic, assign) BOOL isC2SBiding;
@property (nonatomic, assign) BOOL rewardGranted;
@property (nonatomic, weak) id<ATAd> ad;
@property (nonatomic, weak) id adapter;
@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) id _Nullable protectLifeCycleObject;



- (instancetype)initWithUnitID:(NSString *)unitID serverInfo:(NSDictionary *)serverInfo localInfo:(NSDictionary *)localInfo;
+ (NSDictionary *)serverInfoWithPlacementModel:(ATPlacementModel *)placementModel requestID:(NSString *)requestID unitGroup:(ATUnitGroupModel *)unitGroup;
+ (NSInteger)calculateAdPriority:(id<ATAd>)ad;
- (NSDictionary *)delegateExtra;
- (NSDictionary *)getDelegateExtraWithCaller:(ATAdManagerReadyAPICaller)caller;
- (void)handleAssets:(NSDictionary *)assets;
- (void)handleLoadingFailure:(NSError *)error;
- (void)handleClose;
- (void)handleShow;
- (void)handleShowFailed;
- (void)handleFailToPlayVideoWithError:(NSError *)error extra:(NSDictionary *)extraDic;

- (void)trackClick;
- (void)notifyAdapterShow;
- (NSDictionary *)trackCustomExtraInfo;

- (void)saveShowAPIContext;
- (void)unionTrackAdWithTrackType:(ATADTrackType)trackType extraBlock:(void (^) (ATSafeThreadDictionary *trackingExtra))block;
- (void)unionTrackAdClickWithBlock:(void (^) (ATSafeThreadDictionary *trackingExtra))block;
- (void)unionTrackAdShowWithBlock:(void (^) (ATSafeThreadDictionary *trackingExtra))block;
- (void)unionTrackAdShowAgainWithBlock:(void (^) (ATSafeThreadDictionary *trackingExtra))block;

- (ATADXDeepLinkInstallStatus)getDeepLinkInstallStatus;
- (ATNativeADSourceType)adSourceType;

- (void)getNetworkExtendInfo:(id)networkAd;

@end

NS_ASSUME_NONNULL_END
