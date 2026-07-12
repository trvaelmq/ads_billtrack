//
//  ATNativeBannerView.h
//  AnyThinkSDK
//
//  Created by GUO PENG on 2023/6/8.
//  Copyright © 2023 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <AnyThinkSDK/ATScrollLabel.h>
#import <AnyThinkSDK/ATUnitGroupModel.h>



NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ATNativeBannerSizeType) {
    ATNativeBannerSizeTypeSmall,// 320 * 50
    ATNativeBannerSizeTypeMiddle,// 320 * 90
    ATNativeBannerSizeTypeBig,// 300 * 250
    ATNativeBannerSizeTypeLARGE,// 728 * 90
};



@interface ATNativeBannerView : UIView

/// domain
@property(nonatomic, strong) UILabel *domainLabel;
/// 警告
@property(nonatomic, strong) UILabel *warningLabel;


/// 广告商
@property(nonatomic, strong) UILabel *advertiserLabel;

/// 广告内容
@property(nonatomic, strong) UILabel *textLabel;

/// 广告标题
@property(nonatomic, strong) UILabel *titleLabel;


/// 下载
@property(nonatomic, strong) UILabel *ctaLabel;

/// 评分
@property(nonatomic, strong) UILabel *ratingLabel;
/// 赞助商
@property(nonatomic, strong) UILabel *sponsorLabel;

/// adImageView
@property(nonatomic, strong) UIImageView *adImageView;

/// icon
@property(nonatomic, strong) UIImageView *iconImageView;

/// 主图
@property(nonatomic, strong) UIImageView *mainImageView;

/// logo
@property(nonatomic, strong) UIImageView *logoImageView;

/// dislike
@property(nonatomic, strong) UIButton *dislikeButton;

/// 三方SDKMediaView
@property (nonatomic, strong) UIView *netWorkMediaView;
@property (nonatomic, strong) UIView *netWorkMediaBackView;

/// 三方SDKOptionView
@property (nonatomic, strong) UIView *netWorkOptionView;

/// TopOn渲染展示横幅尺寸
@property (nonatomic, assign) ATNativeBannerSizeType nativeBannerSizeType;
/// 广告渲染类型
@property (nonatomic, assign) ATRenderingType nativeBannerRenderType;


- (BOOL)isVideoContents;

/// 获取自渲染摇一摇视图
- (UIView *)getNetworkShakeViewWithFrame:(CGRect)frame;

/// 自渲染广告 注册点击事件
/// - Parameter registerClickViewArray: 需要点击的视图
- (void)registerClickableViewArray:(NSArray <UIView *>*)registerClickViewArray;


#pragma mark - 广告素材
@property (nonatomic, strong) NSDictionary *configurationDic;

@property (nonatomic, strong) UIImage *iconImage;

@property (nonatomic, strong) NSString *advertiserString;

@property (nonatomic, strong) NSString *titleString;

@property (nonatomic, strong) NSString *textString;

@property (nonatomic, strong) NSString *ctaString;

@property (nonatomic, strong) NSString *adWarnigString;

@property (nonatomic, strong) NSString *domainString;

@property (nonatomic, strong) NSString *iconImageURLString;

@property (nonatomic, strong) NSString *mainImageURLString;

@property (nonatomic, strong) NSString *sponsorString;

@property (nonatomic, strong) NSString *customExtString;

@property (nonatomic, strong) NSString *logoString;

@end

NS_ASSUME_NONNULL_END
