//
//  ATSplashManager.h
//  AnyThinkSplash
//
//  Created by Martin Lau on 2018/12/20.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/AnyThinkSDK.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kATSplashExtraContainerViewKey;
extern NSString *const kATSplashExtraNewBottomViewKey;
extern NSString *const kATSplashExtraWindowKey;
extern NSString *const kATSplashExtraInViewControllerKey;
extern NSString *const kATSplashExtraLoadingStartDateKey;
extern NSString *const kATSplashExtraBackgroundImageViewKey;
// Only supported by pangle, must be of UIImage type
extern NSString *const kATSplashExtraAppLogoImageKey;

extern NSString *const kATSplashExtraHeaderBiddingKey;


@class ATSplash;
@interface ATSplashManager : NSObject
+(instancetype) sharedManager;

//- (void)saveAdWithoutPlacementSetting:(ATSplash *)splash extra:(NSDictionary *)extra placementID:(NSString *)placementID;

//- (void)ckearDefaultSplash;

@end

NS_ASSUME_NONNULL_END
