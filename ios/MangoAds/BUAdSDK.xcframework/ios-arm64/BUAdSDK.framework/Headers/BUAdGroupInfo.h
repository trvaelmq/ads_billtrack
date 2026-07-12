//
//  BUAdGroupInfo.h
//  BUAdSDK
//
// Copyright © 2022年 bytedance. All rights reserved.
//

#import "BUInterfaceBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface BUAdGroupInfo :BUInterfaceBaseObject

/// ads should be grouped to show if the group_id is same;
@property (nonatomic, copy, readonly, nullable) NSString *group_id;
/// show the content of group_tag in the corner of the group container.
@property (nonatomic, copy, readonly, nullable) NSString *group_tag;
/// show the content of card_tag in the corner of the card in group container.
@property (nonatomic, copy, readonly, nullable) NSString *card_tag;

@end

NS_ASSUME_NONNULL_END
