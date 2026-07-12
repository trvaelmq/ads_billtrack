//
//  ATMediaVideoObject.h
//  AnyThinkMediaVideo
//
//  Created by li zhixuan on 2024/3/6.
//  Copyright © 2024 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/AnyThinkSDK.h>

#import <AnyThinkMediaVideo/ATMediaVideoDelegate.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ATMediaVideoOfferType) {
    ATMediaVideoOfferTypeUnknow,
    ATMediaVideoOfferTypeVAST,
    ATMediaVideoOfferTypeVMAP,
};

@interface ATMediaVideoOffer : NSObject

@property (nonatomic, readonly) ATShowConfig *showConfig;

@property (nonatomic, strong, nullable) UIView *loadView;

@property (nonatomic, assign) ATMediaVideoOfferType type;

- (instancetype)initWithAd:(id<ATAd>)ad showConfig:(ATShowConfig *)showConfig;

- (void)contentPlayhead:(id)contentPlayhead;

- (id)customNetworkObj;
- (id)adsManager;

- (void)start;
- (void)startWithViewController:(nullable UIViewController *)viewController;

- (void)pause;

- (void)resume;

- (void)destory;

- (void)contentComplete;

- (void)registerFriendlyObstruction:(id)friendlyObstruction;
- (void)unregisterAllFriendlyObstructions;

@end

NS_ASSUME_NONNULL_END
