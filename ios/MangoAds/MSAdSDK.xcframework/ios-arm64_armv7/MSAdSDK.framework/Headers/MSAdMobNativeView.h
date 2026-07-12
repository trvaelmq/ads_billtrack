//
//  MSAdMobNativeView.h
//  MSAdSDK
//
//  Created by leej on 2022/9/17.
//  Copyright © 2022 Adxdata. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSAdMobNativeView : UIView
/**
 以下属性均已赋值，媒体无需赋值，仅可调整其内部属性
 */
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UIView *mediaView;
@property(nonatomic,strong)UILabel *bodyLabel;
@property(nonatomic,strong)UIButton *callToAction;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *storeLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UILabel *advertiserLabel;
//admob view
@property(nonatomic,strong)UIView *admobView;
@property(nonatomic,strong)UIButton *closeAction;
@end

NS_ASSUME_NONNULL_END
