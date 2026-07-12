//
//  BUNativeAd.h
//  BUAdSDK
//
//  Copyright © 2017 bytedance. All rights reserved.
//

#import "BUInterfaceBaseObject.h"
#import <UIKit/UIKit.h>
#import "BUAdSlot.h"
#import "BUMaterialMeta.h"
#import "BUMediaAdView.h"
#import "BUMopubAdMarkUpDelegate.h"
#import "BUAdClientBiddingProtocol.h"
#import "BUImage.h"
#import "BUCustomEventProtocol.h"
@protocol BUNativeAdDelegate;
@protocol BUEasyPlayWidgetDelegate;
@class BUNativeExpressAdView;

NS_ASSUME_NONNULL_BEGIN

/**
 Abstract ad slot containing ad data loading, response callbacks.
 BUNativeAd currently supports native ads.
 Native ads include in-feed ad (multiple ads, image + video), general native ad (single ad, image + video), native banner ad.
 Support banner ad, splash ad, rewarded video ad, full-screen video ad.
 */
 __attribute__((objc_subclassing_restricted))
@interface BUNativeAd : BUInterfaceBaseObject <BUMopubAdMarkUpDelegate, BUAdClientBiddingProtocol>

/**
 Ad slot description.
 */
@property (nonatomic, strong, readwrite, nullable) BUAdSlot *adslot;

/**
 Ad slot material.
 */
@property (atomic, strong, readonly, nullable) BUMaterialMeta *data;

/**
 The delegate for receiving state change messages.
 The delegate is not limited to viewcontroller.
 The delegate can be set to any object which conforming to <BUNativeAdDelegate>.
 */
@property (nonatomic, weak, readwrite, nullable) id<BUNativeAdDelegate,BUCustomEventProtocol> delegate;
@property (nonatomic, weak, nullable) id<BUEasyPlayWidgetDelegate> easyPlayDelegate;

/**
 required.
 Root view controller for handling ad actions.
 Action method includes is 'presentViewController'.
 */
@property (nonatomic, weak, readwrite) UIViewController *rootViewController;
/**
 Weather is dynamic render.
 */
@property (nonatomic, assign, readonly) BOOL isNativeExpress;
/**
 express ad view
// Mediation:@Note :  Mediation dimension does not support this interface.
 */
@property (nonatomic, weak, readonly) BUNativeExpressAdView *nativeExpressAdView;
/**
 required
 */
- (void)render;

/**
 Initializes native ad with ad slot.
 @param slot : ad slot description.
               including slotID,adType,adPosition,etc.
 @return BUNativeAd
// Mediation:@Note :  Mediation dimension does not support this interface.
 */
- (instancetype)initWithSlot:(BUAdSlot *)slot;

/**
 Register clickable views in native ads view.
 Interaction types can be configured on TikTok Audience Network.
 Interaction types include view video ad details page, make a call, send email, download the app, open the webpage using a browser,open the webpage within the app, etc.
 @param containerView : required.
                        container view of the native ad.
 @param clickableViews : optional.
                        Array of views that are clickable.
 */
- (void)registerContainer:(__kindof UIView *)containerView
       withClickableViews:(NSArray<__kindof UIView *> *_Nullable)clickableViews;

/**
 Unregister ad view from the native ad.
 */
- (void)unregisterView;

/**
 Actively request nativeAd datas.
// Mediation:@Note :  Mediation dimension does not support this interface.
 */
- (void)loadAdData;

/**
 Ad slot material id
 */
- (NSString *)getAdCreativeToken;

- (nullable BUImage *)getVideoCoverImage;

@end


@protocol BUNativeAdDelegate <NSObject>

@optional

/**
 This method is called when native ad material loaded successfully. This method will be deprecated. Use nativeAdDidLoad:view: instead
// Mediation:@Note :  Mediation dimension does not support this interface.
 */
- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd;


/**
 This method is called when native ad material loaded successfully.
// Mediation:@Note :  Mediation dimension does not support this interface.
 */
- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd view:(UIView *_Nullable)view;

/**
 This method is called when native ad materia failed to load.
 @param error : the reason of error
// Mediation:@Note :  Mediation dimension does not support this interface.
 */
- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error;

/**
 This method is called when native ad slot has been shown.
 */
- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeAdDidCloseOtherController:(BUNativeAd *)nativeAd interactionType:(BUInteractionType)interactionType;

/**
 This method is called when native ad is clicked.
 */
- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *_Nullable)view;

/**
 This method is called when the user clicked dislike reasons.
 Only used for dislikeButton in BUNativeAdRelatedView.h
 @param filterWords : reasons for dislike
 */
- (void)nativeAd:(BUNativeAd *_Nullable)nativeAd dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterWords;

/**
 This method is called when the Ad view container is forced to be removed.
 @param nativeAd : Ad material
 @param adContainerView : Ad view container
 */
- (void)nativeAd:(BUNativeAd *_Nullable)nativeAd adContainerViewDidRemoved:(UIView *)adContainerView;

/// This method will call when special ad event raised;
/// @param nativeAd ad
/// @param code eventCode
/// @param info event Info
- (void)nativeAd:(BUNativeAd *_Nullable)nativeAd onEventCode:(BUNativeAdEventCode)code info:(NSDictionary *)info;
@end

@protocol BUEasyPlayWidgetDelegate <NSObject>

@optional

// 轻互动组件相关信息
- (void)easyPlayInfo:(NSDictionary *)info;

// 媒体提供的预估可交互区域的最大值，CSJ会进行适当适配
// 若区域不满足当前轻互动组件的要求，则组件不会展示, 回调easyPlayRenderFail：
- (CGRect)easyPlayEstimatedInteractionArea;

// 轻互动组件渲染成功，返回当前轻互动组件实际可交互的区域信息
- (void)easyPlayRenderSuccess:(NSDictionary *)info;

// 轻互动组件渲染失败
- (void)easyPlayRenderFail:(NSError *)error;

// 轻互动组件关闭，若轻互动组件没有展示，不会回调该方法
- (void)easyPlayDidClose;

@end


NS_ASSUME_NONNULL_END
