//
//  BUNativeExpressFullscreenVideoAd.h
//  BUAdSDK
//
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUInterfaceBaseObject.h"
#import "BUMaterialMeta.h"
#import "BUMopubAdMarkUpDelegate.h"
#import "BUAdClientBiddingProtocol.h"
#import "BUDictionary.h"
#import "BUCustomEventProtocol.h"
@class BUNativeExpressFullscreenVideoAd;

//define the type of native express video ad
typedef NS_ENUM(NSUInteger, BUNativeExpressFullScreenAdType) {
    BUNativeExpressFullScreenAdTypeEndcard              = 0,        // video + endcard
    BUNativeExpressFullScreenAdTypePurePlayable         = 2         // pure playable
};

NS_ASSUME_NONNULL_BEGIN
@protocol BUNativeExpressFullscreenVideoAdDelegate <NSObject,BUCustomEventProtocol>

@optional
/**
 This method is called when video ad material loaded successfully.
 */
- (void)nativeExpressFullscreenVideoAdDidLoad:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/**
 This method is called when video ad materia failed to load.
 @param error : the reason of error
 */
- (void)nativeExpressFullscreenVideoAd:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error;

/**
 This method is called when rendering a nativeExpressAdView successed.
 It will happen when ad is show.
 */
// Mediation:/// @Note :  (针对聚合维度广告)<6300版本不会回调该方法，>=6300开始会回调该方法，但不代表最终展示广告的渲染结果。
- (void)nativeExpressFullscreenVideoAdViewRenderSuccess:(BUNativeExpressFullscreenVideoAd *)rewardedVideoAd;

/**
 This method is called when a nativeExpressAdView failed to render.
 @param error : the reason of error
 */
// Mediation:/// @Note :  (针对聚合维度广告)<6300版本不会回调该方法，>=6300开始会回调该方法，但不代表最终展示广告的渲染结果。
- (void)nativeExpressFullscreenVideoAdViewRenderFail:(BUNativeExpressFullscreenVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error;

/**
 This method is called when video cached successfully.
 For a better user experience, it is recommended to display video ads at this time.
 And you can call [BUNativeExpressFullscreenVideoAd showAdFromRootViewController:]. 
 */
- (void)nativeExpressFullscreenVideoAdDidDownLoadVideo:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/**
 This method is called when video ad slot will be showing.
 */
// Mediation:/// @Note :  当加载聚合维度广告时，支持该回调的adn有：CSJ
- (void)nativeExpressFullscreenVideoAdWillVisible:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/**
 This method is called when video ad slot has been shown.
 */
- (void)nativeExpressFullscreenVideoAdDidVisible:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/**
 This method is called when video ad is clicked.
 */
- (void)nativeExpressFullscreenVideoAdDidClick:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/**
 This method is called when the user clicked skip button.
 */
- (void)nativeExpressFullscreenVideoAdDidClickSkip:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/**
 This method is called when video ad is about to close.
 */
// Mediation:/// @Note :  当加载聚合维度广告时，支持该回调的adn有：CSJ
- (void)nativeExpressFullscreenVideoAdWillClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/**
 This method is called when video ad is closed.
 */
- (void)nativeExpressFullscreenVideoAdDidClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/**
 This method is called when video ad play completed or an error occurred.
 @param error : the reason of error
 */
- (void)nativeExpressFullscreenVideoAdDidPlayFinish:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error;

/**
This method is used to get the type of nativeExpressFullScreenVideo ad
 */
// Mediation:/// @Note :  当加载聚合维度广告时，不支持该回调。
- (void)nativeExpressFullscreenVideoAdCallback:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd withType:(BUNativeExpressFullScreenAdType) nativeExpressVideoAdType;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressFullscreenVideoAdDidCloseOtherController:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd interactionType:(BUInteractionType)interactionType;

@end

/// Please note: This Class does not take effect on Pangle global, only use it when you have traffic from mainland China.
 __attribute__((objc_subclassing_restricted))
@interface BUNativeExpressFullscreenVideoAd : BUInterfaceBaseObject <BUMopubAdMarkUpDelegate, BUAdClientBiddingProtocol>

@property (nonatomic, weak, nullable) id<BUNativeExpressFullscreenVideoAdDelegate> delegate;

/// media configuration parameters.
@property (nonatomic, copy, readonly, nullable) BUDictionary *mediaExt;

/**
 Is  materialMeta from the preload, default is NO
 */
@property (nonatomic, assign, readonly) BOOL materialMetaIsFromPreload __deprecated;

/**
 The expiration timestamp of materialMeta
 */
@property (nonatomic, assign, readonly) NSTimeInterval expireTimestamp;

/**
 Initializes video ad with slot id.
 @param slotID : the unique identifier of video ad.
 @return BUFullscreenVideoAd
 */
- (instancetype)initWithSlotID:(NSString *)slotID;

/**
 Initializes video ad with slot.
 @param slot : A object, through which you can pass in the fullscreen unique identifier, ad type, and so on.
 @return BUNativeExpressFullscreenVideoAd
*/
- (instancetype)initWithSlot:(BUAdSlot *)slot;

/**
 Load video ad datas.
 */
- (void)loadAdData;

/**
 Ad slot material id
 */
- (NSString *)getAdCreativeToken;

/**
 Display video ad.
 @param rootViewController : root view controller for displaying ad.
 @return : whether it is successfully displayed.
 */
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;

/**
 Display video ad.
 @param rootViewController : root view controller for displaying ad.
 @param sceneDescirbe : optional. Identifies a custom description of the presentation scenario.
 @return : whether it is successfully displayed.
 */
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController ritSceneDescribe:(NSString *_Nullable)sceneDescirbe;

/**
 Get the expiration timestamp of materialMeta
 @warning: The value of this field is only accurate after the video is downloaded successfully or after the access is successfully obtained
 @Note :  This API is only useful in China area.
 */
- (NSTimeInterval)getExpireTimestamp;

@end

NS_ASSUME_NONNULL_END
