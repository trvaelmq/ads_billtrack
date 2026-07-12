//
//  ATAdCustomFilter.h
//  AnyThinkSDK
//
//  Created by Captain on 2025/3/5.
//  Copyright © 2025 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/AnyThinkSDK.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, ATAdCustomFilterBiddingMode) {
    ATAdCustomFilterBiddingModeNormal, // 常规
    ATAdCustomFilterBiddingModeS2S,    // S2S
    ATAdCustomFilterBiddingModeC2S,    // C2S
};

@interface ATAdCustomFilterEcpmItem : NSObject
/// 构造方法
/// 1: 同时设置, 过滤 [lessThenPrice, moreThenPrice]
/// 2: 只设置 moreThenPrice, 过滤 [moreThenPrice, + ∞]
/// 3: 只设置 lessThenPrice,  过滤[-∞, lessThenPrice]
/// - Parameters:
///   - moreThenPrice: moreThenPrice
///   - lessThenPrice: lessThenPrice
///   - currency: 币种
- (instancetype)initWithMoreThenPrice:(nullable NSString *)moreThenPrice
                        lessThenPrice:(nullable NSString *)lessThenPrice
                             currency:(ATBiddingCurrencyType)currency;
@end

@interface ATAdCustomFilterItem : NSObject

@end

@interface ATAdCustomFilter : NSObject

/// networkFirm IDs
- (ATAdCustomFilter *(^)(NSArray <NSNumber *>*))networkFirmIDs;
/// 广告源 ID
- (ATAdCustomFilter *(^)(NSArray <NSString *>*))adSourceIDs;
/// 三方adn 广告位 ID
- (ATAdCustomFilter *(^)(NSArray <NSString *>*))networkSlotIDs;
/// Ecpm
- (ATAdCustomFilter *(^)(ATAdCustomFilterEcpmItem *))ecpmItem;
/// 竞价类型
- (ATAdCustomFilter *(^)(NSArray <NSNumber *>*))biddingModes;
/// 开启一个新的过滤器 与其他过滤器是或的关系, 满足其中一个过滤器 就要过滤
- (ATAdCustomFilter *(^)(void))orFilter;

@end

NS_ASSUME_NONNULL_END
