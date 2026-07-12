//
//  ATAdErrorCode.h
//  AnyThinkSDK
//
//  Created by Topon on 2024/5/27.
//  Copyright © 2024 AnyThink. All rights reserved.
//

#ifndef ATAdErrorCode_h
#define ATAdErrorCode_h

typedef NS_ENUM(NSInteger, ATAdErrorCode) {
    ATAdErrorCodePlacementStrategyInvalidResponse             = 1001,
    ATAdErrorCodePlacementStragetyNetworkError                = 1002,
    ATAdErrorCodeADOfferLoadingFailed                         = 1003,
    ATAdErrorCodePlacementStrategyNotFound                    = 1004,
    ATAdErrorCodeADOfferNotFound                              = 1005,
    ATAdErrorCodeShowIntervalWithinPlacementPacing            = 1006,
    ATAdErrorCodeShowTimesExceedsHourCap                      = 1007,
    ATAdErrorCodeShowTimesExceedsDayCap                       = 1008,
    ATAdErrorCodeAdapterClassNotFound                         = 1009,
    ATAdErrorCodeADOfferLoadingTimeout                        = 10010,
    ATAdErrorCodeSDKNotInitalizedProperly                     = 1011,
    ATAdErrorCodeDataConsentForbidden                         = 1012,
    ATAdErrorCodeThirdPartySDKNotImportedProperly             = 1013,
    ATAdErrorCodeInvalidInputEncountered                      = 1014,
    ATAdErrorCodePlacementAdDeliverySwitchOff                 = 1015,
    ATAdErrorCodePreviousLoadNotFinished                      = 1016,
    ATAdErrorCodeNoUnitGroupsFoundInPlacement                 = 1017,
    ATAdErrorCodeUnitGroupsFilteredOut                        = 1018,
    ATAdErrorCodeFailureTooFrequent                           = 1019,
    ATAdErrorCodeLoadCapsExceeded                             = 1020,
    ATAdErrorCodeUnitGroupsExpired                            = 1021,
    ATAdErrorCodeDebuggerNoUnitGroupsFoundInPlacement         = 1029,
    ATAdErrorCodeAdSourceNotFilledCauseByCustomizeFillter     = 1030,
    ATAdErrorCodeCanNotLoadWhenAppBackground                  = 1031,
    ATAdErrorCodeCanNotLoadSharePlacement                     = 10019,
    ATAdErrorCodeADXFailedCode                                = 3001,
    
    ATAdErrorCodeAdSourceIDFilter                             = 2010,
    ATAdErrorCodeNetworkFirmFilter                            = 2013,
    ATAdErrorCodeAPPLoadPaceCapLimt                           = 2023,
    ATAdErrorCodeFormatLoadPaceCapLimt                        = 2024,
    ATAdErrorCodeAPPLoadCapDayLimt                            = 2025,
    ATAdErrorCodeFormatLoadCapDayLimt                         = 2026,
    ATAdErrorCodeAPPLoadCapHourLimt                           = 2027,
    ATAdErrorCodeFormatLoadCapHourLimt                        = 2028,
    ATAdErrorCodeAPPShowPaceCapLimt                           = 2029,
    ATAdErrorCodeFormatShowPaceCapLimt                        = 2030,
    ATAdErrorCodeAdSourceLoadRisk                             = 2031,
    ATAdErrorCodeAdSourceLoadBidTypeFilter                    = 2032,
    ATAdErrorCodeAdSourceLoadPriceFilter                      = 2033,
    ATAdErrorCodeAdSourceLoadUnitFilter                       = 2034,
};

#endif /* ATAdErrorCode_h */
