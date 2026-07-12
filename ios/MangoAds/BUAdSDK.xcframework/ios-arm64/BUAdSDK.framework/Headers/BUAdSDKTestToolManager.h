//
//  BUAdSDKTestToolManager.h
//  BUAdSDK
//
//  Created by wangyanlin on 2020/4/14.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUInterfaceBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^BUPreviewConfigBlock)(BOOL success, NSError *error, NSDictionary *config);

__attribute__((objc_subclassing_restricted))
@interface BUAdSDKTestToolManager : BUInterfaceBaseObject

+ (instancetype)sharedInstance;

+ (void)setHostIP:(NSString *)hostIP;

+ (void)setHostPort:(NSString *)hostPort;

+ (void)setInputOneContent:(NSString *)oneContent;

+ (void)setInputTwoContent:(NSString *)twoContent;

+ (void)clearIPAddress;

+ (void)clearInputContent;

- (NSString *)testTimeStamp;

+ (void)configStylePreviewInfo:(NSDictionary*)info complete:(BUPreviewConfigBlock)complete;

@end
NS_ASSUME_NONNULL_END

