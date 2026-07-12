//
//  BUNativeAdRelatedView.h
//  BUAdSDK
//
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUInterfaceBaseObject.h"
#import "BUMediaAdView.h"
#import "BUNativeAd.h"
#import "BUVideoAdReportor.h"
#import "BUDislikeReportor.h"

NS_ASSUME_NONNULL_BEGIN

 __attribute__((objc_subclassing_restricted))
@interface BUNativeAdRelatedView : BUInterfaceBaseObject

/**
 Need to actively add to the view in order to deal with the feedback and improve the accuracy of ad.
 */
@property (nonatomic, strong, readonly, nullable) UIButton *dislikeButton;

///Promotion label.Need to actively add to the view.
/// Please note: This API does not take effect on Pangle global, only use it when you have traffic from mainland China.
@property (nonatomic, strong, readonly, nullable) UILabel *adLabel;

/**
 Ad logo + Promotion label.Need to actively add to the view.
 */
@property (nonatomic, strong, readonly, nullable) UIImageView *logoADImageView;

/**
 Media ad view. Need to actively add to the view. Can not coexist with videoAdReportor.
 */
@property (nonatomic, strong, readonly, nullable) BUMediaAdView *mediaAdView;

/**
Video ad Reportor. Can not coexist with videoAdView.
*/
@property (nonatomic, strong, readonly, nullable) id<BUVideoAdReportor> videoAdReportor;

/// EC-Mall View
@property (nonatomic, strong, readonly, nullable) UIView *ecMallView;


/// Use this view to fill the area of EC-mall when no ads fetched;
+ (UIView   * _Nullable )defaultECMallView;

/**
 Refresh the data every time you get new datas in order to show ad perfectly.
// Mediation:@Note :  Mediation dimension does not support this interface.
 */
- (void)refreshData:(BUNativeAd *)nativeAd;

/// set to No if ECMallView is hidden or invisible
/// - Parameter isVisible: can ECMallView visible
- (void)setECMallViewVisiable:(BOOL)isVisible;

@end

@interface BUNativeAdSlidableView : BUInterfaceBaseView

@end
NS_ASSUME_NONNULL_END
