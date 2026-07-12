//
//  ATRewardedVideo.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 28/06/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/AnyThinkSDK.h>

NS_ASSUME_NONNULL_BEGIN

@class ATRewardedVideoCustomEvent;

@interface ATRewardedVideo : ATAdObject

@property (nonatomic, strong) ATRewardedVideoCustomEvent *customEvent;
@property (nonatomic, strong) NSString *appID;

@end

NS_ASSUME_NONNULL_END
