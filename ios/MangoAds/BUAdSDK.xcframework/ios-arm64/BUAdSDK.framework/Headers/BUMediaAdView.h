//
//  BUMediaAdView.h
//  BUAdSDK
//
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUInterfaceBaseView.h"
#import "BUPlayerPublicDefine.h"
#import "BUMaterialMeta.h"

@class BUMaterialMeta;

NS_ASSUME_NONNULL_BEGIN

/**
 Control TikTok Audience Network video player.
 */
@protocol BUVideoEngine <NSObject>

/**
 Get the already played time.
 */
- (CGFloat)currentPlayTime;

/**
 Set video play when you support CustomMode
 **/
- (void)play;

/**
 Set video pause when you support CustomMode
**/
- (void)pause;

@end

@protocol BUVideoAdViewDelegate;

 __attribute__((objc_subclassing_restricted))
@interface BUMediaAdView : UIView<BUVideoEngine>

@property (nonatomic, weak, nullable) id<BUVideoAdViewDelegate> delegate;
/**
required. Root view controller for handling ad actions.
 **/
@property (nonatomic, weak, readwrite, nullable) UIViewController *rootViewController;

/**
 Whether to allow pausing the video by clicking, default NO. Only for draw video(vertical video ads).
 **/
@property (nonatomic, assign) BOOL drawVideoClickEnable;

/**
AdType information.
*/
@property (nonatomic, assign) NSInteger AdType;

/**
 material information.
 */
@property (nonatomic, strong, readwrite, nullable) BUMaterialMeta *materialMeta;

/**
 Set your Video autoPlayMode when you support CustomMode
 if support CustomMode , default autoplay Video
 **/
@property (nonatomic, assign) BOOL supportAutoPlay;

// Mediation:/// @Note :  Mediation dimension does not support this interface.
- (instancetype)initWithMaterial:(BUMaterialMeta *)materialMeta;

/**
 Support configuration for pause button.
 @param playImg : the image of the button
 @param playSize : the size of the button. Set as cgsizezero to use default icon size.
 */
- (void)playerPlayIncon:(UIImage *)playImg playInconSize:(CGSize)playSize;

@end

@protocol BUVideoAdViewDelegate <NSObject>

@optional

/**
 This method is called when video failed to play.
 @param error : the reason of error
 */
- (void)videoAdView:(BUMediaAdView *)adView didLoadFailWithError:(NSError *_Nullable)error;

/**
 This method is called when video ready to play.
 */
- (void)playerReadyToPlay:(BUMediaAdView *)adView;

/**
 This method is called when video playback status changed.
 @param playerState : player state after changed
 */
- (void)videoAdView:(BUMediaAdView *)adView stateDidChanged:(BUPlayerPlayState)playerState;

/**
 This method is called when the countdown of reward video rewards starts
 @param countDown : countdown of reward video rewards
 @Note : This method is only useful in China area.
 */
- (void)videoAdView:(BUMediaAdView *)adView
 rewardDidCountDown:(NSInteger)countDown;


/**
 This method is called when video end of play.
 */
- (void)playerDidPlayFinish:(BUMediaAdView *)adView;

/**
 This method is called when mediaAdView is clicked.
 */
- (void)videoAdViewDidClick:(BUMediaAdView *)adView;

/**
 This method is called when mediaAdView's finish view is clicked.
 */
- (void)videoAdViewFinishViewDidClick:(BUMediaAdView *)adView;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)videoAdViewDidCloseOtherController:(BUMediaAdView *)adView interactionType:(BUInteractionType)interactionType;


@end

NS_ASSUME_NONNULL_END
