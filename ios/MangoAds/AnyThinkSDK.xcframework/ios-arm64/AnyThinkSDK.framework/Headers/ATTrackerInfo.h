//
//  ATTrackerInfo.h
//  AnyThinkSDK
//
//  Created by GUO PENG on 2023/5/6.
//  Copyright © 2023 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/ATModel.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ATClickAreaType) {
    ATClickAreaNOEndCardCTAType                = 1,
    ATClickAreaNOEndCardCTAExistClickBanner    = 2,
    ATClickAreaNOEndCardBannerOutSideType      = 3,
    ATClickAreaNOEndCardAutoClickType          = 4,
    ATClickAreaNOEndCardShakeType              = 5,
    ATClickAreaEndCardCTAType                  = 6,
    ATClickAreaEndCardCTAOutSideType           = 7,
    ATClickAreaEndCardAutoClickType            = 8,
    ATClickAreaEndCardShakeType                = 9,
    ATClickAreaSkoverlyType                    = 10,
    ATClickAreaShakeBtnType                    = 11,
    ATClickAreaGuideType                       = 12,
    ATClickAreaInsensibilityType               = 13,
    ATClickAreaInvalidCloseButtonType          = 14,
    ATClickAreaOverlayTypeGestureGuidance      = 15,
    ATClickAreaOverlayTypeDragPuzzle           = 16,
    ATClickAreaOverlayTypeQAPopup              = 17,
    ATClickAreaOverlayTypeNoviceGuide          = 18,
    ATClickAreaOverlayTypeConfirmJump          = 19,
    ATClickAreaOverlayTypeFingerClickGuide     = 20,
    ATClickAreaOverlayTypeFullScreenSwipe      = 21,
    ATClickAreaSplashEndPop                    = 22,
    ATClickAreaVideoTopBanner                  = 23,
    ATClickAreaNOEndCardLeftButtonOfCTA        = 24,
    ATClickAreaNOEndCardRightButtonOfCTA       = 25,
    ATClickAreaCountdownGuideMask              = 26,
    ATClickAreaRedPacketOpenButton             = 27,
    ATClickAreaRedPacketViewArea               = 28,
    ATClickAreaRedPacketMaskArea               = 29,
    ATClickAreaRedPacketDetailReceiveButton    = 30,
    ATClickAreaRedPacketDetailReceiveOutside   = 31,
    ATClickAreaWithdrawVideoView               = 32,
    ATClickAreaWithdrawCardViewArea            = 33,
    ATClickAreaWithdrawButton                  = 34,
    ATClickAreaWithdrawBackGroundArea          = 35,
    ATClickAreaRetentionViewCTA                = 36,
    ATClickAreaRetentionViewCardArea           = 37,
    ATClickAreaRetentionViewBackGroundArea     = 38,
    ATClickAreaRetentionViewCloseButton        = 39,
    ATClickAreaEndCardLeftButtonOfCTA          = 40,
    ATClickAreaEndCardRightButtonOfCTA         = 41,
    ATClickAreaRVIncentiveTaskADFree           = 42,
    ATClickAreaOverlayTypeLuckybag             = 43,
    ATClickAreaOverlayTypeChopOnce             = 44,
    ATClickAreaOverlayTypeSlidePuzzle          = 45,
    ATClickAreaOverlayTypeGestureSlide         = 46,
    ATClickAreaOverlayTypeGesureClick          = 47,
    ATClickAreaOverlayTypeBigWhiteHand         = 48,
    ATClickAreaTypeBubbleDrop                  = 49,
};

typedef NS_ENUM(NSInteger, ATRenderVideoType) {
    ATRenderVideoTypeUnknow = 0,
    ATRenderVideoTypeNormal = 1,
    ATRenderVideoTypeNoVideoEndcard = 2,
    ATRenderVideoTypeNoVideoLayerEndcard = 3,
    ATRenderVideoTypeNoVideoRedPacketEndcard = 4,
    ATRenderVideoTypeNoVideoSlideEndcard = 5,
    ATRenderVideoTypeNoVideoCardScaleEndcard = 6,
    ATRenderVideoTypeNoVideoWebView = 7,
    ATRenderVideoTypeNoVideoNoMaterialEndcard = 8,
    ATRenderVideoTypeMTG = 9,
};

typedef NS_ENUM(NSInteger, ATNativeADSourceType) {
    ATNativeADSourceTypeUnknown = 0,
    ATNativeADSourceTypeVideo = 1,
    ATNativeADSourceTypeImage = 2
};

// 比价工具TK上报
// string  unit_id     当前TopOn SDK缓存价格最高的广告源id
// string  bidprice    当前TopOn SDK缓存价格最高的广告源对应的价格
// string 竞胜：第二名(竞败方)的ilrd原始数据，   竞败：竞胜方的ilrd原始数据
extern NSString *const kATTrackerExtraMmbIlrdKey;
// 竞胜
extern NSString *const kATTrackerExtraMmbSecPriceKey;  // double 第二名(竞败方)的价格，单位美元
extern NSString *const kATTrackerExtraMmbSecBidderKey; // string 第二名(竞败方)的名字，max或is上获取到什么就传什么，如max、topon、topon adx、ironsource等
// 竞败
extern NSString *const kATTrackerExtraMmbFirstPriceKey;  // double 竞胜方（第一名）的价格
extern NSString *const kATTrackerExtraMmbFirstBidderKey; // string 竞胜方（第一名）的名字，max或is上获取到什么就传什么，如max、topon、topon adx、ironsource等
extern NSString *const kATTrackerExtraMmbLossReasonKey;  // int 竞败原因 1. 价格过低 2. 超时 3. 其他（待sdk补充）
// string 下一次 bid 上传
extern NSString *const kATTrackerExtraMmbWaterfallInfoKey;

@interface ATTrackerInfo : NSObject

@property (nonatomic, assign) ATClickAreaType clickAreaType;
// only RewardedVideo use
@property (nonatomic, assign) ATRenderVideoType renderVideoType;

@end

NS_ASSUME_NONNULL_END
