//
//  ATDeviceInfoConfig.h
//  AnyThinkSDK
//
//  Created by GUO PENG on 2022/8/22.
//  Copyright © 2022 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AnyThinkSDK/ATUID2Info.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATDeviceInfoConfig : NSObject

@property (nonatomic, strong) NSString *idfaStr;

@property (nonatomic, strong) ATUID2Info *UID2Info;

@end

NS_ASSUME_NONNULL_END
