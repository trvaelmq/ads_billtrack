//
//  BUMopubAdMarkUpDelegate.h
//  BUAdSDK
//
//  Created by Siwant on 2020/4/24.
//  Copyright © 2020 bytedance. All rights reserved.
//
// Mediation://  @Note :  Mediation dimension does not support this interface.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BUAdSlot;

@protocol BUMopubAdMarkUpDelegate <NSObject>
@optional

/** Mopub AdMarkUp
  */
- (void)setAdMarkup:(NSString *)adm;

/// Bidding Token. Now for MSDK in domestic, used for every ad type.
- (NSString *)biddingToken;

/** Mopub Adaptor get AD type from rit
  *   @return  @{@"adSlotType": @(1), @"renderType": @(1)}
  *   adSlotType refer from BUAdSlotAdType in "BUAdSlot.h"
  *   showType: @"1" express AD   @"2" native AD
  */
+ (nullable NSDictionary *)AdTypeWithRit:(NSString *)rit error:(NSError **)error;

/** Mopub bidding Adaptor get AD type from adm
  *  @return  @{@"adSlotType": @(1), @"renderType": @(1)}
  *  adSlotType refer from BUAdSlotAdType in "BUAdSlot.h"
  *  showType: @"1" express AD   @"2" native AD
  */
+ (NSDictionary *)AdTypeWithAdMarkUp:(NSString *)adm;

@end

NS_ASSUME_NONNULL_END
