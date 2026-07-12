//
//  BUMAdViewWitnessChecker.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUInterfaceBaseObject.h"
#import "BUMViewTracker.h"

@interface BUMAdViewWitnessChecker : BUInterfaceBaseObject

+ (instancetype)sharedInstance;

+ (NSTimeInterval)getWitnessTimeForAd:(id)ad;

+ (void)setWitnessTimeForAd:(id)ad;

- (void)removeAd:()ad;

- (void)addViewTracker:(id<BUMViewTracker>)tracker;

- (void)removeAllTracker;

@end
