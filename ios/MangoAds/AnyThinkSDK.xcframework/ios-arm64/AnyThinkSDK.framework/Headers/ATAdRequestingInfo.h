//
//  ATAdRequestingInfo.h
//  AnyThinkSDK
//
//  Created by GUO PENG on 2024/8/16.
//  Copyright © 2024 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATAdRequestingInfo : NSObject
/// 还在bidding的广告源（没有价格的）
@property (nonatomic, strong) NSArray<NSDictionary *> *biddingAdInfoArrray;
/// 还在请求中的更高价的广告源（有价格的）
@property (nonatomic, strong) NSArray<NSDictionary *> *loadingAdInfoArrray;

@end

NS_ASSUME_NONNULL_END
