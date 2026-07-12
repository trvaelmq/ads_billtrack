//
//  ABUUserConfig.h
//  ABUAdSDK
//
//  Created by Makaiwen on 2021/5/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BUMAdWidgetViewType) { // 当前仅百度
    BUMAdWidgetViewCouponFlip       = 0, // 百度flip 翻页
    BUMAdWidgetViewCouponSuspension = 1, // 百度suspension 优惠券
    BUMAdWidgetViewBarrage          = 2, // 百度barrage 弹幕
    BUMAdWidgetViewRotate           = 3, // 快手 扭动组件
};

typedef NS_ENUM(NSUInteger, BUMCouponType) {
    BUMCouponSuspensionDefault       = 0,
    BUMCouponSuspensionCard          = 1,
    BUMCouponSuspensionIcon          = 2,
    BUMCouponFlipDefault             = 3
};

@interface BUMAdViewWidget : NSObject
// 组件类型
@property (nonatomic, assign, readonly) BUMAdWidgetViewType widgetViewType;

// 所属广告视图
@property (nonatomic, strong, readonly) UIView *adView;

// 百度coupon样式下，类型（当widgetViewType为 BUMAdWidgetViewCouponFlip、BUMAdWidgetViewCouponSuspension时，有有效值）
@property (nonatomic, assign, readonly) BUMCouponType couponType;

// 调用此方法，传入尺寸后，渲染组件视图，并取得组件视图（当前仅支持百度，官方建议如下）
/**
 弹幕组件（BUMAdWidgetViewBarrage）使用时，传入的宽度需要大于120pt
 翻页组件（BUMAdWidgetViewCouponFlip），默认组件大小154*154，不建议修改组件frame，可通过动画修改视图尺寸
 优惠券组件（BUMAdWidgetViewCouponSuspension）组件初始化不建议修改frame，可通过动画调整整体大小
 */
- (UIView *)renderWithFrame:(CGRect)frame;
@end

@protocol BUMAdViewWidgetProtocol <NSObject>

// 组件视图
@property (nonatomic, strong) UIView *widgetView;

// 组件类型
@property (nonatomic, assign) BUMAdWidgetViewType widgetViewType;

// 所属广告视图
@property (nonatomic, strong) UIView *adView;

// 百度coupon样式下，类型（当widgetViewType为 BUMAdWidgetViewCouponFlip、BUMAdWidgetViewCouponSuspension时，有有效值）
@property (nonatomic, assign) BUMCouponType couponType;

// 调用此方法，传入尺寸后，渲染组件视图
- (UIView *)renderWithFrame:(CGRect)frame;

@property (nonatomic, copy) id barrageBlock;

@property (nonatomic, copy) id suspensionBlock;

@property (nonatomic, copy) id flipBlock;

@property (nonatomic, copy) id rotateViewBlock;

@end

NS_ASSUME_NONNULL_END
