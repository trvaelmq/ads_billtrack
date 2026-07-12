//
//  ATBanner.h
//  AnyThinkBanner
//
//  Created by Martin Lau on 18/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AnyThinkSDK/AnyThinkSDK.h>

@class ATBannerCustomEvent;

NS_ASSUME_NONNULL_BEGIN

@interface ATBanner : ATAdObject

@property(nonatomic, strong) __kindof UIView *bannerView;

@property (nonatomic, strong, nullable) ATBannerCustomEvent *customEvent;


- (void)destroyBanner;

@end

NS_ASSUME_NONNULL_END
