//
//  ATCustomContentInfo.h
//  AnyThinkSDK
//
//  Created by Captain on 2024/9/21.
//  Copyright © 2024 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATCustomContentInfo : NSObject

@property (nonatomic, copy, readonly) NSString *customContentString;
/// default -1
@property (nonatomic, assign, readonly) double customContentDouble;

@property (nonatomic, strong, readonly) id customContentObject;

@property (nonatomic, strong) NSDictionary *adOfferInfo;

- (instancetype)initInfoWithContentString:(NSString *)customContentString
                            contentObject:(id)contentObject;

- (instancetype)initInfoWithContentDouble:(double)customContentDouble
                            contentObject:(id)contentObject;



@end

NS_ASSUME_NONNULL_END
