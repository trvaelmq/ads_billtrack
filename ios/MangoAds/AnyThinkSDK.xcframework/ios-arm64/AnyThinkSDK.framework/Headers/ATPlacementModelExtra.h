//
//  ATPlacementModelExtra.h
//  AnyThinkSDK
//
//  Created by GUO PENG on 2024/5/24.
//  Copyright © 2024 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATPlacementModelExtra : NSObject

@property(nonatomic, readonly) BOOL cachesPlacementSetting;
@property(nonatomic, readonly) NSTimeInterval defaultAdSourceLoadingDelay;
@property(nonatomic, readonly) NSInteger defaultNetworkFirmID;
@property(nonatomic, readonly) BOOL usesServerSettings;
@property(nonatomic, readonly) NSInteger countdown;
@property(nonatomic, readonly) BOOL allowsSkip;
@property(nonatomic, readonly) BOOL closeAfterCountdownElapsed;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
