//
//  BUDislikeReportor.h
//  BUAdSDK
//
//  Created by bytedance on 2020/12/14.
//  Copyright © 2020 bytedance. All rights reserved.
//

#ifndef BUDislikeReportor_h
#define BUDislikeReportor_h
#import "BUInterfaceBaseObject.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BUDislikeWords;
/// the reportor for custom dislike
@protocol BUDislikeReportorDelegate <NSObject>
@optional
/// report selected dislike word
/// @param dislikeWords dislike words
- (void)dislikeDidSelected:(NSArray<BUDislikeWords *> *)dislikeWords;

/// report submit feedback string
/// @param feedback feedback string
- (void)dislikeDidSubmitFeedback:(NSString *)feedback;

@end

@class BUNativeAd;
/// Dislike Data Reportor for Native Ad
 __attribute__((objc_subclassing_restricted))
@interface BUDislikeReportor : BUInterfaceBaseObject <BUDislikeReportorDelegate>

/// Dislike Reportor Instance
/// @param nativeAd native Ad
// Mediation:/// @Note :  Mediation dimension does not support this interface.
- (instancetype)initWithNativeAd:(BUNativeAd *)nativeAd;

@end

NS_ASSUME_NONNULL_END
#endif /* BUDislikeReportor_h */
