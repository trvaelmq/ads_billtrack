//
//  ATAdDeveloperMaterialInfo.h
//  AnyThinkSDK
//
//  Created by Captain on 2025/2/24.
//  Copyright © 2025 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATAdDeveloperMaterialInfo : NSObject
@property (nonatomic, copy, readonly) NSString *adTitle;
@property (nonatomic, copy, readonly) NSString *adUserName;

- (instancetype)initWithAdTitle:(NSString *)adTitle adUserName:(NSString *)adUserName;
@end

NS_ASSUME_NONNULL_END
