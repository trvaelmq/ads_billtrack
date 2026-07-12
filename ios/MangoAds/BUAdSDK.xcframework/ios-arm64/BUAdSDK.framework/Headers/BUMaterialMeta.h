//
//  BUMaterialMeta.h
//  BUAdSDK
//
//  Copyright © 2017 bytedance. All rights reserved.
//
// Mediation:// SDK从5.1.5.0版本支持聚合维度广告加载，当加载聚合维度广告时，部分设置及回调受最终展示的adn是否提供支持。

#import "BUInterfaceBaseObject.h"
#import "BUDislikeWords.h"
#import "BUImage.h"
#import "BUAdGroupInfo.h"
typedef NS_ENUM(NSInteger, BUInteractionType) {
    BUInteractionTypeCustorm = 0,
//    BUInteractionTypeNO_INTERACTION = 1,  // pure ad display
    BUInteractionTypeURL = 2,             // open the webpage using a browser
    BUInteractionTypePage = 3,            // open the webpage within the app
    BUInteractionTypeDownload = 4,        // download the app
//    BUInteractionTypePhone = 5,           // make a call
//    BUInteractionTypeMessage = 6,         // send messages
//    BUInteractionTypeEmail = 7,           // send email
    BUInteractionTypeVideoAdDetail = 8,    // video ad details page
    BUInteractionTypeMediationOthers  = 100 //聚合其他广告sdk返回的类型
};

typedef NS_ENUM(NSInteger, BUFeedADMode) {
    BUFeedADModeSmallImage = 2,
    BUFeedADModeLargeImage = 3,
    BUFeedADModeGroupImage = 4,
    BUFeedVideoAdModeImage = 5, // video ad || rewarded video ad horizontal screen
    BUFeedVideoAdModePortrait = 15, // rewarded video ad vertical screen
    BUFeedADModeImagePortrait = 16,
    BUFeedADModeSquareImage   = 33, //SquareImage Currently it exists only in the oversea now. V3200 add
    BUFeedADModeSquareVideo   = 50, //SquareVideo Currently it exists only in the oversea now. V3200 add
    BUFeedADModeUnionSplashVideo = 154, // Video splash, V3800 add
    BUFeedADModeLiveStream    = 166, // Live Stream Ad. v5200 add
    BUFeedADModeUnionVerticalImage = 173, // vertical picture
    BUFeedADModeUnionAtlas = 180, // atlas
    BUFeedADModeMediationUnknown = 1000 //聚合其他广告sdk未知
};
NS_ASSUME_NONNULL_BEGIN
 __attribute__((objc_subclassing_restricted))
@interface BUMaterialMeta : BUInterfaceBaseObject

/// interaction types supported by ads.
/// Please note: This API does not take effect on Pangle global, only use it when you have traffic from mainland China.
@property (nonatomic, assign, readonly) BUInteractionType interactionType;

/// material pictures.
@property (nonatomic, strong, readonly, nullable) NSArray<BUImage *> *imageAry;

/// ad logo icon.
@property (nonatomic, strong, readonly, nullable) BUImage *icon;

/// ad headline.
@property (nonatomic, copy, readonly, nullable) NSString *AdTitle;

/// ad description.
@property (nonatomic, copy, readonly, nullable) NSString *AdDescription;

/// ad source.
@property (nonatomic, copy, readonly, nullable) NSString *AdSource;

/// use AdSource instead.
@property (nonatomic, copy, nullable) NSString *source __attribute__((deprecated("Use AdSource instead.")));

/// text displayed on the creative button.
@property (nonatomic, copy, readonly, nullable) NSString *buttonText;

/// display format of the in-feed ad, other ads ignores it.
@property (nonatomic, assign, readonly) BUFeedADMode imageMode;

/// Star rating, range from 1 to 5.
/// Please note: This API does not take effect on Pangle global, only use it when you have traffic from mainland China.
@property (nonatomic, assign, readonly) NSInteger score;

/// Number of comments.
/// Please note: This API does not take effect on Pangle global, only use it when you have traffic from mainland China.
@property (nonatomic, assign, readonly) NSInteger commentNum;

/// ad installation package size, unit byte.
@property (nonatomic, assign, readonly) NSInteger appSize;

/// video duration
/// Please note: This API does not take effect on Pangle global, only use it when you have traffic from mainland China.
@property (nonatomic, assign, readonly) NSInteger videoDuration;

/// video url, will be empty string if allowCustomVideoPlayer is NO, contact BD to add to allow list.
@property (nonatomic, copy, readonly, nullable) NSString *videoUrl;

/// be allowed to play video ad via custome player, contact BD to add to allow list.
@property (nonatomic, assign, readonly, readonly) BOOL allowCustomVideoPlayer;

/// video resolution width
@property (nonatomic, assign, readonly, readonly) NSInteger videoResolutionWidth;

/// video resolution height
@property (nonatomic, assign, readonly, readonly) NSInteger videoResolutionHeight;

/// the reason why dislike the ad.
@property (nonatomic, copy, readonly, nullable) NSArray<BUDislikeWords *> *filterWords;

/// media configuration parameters.
/// Please note: This API does not take effect on Pangle global, only use it when you have traffic from mainland China.
@property (nonatomic, copy, readonly, nullable) NSDictionary *mediaExt;

/// adx name, if it exists, it is recommended to display this text
@property (nonatomic, copy, readonly, nullable) NSString *ADXName;

// ONLY EXSISTS IN CSJ
// Ads should be grouped by groupId if it exists.
@property (nonatomic, strong, readonly, nullable) BUAdGroupInfo *groupInfo;

@end
NS_ASSUME_NONNULL_END
