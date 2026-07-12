//
//  ATMyOfferSetting.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 2019/9/23.
//  Copyright © 2019 Martin Lau. All rights reserved.
//

#import <AnyThinkSDK/ATOfferSetting.h>


@interface ATMyOfferSetting : ATOfferSetting

- (instancetype)initWithDictionary:(NSDictionary *)dictionary placementID:(NSString *)placementID;

@property (nonatomic, readwrite) NSTimeInterval resourceCacheTime;

@end
