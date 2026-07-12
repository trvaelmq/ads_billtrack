//
//  ATNativeAdOffer+Internal.h
//  AnyThinkNative
//
//  Created by Topon on 10/27/21.
//  Copyright © 2021 AnyThink. All rights reserved.
//

#import <AnyThinkNative/ATNativeAdOffer.h>


NS_ASSUME_NONNULL_BEGIN

@interface ATNativeAdOffer (Internal)

- (instancetype)initWithPlacementID:(NSString *)placementID scene:(NSString *)scene;
- (instancetype)initWithPlacementID:(NSString *)placementID config:(ATShowConfig *)config;

@end

NS_ASSUME_NONNULL_END
