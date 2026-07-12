//
//  BUDislikeWords.h
//  BUAdSDK
//
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUInterfaceBaseObject.h"

NS_ASSUME_NONNULL_BEGIN
 __attribute__((objc_subclassing_restricted))
@interface BUDislikeWords : BUInterfaceBaseObject

@property (nonatomic, copy, readonly, nullable) NSString *dislikeID;
@property (nonatomic, copy, readonly, nullable) NSString *name;
@property (nonatomic, assign, readonly) BOOL isSelected;
@property (nonatomic, copy, readonly, nullable) NSArray<BUDislikeWords *> *options;

@end
NS_ASSUME_NONNULL_END
