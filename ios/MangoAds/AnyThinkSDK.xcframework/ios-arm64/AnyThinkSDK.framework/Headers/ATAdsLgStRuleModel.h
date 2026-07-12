//
//  ATAdsLgStRuleModel.h
//  AnyThinkSDK
//
//  Created by Captain on 2025/2/12.
//  Copyright © 2025 AnyThink. All rights reserved.
//

#import <AnyThinkSDK/ATModel.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ATAdRewardAntiCheatingNode) {
    ATAdRewardAntiCheatingNode_Bidding = 1,
    ATAdRewardAntiCheatingNode_BiddingResponse = 2,
    ATAdRewardAntiCheatingNode_AdSourceRequest = 3,
    ATAdRewardAntiCheatingNode_AdSourceFilling = 4,
    ATAdRewardAntiCheatingNode_WinLossNotification = 5,
    ATAdRewardAntiCheatingNode_Display = 6
};

@interface ATAdsLgStRuleModel : ATModel

@property (nonatomic, assign) BOOL vf_switch;
//@property (nonatomic, copy) NSArray *hb_vf_types;
//@property (nonatomic, copy) NSArray *wf_vf_types;
//@property (nonatomic, copy) NSString *vf_sk;
@property (nonatomic, assign) BOOL vf_switch_rv;
@property (nonatomic, copy) NSArray<NSNumber *> *hb_vf_types_rv; // 内含ATAdRewardAntiCheatingNode
@property (nonatomic, copy) NSArray<NSNumber *> *wf_vf_types_rv; // 内含ATAdRewardAntiCheatingNode
@property (nonatomic, assign) NSInteger networkFirmID;

@end

NS_ASSUME_NONNULL_END
