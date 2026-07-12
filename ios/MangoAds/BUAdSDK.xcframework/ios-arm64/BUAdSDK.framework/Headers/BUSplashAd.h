//
//  BUSplashAd.h
//  BUAdSDK
//
//  Created by ByteDance on 2022/6/21.
//
// Mediation:// SDK从5.1.5.0版本支持聚合维度广告加载，当加载聚合维度广告时，部分设置及回调受最终展示的adn是否提供支持。

#import <UIKit/UIKit.h>
#import "BUMaterialMeta.h"
#import "BUMopubAdMarkUpDelegate.h"
#import "BUAdClientBiddingProtocol.h"
#import "BUInterfaceBaseObject.h"
#import "BUSplashView.h"
#import "BUSplashCardView.h"
#import "BUDictionary.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BUSplashAdCloseType) {
    BUSplashAdCloseType_Unknow = 0,             // unknow
    BUSplashAdCloseType_ClickSkip = 1,          // click skip
    BUSplashAdCloseType_CountdownToZero = 2,    // countdown
    BUSplashAdCloseType_ClickAd = 3,            // click Ad
    BUSplashAdCloseType_ForceQuit = 4           // Forced shutdown when an error is encountered
};

typedef NS_ENUM(NSInteger, BUSplashAdErrorCode) {
    BUSplashAdError_Unknow = 0,
    BUSplashAdError_LoadFailed = 1,              // data load failed
    BUSplashAdError_ResourceFailed = 2,          // resource load failed
    BUSplashAdError_RenderFailed = 3,            // render failed
    BUSplashAdError_TimeOut = 23                 // timeout
};

@protocol BUSplashAdDelegate;
@protocol BUSplashCardDelegate;

@class BUAdError;


/// Please note: This Class does not take effect on Pangle global, only use it when you have traffic from mainland China.
@interface BUSplashAd : BUInterfaceBaseObject <BUMopubAdMarkUpDelegate, BUAdClientBiddingProtocol>

@property (nonatomic, weak, nullable) id<BUSplashAdDelegate> delegate;

@property (nonatomic, weak, nullable) id<BUSplashCardDelegate> cardDelegate;

/**
 Whether support splash card view, default NO.
 */
@property (nonatomic, assign) BOOL supportCardView;

/**
 Whether hide skip button, default NO.
 If you hide the skip button, you need to customize the countdown.
 */
@property (nonatomic, assign) BOOL hideSkipButton;

/// Maximum allowable load timeout, default 3s, unit s.
@property (nonatomic, assign) NSTimeInterval tolerateTimeout;

/// The unique identifier of splash ad.
@property (nonatomic, copy, readonly, nonnull) NSString *slotID;

/// media configuration parameters.
@property (nonatomic, copy, readonly, nullable) BUDictionary *mediaExt;
///
@property (nonatomic, weak, readonly, nullable) UIViewController *splashRootViewController;

/// When splash ad load or render failed, it will be nil.
/// When splash ad cloesd, it will be released.
// Mediation:///@Note :  Mediation dimension does not support this interface.
@property (nonatomic, strong, readonly, nullable) BUSplashView *splashView;

/// When it is support splash card advertisement, it has value.
@property (nonatomic, strong, readonly, nullable) BUSplashCardView *cardView;

/// The screenshot of the last frame
// Mediation:/// @Note :  Mediation dimension does not support this interface.
@property (nonatomic, strong, readonly, nullable) UIView *splashViewSnapshot;

/**
 Initializes splash ad with slot id and sise.
 @param slotID : the unique identifier of splash ad
 @param adSize : the adSize of splashAd view. It is recommended for the mobile phone screen.
 @return BUSplashView
 */
- (instancetype)initWithSlotID:(NSString *)slotID adSize:(CGSize)adSize;

/**
 Initializes Splash video ad with ad slot, adSize and rootViewController.
 @param slot A object, through which you can pass in the splash unique identifier, ad type, and so on.
 @param adSize the adSize of splashAd view. It is recommended for the mobile phone screen.
 @return BUSplashView
 */
