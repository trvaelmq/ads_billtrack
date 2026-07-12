//
//  ATAPI+Internal.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 08/05/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef ATAPI_Internal_h
#define ATAPI_Internal_h
#import <AnyThinkSDK/ATAPI.h>


#define ATADLoadingErrorDomain @"com.anythink.ATADLoadingErrorDomain"
#define ATADShowingErrorDomain @"com.anythink.ATAdShowingErrorDomain"
#define ATSDKAdLoadingErrorMsg @"com.anythink.AdLoadingError"
#define ATSDKAdLoadFailedErrorMsg @"AnyThinkSDK has failed to load ad."

// AD Loading Notification
#define kATADLoadingStartLoadNotification @"ATADLoadingStartLoadNotification"
#define kATADLoadingOfferSuccessfullyLoadedNotification @"ADLoadingOfferSuccessfullyLoadedNotification"
#define kATADLoadingFailedToLoadNotification @"ATADLoadingFailedToLoadNotification"
#define kATADLoadingNotificationUserInfoRequestIDKey @"request_id"
#define kATADLoadingNotificationUserInfoPlacementIDKey @"placement_id"
#define kATADLoadingNotificationUserInfoPlacementKey @"placement_model"
#define kATADLoadingNotificationUserInfoUnitGroupKey @"unit_group_model"
#define kATADLoadingNotificationUserInfoErrorKey @"error"
#define kATADLoadingNotificationUserInfoExtraKey @"extra"
#define kATADLoadingNotificationUserInfoLoadingTypeKey @"loading_type"

/**
 Adopters are expected to implement logic for network offers, for which storage mechanisms must be devise.
 */
@protocol ATNativeAdapter<NSObject>
/**
 The class of the renderer used to render the AD view. This method is a class-method because by the time this information is needed the adapter instance will have been released.
 */
+ (Class)rendererClass;
/**
 Adopter should implement this method for the initialization of a adapter instance, which will store the passed info for further use.
 
 */
- (instancetype)initWithNetworkCustomInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo;

/**
 Adopter should implement this method to load network offers.
 
 @param completion might need to be stored and invoked after ad's succeffully loaded.
 Parameters passed to the completion block include a dictionary and an error objects. The error object encapsulates the error info if loading request failed somehow; the dictionary contains all publicly accessible assets (such as title and text) for the native ad, which should be stored using the keys predefined by the SDK.
 */
- (void)loadADWithInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo completion:(void(^)(NSArray<NSDictionary*>* assets, NSError *error))completion;

@property (nonatomic,copy) void (^metaDataDidLoadedBlock)(void);
@end

@interface ATAPI(Internal)

@property (nonatomic, strong) ATSharePlacementConfig *sharePlacementConfig;

+ (NSString *)hbTestModeDeviceID;
- (void)setVersion:(NSString*)version forNetwork:(NSString*)network;
- (NSString*)versionForNetworkFirmID:(NSInteger)networkFirmID;
- (BOOL)initFlagForNetwork:(NSString*)networkName;
- (void)setInitFlagForNetwork:(NSString*)networkName;
- (BOOL)cacheFlagForNetwork:(NSString*)networkName;
- (void)setCacheFlagForNetwork:(NSString*)networkName;
- (void)inspectInitFlagForNetwork:(NSString*)networkName usingBlock:(NSInteger(^)(NSInteger currentValue))block;
- (void)setInitFlag:(NSInteger)flag forNetwork:(NSString*)networkName;
@end

#endif /* ATAPI_Internal_h */
