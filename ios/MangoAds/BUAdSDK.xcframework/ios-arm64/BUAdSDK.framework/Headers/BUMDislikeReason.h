//
//  BUMDislikeReason.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUInterfaceBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface BUMDislikeReason : BUInterfaceBaseObject

- (instancetype)initWithID:(NSString *)ID name:(NSString *)name subReasons:(NSArray<BUMDislikeReason *> *)reasons;

@property (nonatomic, copy, readonly) NSString *ID;

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, copy, readonly) NSArray<BUMDislikeReason *> *subReasons;

@property (nonatomic, assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
