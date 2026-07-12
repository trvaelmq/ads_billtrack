//
//  ATSelfRenderingMixSplashView.h
//  AnyThinkSDK
//
//  Created by GUO PENG on 2024/7/23.
//  Copyright © 2024 AnyThink. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATSelfRenderingMixSplashModel : NSObject

@property(nonatomic, strong) UILabel *textLabel;

@property(nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *skipButton;

@property(nonatomic, strong) UILabel *domainLabel;

@property(nonatomic, strong) UILabel *advertiserLabel;

@property(nonatomic, strong) UIImageView *iconImageView;

@property(nonatomic, strong) UIImageView *mainImageView;

@property (nonatomic, strong) UILabel *ctaLabel;


+ (instancetype)loadMixSplashModel: (void(^)(ATSelfRenderingMixSplashModel *mixSplashModel))mixSplashModelBlock;

@end

@interface ATSelfRenderingMixSplashView : UIView

/// 素材
@property (nonatomic, strong) NSDictionary *offerFodderDic;

@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) UIImage *logoImage;
@property (nonatomic, strong) UIImage *mainImage;


@property (nonatomic, strong) NSString *advertiserString;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *textString;
@property (nonatomic, strong) NSString *ctaString;
@property (nonatomic, strong) NSString *adWarnigString;
@property (nonatomic, strong) NSString *iconImageURLString;
@property (nonatomic, strong) NSString *mainImageURLString;
@property (nonatomic, strong) NSString *logoURLString;

@property (nonatomic, strong) NSString *sponsorString;
@property (nonatomic, strong) NSString *domainString;

// 获取媒体View
- (nullable UIView *)networkMediaView;
// 获取媒体 optionsView
- (nullable UIView *)networkOptionsView;

/// 自渲染广告 注册点击事件
/// - Parameter registerClickViewArray: 需要点击的视图
- (void)registerClickableViewArray:(nonnull NSArray<UIView *> *)registerClickViewArray;

/// 自渲染广告  绑定映射关系
- (void)bindViewRelation:(ATSelfRenderingMixSplashModel *)mixSplashModel;
/// 自渲染广告 关闭开屏广告
- (void)closeSplashAd;

// 获取媒体的摇一摇view
- (nullable UIView *)getNetworkShakeViewWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
