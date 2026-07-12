//
//  BURewardedVideoModel.h
//  BUAdSDK
//
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUInterfaceBaseObject.h"

// 进阶奖励只在CN有效
typedef NS_ENUM(NSInteger, BURewardType) {
    BURewardType_Default            = 0,       // 基础奖励
    BURewardType_Interact           = 1,       // 进阶奖励-互动
    BURewardType_VideoComplete      = 2,       // 进阶奖励-超过30s的视频播放完成
};
NS_ASSUME_NONNULL_BEGIN
__attribute__((objc_subclassing_restricted))
@interface BURewardedVideoModel : BUInterfaceBaseObject

/**
   optional.
   Third-party game user_id identity.
   Mainly used in the reward issuance, it is the callback pass-through parameter from server-to-server.
   It is the unique identifier of each user.
   In the non-server callback mode, it will also be pass-through when the video is finished playing.
   Only the string can be passed in this case, not nil.
 */
@property (nonatomic, copy, nullable) NSString *userId;

//optional. serialized string.
@property (nonatomic, copy, nullable) NSString *extra;

//reward name. It will assigned value when the ads back.
@property (nonatomic, copy, nullable) NSString *rewardName;

//number of rewards. It will assigned value when the ads back.
@property (nonatomic, assign) NSInteger rewardAmount;

//reward type.
@property (nonatomic, assign) BURewardType rewardType;

//number of rewards of propose, 0.0 ~ 1.0 (BURewardType_Default: 1).
@property (nonatomic, assign) float rewardPropose;

//advanced rewardTypes of the ads
//example: @[@(BURewardType_VideoComplete)]
@property (nonatomic, copy, nullable) NSArray *advancedRewardTypes;

/// optional. whether allow play again or not, default YES.
@property (nonatomic, assign) BOOL allowPlayAgain;

@end
NS_ASSUME_NONNULL_END
