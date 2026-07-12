//
//  BUMDislikeReporter.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUInterfaceBaseObject.h"
#import "BUMDislikeReason.h"

@class BUNativeAd;

/// dislike的原因上报句柄
@interface BUMDislikeReporter : BUInterfaceBaseObject

/// Dislike Reportor Instance
/// @param nativeAd native Ad
- (instancetype)initWithNativeAd:(BUNativeAd *)nativeAd;

/// 原因，不喜欢该广告的原因，由adn通过adapter提供
@property (nonatomic, copy, readonly) NSArray<BUMDislikeReason *> *reasons;

/// 选中了某个原因
/// @param ID 原因的唯一标识
- (void)didSelectedReasonWithID:(NSString *)ID;

/// 取消选中了某个原因
/// @param ID 原因的唯一标识
- (void)didUnselectedReasonWithID:(NSString *)ID;

/// 提交最终结果
- (void)submit;

@end
