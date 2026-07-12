//
//  ATInterstitial.h
//  AnyThinkInterstitial
//
//  Created by Martin Lau on 21/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/AnyThinkSDK.h>

@class ATInterstitialCustomEvent;
@class ATAdInterstitialEventPrams;

NS_ASSUME_NONNULL_BEGIN

@interface ATInterstitial : ATAdObject
@property (nonatomic, strong) ATAdInterstitialEventPrams *showPrams;
@property (nonatomic, strong) ATInterstitialCustomEvent *customEvent;
@property (nonatomic, assign) BOOL isNativeInterstitial;
@property (nonatomic, strong) NSDictionary *assets;
@property (nonatomic, strong) id delegateObject;

@property (nonatomic, assign) NSInteger clickTag;
@property (nonatomic, weak) UIViewController *currentInterstitialAdVc;// 当前正在展现的插屏广告vc
@end

NS_ASSUME_NONNULL_END
