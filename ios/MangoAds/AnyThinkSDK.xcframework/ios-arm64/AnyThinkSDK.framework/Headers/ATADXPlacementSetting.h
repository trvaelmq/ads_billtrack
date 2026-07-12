//
//  ATADXPlacementSetting.h
//  AnyThinkSDK
//
//  Created by stephen on 20/8/2020.
//  Copyright © 2020 AnyThink. All rights reserved.
//

#import <AnyThinkSDK/ATOfferSetting.h>


@interface ATADXPlacementSetting : ATOfferSetting

- (instancetype)initWithPlacementDictionary:(NSDictionary *)placementDictionary
                             infoDictionary:(NSDictionary *)infoDictionary
                                placementID:(NSString *)placementID
                             offerModelType:(ATOfferModelType)offerModelType ;

@end
