//
//  ATPlatfromInfo.h
//  AnyThinkSDK
//
//  Created by GUO PENG on 2024/5/24.
//  Copyright © 2024 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ATRevenueToPlatform) {
    ATRevenueToPlatformAdjust = 1,
    ATRevenueToPlatformAppsflyer = 2,
    ATRevenueToPlatformTenjin
};


@interface ATPlatfromInfo : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property(nonatomic) ATRevenueToPlatform platform;
@property(nonatomic) NSInteger dataType;
@property(nonatomic, copy) NSString *token;

@end

NS_ASSUME_NONNULL_END
