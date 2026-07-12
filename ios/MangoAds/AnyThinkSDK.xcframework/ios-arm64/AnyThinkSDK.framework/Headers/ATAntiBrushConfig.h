//
//  ATAntiBrushConfig.h
//  AnyThinkSDK
//
//  Created by Captain on 2025/2/11.
//  Copyright © 2025 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATAntiBrushConfig : NSObject
@property (nonatomic, assign, readonly) BOOL isBrush;
@property (nonatomic, strong, readonly) NSArray <NSNumber *>* prohibitNetworks;


/// 防刷信息
/// - Parameters:
///   - isBrush: 是否为刷子设备
///   - prohibitNetworks:需要屏蔽平台的networkfirmid,  isBrush  = NO时不生效.  isBrush  = YES时 prohibitNetworks为空 则屏蔽所有平台
- (instancetype)initWithIsBrush:(BOOL)isBrush
               prohibitNetworks:(NSArray <NSNumber *>*)prohibitNetworks;

@end

NS_ASSUME_NONNULL_END
