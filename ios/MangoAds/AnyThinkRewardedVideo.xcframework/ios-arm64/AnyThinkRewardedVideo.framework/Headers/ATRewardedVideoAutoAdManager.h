//
//  ATRewardedVideoAutoAdManager.h
//  AnyThinkRewardedVideo
//
//  Created by Jason on 2021/12/31.
//  Copyright © 2021 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AnyThinkRewardedVideo/ATRewardedVideoDelegate.h>


NS_ASSUME_NONNULL_BEGIN

@interface ATRewardedVideoAutoAdManager : NSObject

@property(nonatomic, weak) id<ATAdLoadingDelegate> delegate;

+ (instancetype)sharedInstance;

- (void)addAutoLoadAdPlacementIDArray:(NSArray <NSString *> *)placementIDArray;
- (void)removeAutoLoadAdPlacementIDArray:(NSArray<NSString *> *)placementIDArray;


- (void)setLocalExtra:(NSDictionary *)extra placementID:(NSString *)placementID;
- (BOOL)autoLoadRewardedVideoReadyForPlacementID:(NSString *)placementID;
- (nullable NSArray<NSDictionary *> *)checkValidAdCachesWithPlacementID:(NSString *)placementID;
- (nullable ATCheckLoadModel *)checkRewardedVideoLoadStatusForPlacementID:(NSString *)placementID;

- (void)showAutoLoadRewardedVideoWithPlacementID:(NSString*)placementID inViewController:(UIViewController*)viewController delegate:(id<ATRewardedVideoDelegate>)delegate;

- (void)showAutoLoadRewardedVideoWithPlacementID:(NSString*)placementID scene:( NSString* _Nullable )scene inViewController:(UIViewController*)viewController delegate:(id<ATRewardedVideoDelegate>)delegate DEPRECATED_MSG_ATTRIBUTE("use showAutoLoadRewardedVideoWithPlacementID:showConfig:showConfig:inViewController: delegate");

- (void)showAutoLoadRewardedVideoWithPlacementID:(NSString*)placementID showConfig:( ATShowConfig* _Nullable )showConfig inViewController:(UIViewController*)viewController delegate:(id<ATRewardedVideoDelegate>)delegate;

- (void)entryAdScenarioWithPlacementID:(NSString *)placementID scenarioID:(NSString *)scenarioID;

@end

NS_ASSUME_NONNULL_END
