//
//  WindNativeAd.h
//  WindSDK
//
//  Created by Codi on 2021/11/2.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, WindFeedADMode) {
    WindFeedADModeSmallImage = 2,
    WindFeedADModeLargeImage = 3,
    WindFeedADModeNativeExpress = 4,
    WindFeedADModeVideo = 14,
    WindFeedADModeVideoPortrait = 15,
    WindFeedADModeVideoLandSpace = 16,
};


@interface WindNativeAd : NSObject


/// Typed access to the ad title.
@property (nonatomic, copy, readonly) NSString *title;

/// Typed access to the body text, usually a longer description of the ad.
@property (nonatomic, copy, readonly) NSString *desc;

/// Typed access to the ad icon.
@property (nonatomic, copy, readonly) NSString *iconUrl;

/// Typed access to the call to action phrase of the ad.
@property (nonatomic, copy, readonly) NSString *callToAction;

/// Typed access to the ad image URL List.
@property (nonatomic, strong, readonly) NSArray *imageUrlList;

/// Typed access to the ad star rating.
@property (nonatomic, assign, readonly) double rating;

@property (nonatomic, assign, readonly) WindFeedADMode feedADMode;

/// 图片尺寸集合 @["{width,height}"]
@property (nonatomic, strong, readonly) NSArray *imageSizeList;

/// 视频宽
@property (nonatomic, assign, readonly) CGFloat videoWidth;

/// 视频高
@property (nonatomic, assign, readonly) CGFloat videoHeight;

///返回广告对应的ecpm（该接口需要在广告加载成功之后会返回对应的ecpm），
///当非竞价广告时或者没有权限访问该部分会返回nil 单位：分
- (NSString *)getEcpm;

/// invoke this method to set this actual auction price 调用此方法设置当前实际结算价
/// @param ecpm auction price 实际结算价格 单位分
- (void)setBidEcpm:(NSInteger)ecpm;

@end
