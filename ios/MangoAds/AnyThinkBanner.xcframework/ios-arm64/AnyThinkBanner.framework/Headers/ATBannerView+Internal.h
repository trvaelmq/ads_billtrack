//
//  ATBanner+Internal.h
//  AnyThinkBanner
//
//  Created by Martin Lau on 28/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef ATBanner_Internal_h
#define ATBanner_Internal_h
#import <AnyThinkBanner/ATBannerView.h>
#import <AnyThinkBanner/ATAdManager+Banner.h>


NS_ASSUME_NONNULL_BEGIN

@class ATBanner,ATOfferBannerView;
@interface ATBannerView(Internal)
-(instancetype) initWithFrame:(CGRect)frame banner:(ATBanner*)banner placementID:(NSString *)placementID;
-(void) loadNextWithoutRefresh;
@property(nonatomic) ATBanner *banner;
@property (nonatomic, strong,nullable) ATNativeBannerView *selfRenderingMixBannerlView;

@property(nonatomic,copy) NativeMixBannerViewBlock nativeMixBannerViewBlock;

- (ATOfferBannerView *)getPrivateOfferBannerView;
- (void)evaluationPanGesture:(nullable UIPanGestureRecognizer *)panGesture;
- (UIPanGestureRecognizer *)getPanGesture;
- (void)evaluationSlideClickStatus:(BOOL)clickStatus;
- (BOOL)getSlideClickStatus;
- (ATBanner *)getPrivateBanner;
- (void)updateTrackClickAreaType:(ATClickAreaType)clickAreaType;
- (UIView *)getTrackView;

@end
#endif /* ATBanner_Internal_h */
NS_ASSUME_NONNULL_END