- (instancetype)initWithSlot:(BUAdSlot *)slot adSize:(CGSize)adSize;

/**
 Load splash ad datas.
 Start the countdown(@tolerateTimeout) as soon as you request datas.
 */
- (void)loadAdData;

/**
 Show splash ad view.
 Suggest call it after splash ad loaded successfully.
 You can call it at any time after loadAdData. The splash view will be added to the rootViewController only when render successfull.
 */
- (void)showSplashViewInRootViewController:(UIViewController *)viewController;

/**
 Show splash card view.
 You can call it when splashCardReadyToShow: callback.
 */
- (void)showCardViewInRootViewController:(UIViewController *)viewController;

/**
 Remove splash view.Stop the countdown as soon as you call this method.
 If you customize the skip button, you need to call this method to close the splash ad.
// Mediation:@Note :  Mediation dimension does not support this interface.
 */
- (void)removeSplashView;

/**
 Ad slot material id
 */
- (NSString *)getAdCreativeToken;

@end


@protocol BUSplashAdDelegate <NSObject>
/// This method is called when material load successful
- (void)splashAdLoadSuccess:(BUSplashAd *)splashAd;

/// This method is called when material load failed
- (void)splashAdLoadFail:(BUSplashAd *)splashAd error:(BUAdError *_Nullable)error;

/// This method is called when splash view render successful
// Mediation:/// @Note :  (针对聚合维度广告)<6300版本不会回调该方法，>=6300开始会回调该方法，但不代表最终展示广告的渲染结果。
- (void)splashAdRenderSuccess:(BUSplashAd *)splashAd;

/// This method is called when splash view render failed
// Mediation:/// @Note :  (针对聚合维度广告)<6300版本不会回调该方法，>=6300开始会回调该方法，但不代表最终展示广告的渲染结果。
- (void)splashAdRenderFail:(BUSplashAd *)splashAd error:(BUAdError *_Nullable)error;

/// This method is called when splash view will show
- (void)splashAdWillShow:(BUSplashAd *)splashAd;

/// This method is called when splash view did show
// Mediation:/// @Note :  当加载聚合维度广告时，支持该回调的adn有：CSJ
- (void)splashAdDidShow:(BUSplashAd *)splashAd;

/// This method is called when splash view is clicked.
- (void)splashAdDidClick:(BUSplashAd *)splashAd;

/// This method is called when splash view is closed.
- (void)splashAdDidClose:(BUSplashAd *)splashAd closeType:(BUSplashAdCloseType)closeType;

/// This method is called when splash viewControllr is closed.
// Mediation:/// @Note : 当加载聚合维度广告，最终展示的广告关闭时，
// Mediation:///         如该adn未提供“控制器关闭”回调，为保持逻辑完整，聚合逻辑内部在DidClose后补齐该回调，
// Mediation:///         如该adn提供“控制器关闭”回调，则以对应adn为准。
- (void)splashAdViewControllerDidClose:(BUSplashAd *)splashAd;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)splashDidCloseOtherController:(BUSplashAd *)splashAd interactionType:(BUInteractionType)interactionType;

/// This method is called when when video ad play completed or an error occurred.
- (void)splashVideoAdDidPlayFinish:(BUSplashAd *)splashAd didFailWithError:(NSError *_Nullable)error;

@end


@protocol BUSplashCardDelegate <NSObject>

/// This method is called when splash card is ready to show.
- (void)splashCardReadyToShow:(BUSplashAd *)splashAd;

/// This method is called when splash card is clicked.
- (void)splashCardViewDidClick:(BUSplashAd *)splashAd;

/// This method is called when splash card is closed.
- (void)splashCardViewDidClose:(BUSplashAd *)splashAd;

@end



@interface BUAdError : NSError

@property (nonatomic, assign) BUSplashAdErrorCode errorCode;

@end

NS_ASSUME_NONNULL_END



