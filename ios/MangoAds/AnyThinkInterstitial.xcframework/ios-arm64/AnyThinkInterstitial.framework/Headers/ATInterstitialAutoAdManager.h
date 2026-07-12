//
//  ATInterstitialAutoAdManager.h
//  AnyThinkInterstitial
//
//  Created by Jason on 2021/12/31.
//  Copyright © 2021 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AnyThinkInterstitial/ATInterstitialDelegate.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATInterstitialAutoAdManager : NSObject

@property(nonatomic, weak) id<ATAdLoadingDelegate> delegate;

+ (instancetype)sharedInstance;

- (void)addAutoLoadAdPlacementIDArray:(NSArray <NSString *> *)placementIDArray;
- (void)removeAutoLoadAdPlacementIDArray:(NSArray<NSString *> *)placementIDArray;

- (void)setLocalExtra:(NSDictionary * _Nullable)extra placementID:(NSString *)placementID;
- (BOOL)autoLoadInterstitialReadyForPlacementID:(NSString *)placementID;
- (NSArray<NSDictionary *> *)checkValidAdCachesWithPlacementID:(NSString *)placementID;
- (ATCheckLoadModel *)checkInterstitialLoadStatusForPlacementID:(NSString *)placementID;

- (void)showAutoLoadInterstitialWithPlacementID:(NSString*)placementID inViewController:(UIViewController*)viewController delegate:(id<ATInterstitialDelegate>)delegate;

- (void)showAutoLoadInterstitialWithPlacementID:(NSString*)placementID scene:( NSString* _Nullable )scene inViewController:(UIViewController*)viewController delegate:(id<ATInterstitialDelegate>)delegate DEPRECATED_MSG_ATTRIBUTE("use showAutoLoadInterstitialWithPlacementID:showConfig:showConfig:inViewController: delegate");

- (void)showAutoLoadInterstitialWithPlacementID:(NSString*)placementID showConfig:(ATShowConfig * _Nullable )showConfig inViewController:(UIViewController*)viewController delegate:(id<ATInterstitialDelegate>)delegate;


- (void)entryAdScenarioWithPlacementID:(NSString *)placementID scenarioID:(NSString *)scenarioID;

@end

NS_ASSUME_NONNULL_END
