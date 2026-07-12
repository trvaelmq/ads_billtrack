//
//  ATNativeADCache.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 17/04/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AnyThinkNative/ATNativeAd.h>
#import <AnyThinkNative/ATNativeADCustomEvent.h>

@class ATUnitGroupModel;
@class ATPlacementModel;

NS_ASSUME_NONNULL_BEGIN

@interface ATNativeADCache : ATNativeAd

@property(nonatomic) NSNumber *sdkTime;
@property(nonatomic, readwrite) ATNativeADCustomEvent *customEvent;

@property(atomic, readonly) NSDictionary *assets;//To be removed

/**
 * Third-party network unit id.
 */
@property(nonatomic, assign)NSInteger priorityIndex;

@property(nonatomic, readonly) NSString *iconURLString;
@property(nonatomic, readonly) NSString *imageURLString;

@property(nonatomic) BOOL adReportClicked;
@property(nonatomic) BOOL adViewHasShowToWindow;
@property(nonatomic) BOOL adHasReportImpression;

@end

NS_ASSUME_NONNULL_END
