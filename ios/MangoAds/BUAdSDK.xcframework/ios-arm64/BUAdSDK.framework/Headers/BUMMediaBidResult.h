//
//  BUMMediaBidResult.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUInterfaceBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface BUMMediaBidResult : BUInterfaceBaseObject

@property (nonatomic, assign, readonly) BOOL win;

@property (nonatomic, assign, readonly) NSInteger winnerPrice;

@property (nonatomic, copy, readonly) NSString *lossDescription;

@property (nonatomic, copy, readonly) NSString *winnerAdnID;

@property (nonatomic, copy, readonly) NSDictionary *ext;

@property (nonatomic, strong, readonly) id originNativeAdData;

@end

NS_ASSUME_NONNULL_END
