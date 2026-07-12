//
//  ATSelfRenderingMixInterstitialView.h
//  AnyThinkSDK
//
//  Created by GUO PENG on 2023/11/13.
//  Copyright © 2023 AnyThink. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATSelfRenderingMixInterstitialModel : NSObject

@property(nonatomic, strong) UILabel *textLabel;

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UIView *ctaView;

@property(nonatomic, strong) UILabel *domainLabel;

@property(nonatomic, strong) UILabel *advertiserLabel;

@property(nonatomic, strong) UIImageView *iconImageView;

@property(nonatomic, strong) UIImageView *mainImageView;

+ (instancetype)loadMixInterstitialModel: (void(^)(ATSelfRenderingMixInterstitialModel *mixInterstitialModel))mixInterstitialModelBlock;

@end

@interface ATSelfRenderingMixInterstitialView : UIView
/// 素材
@property (nonatomic, strong) NSDictionary *offerFodderDic;

@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) NSString *advertiserString;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *textString;
@property (nonatomic, strong) NSString *ctaString;
@property (nonatomic, strong) NSString *adWarnigString;
@property (nonatomic, strong) NSString *iconImageURLString;
@property (nonatomic, strong) NSString *mainImageURLString;
@property (nonatomic, strong) NSString *sponsorString;
@property (nonatomic, strong) NSString *domainString;

// 获取媒体View
- (nullable UIView *)networkMediaView;
// 获取媒体 optionsView
- (nullable UIView *)networkOptionsView;


// 获取媒体自定义参数
- (nullable NSString *)getExtra;

// 设置关闭响应
- (void)registerClose:(nonnull UIView *)closeView;
// 设置点击响应
- (void)registerClickableViewArray:(nonnull NSArray<UIView *> *)registerClickViewArray;
// 关闭
- (void)close;
// 绑定映射关系
- (void)bindViewRelation:(ATSelfRenderingMixInterstitialModel *)mixInterstitialModel;
@end

NS_ASSUME_NONNULL_END
