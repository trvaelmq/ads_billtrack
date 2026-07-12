//
//  ATCustomContentResult.h
//  AnyThinkSDK
//
//  Created by 抽筋的灯 on 2024/10/11.
//  Copyright © 2024 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ATCustomContentInfo;
@interface ATCustomContentResult : NSObject

@property (nonatomic, copy, readonly) NSArray<ATCustomContentInfo *> *contentInfoArray;

- (instancetype)initContentResultWithInfoArray:(NSArray *)contentInfoArray;

@end

NS_ASSUME_NONNULL_END
