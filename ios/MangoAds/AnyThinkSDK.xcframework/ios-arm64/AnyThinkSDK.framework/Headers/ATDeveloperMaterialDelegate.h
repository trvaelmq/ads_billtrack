//
//  ATDeveloperMaterialDelegate.h
//  AnyThinkSDK
//
//  Created by Captain on 2025/2/24.
//  Copyright © 2025 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ATDeveloperMaterialDelegate <NSObject>

/// 展示时传入的素材信息
/// - Parameters:
///   - placementID: placementID
///   - networkAdObj: adn的广告对象
///   - extra: extra
- (ATAdDeveloperMaterialInfo *)materialInfoDetailsWhenShowWithPlacementID:(NSString *)placementID
                                                             networkAdObj:(id)networkAdObj
                                                                    extra:(NSDictionary *)extra;


/// 点击时传入的素材信息
/// - Parameters:
///   - placementID: placementID
///   - networkAdObj: adn的广告对象
///   - extra: extra
- (ATAdDeveloperMaterialInfo *)materialInfoDetailsWhenClickWithPlacementID:(NSString *)placementID
                                                              networkAdObj:(id)networkAdObj
                                                                     extra:(NSDictionary *)extra;
@end

NS_ASSUME_NONNULL_END
