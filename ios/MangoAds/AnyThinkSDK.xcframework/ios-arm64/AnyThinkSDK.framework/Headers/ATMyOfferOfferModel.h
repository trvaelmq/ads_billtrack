//
//  ATMyOfferOfferModel.h
//  AnyThinkMyOffer
//
//  Created by Martin Lau on 2019/9/23.
//  Copyright © 2019 Martin Lau. All rights reserved.
//

#import <AnyThinkSDK/ATOfferModel.h>
#import <AnyThinkSDK/ATMyOfferSetting.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATMyOfferOfferModel : ATOfferModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary placeholders:(NSDictionary *)placeholders format:(NSInteger)format setting:(ATMyOfferSetting *)setting;

@property (nonatomic, readwrite) ATScreenOrientation imageOrientation;
@property (nonatomic, readwrite) ATScreenOrientation videoOrientation;
@property (nonatomic, strong) NSString *videoStartTKURL;
@property (nonatomic, strong) NSString *video25TKURL;
@property (nonatomic, strong) NSString *video50TKURL;
@property (nonatomic, strong) NSString *video75TKURL;
@property (nonatomic, strong) NSString *videoEndTKURL;
@property (nonatomic, strong) NSString *endCardShowTKURL;
@property (nonatomic, strong) NSString *endCardCloseTKURL;
@property (nonatomic, strong) NSString *impURL;
@property (nonatomic, strong) NSString *impTKURL;
@property (nonatomic, strong) NSString *clickTKURL;
@property (nonatomic, assign) NSInteger dailyCap;
@property (nonatomic, assign) NSTimeInterval pacing;
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *placeholders;

@property (nonatomic, readwrite) ATClickMode performsAsynchronousRedirection;
@property (nonatomic, readwrite) ATAdOfferInterType interType;
@property (nonatomic, readwrite) ATUserAgentType impressionUAType;
@property (nonatomic, readwrite) ATUserAgentType clickUAType;
@property (nonatomic, strong) ATMyOfferSetting *myOfferSetting;
@property (nonatomic, strong) NSDictionary *offerDict;

/// when check placement myoffers cap mini come into effect, see -[ATPlacement miniCapForMyOffers]
@property (nonatomic, assign) NSInteger currentCap;

@end

NS_ASSUME_NONNULL_END
