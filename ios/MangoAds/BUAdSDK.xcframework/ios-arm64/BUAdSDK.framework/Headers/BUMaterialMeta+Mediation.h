//
//  BUMaterialMeta+Mediation.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUMaterialMeta.h"
#import "BUImage.h"

@protocol BUMaterialMetaMediationProtocol;
typedef NSObject<BUMaterialMetaMediationProtocol> BUMaterialMetaMediation;

NS_ASSUME_NONNULL_BEGIN

@interface BUMaterialMeta (Mediation)

// 当使用聚合广告位时，存在该属性，可获取聚合维度相关功能
@property (nonatomic, strong, nullable, readonly) BUMaterialMetaMediation *mediation;

@end



@protocol BUMaterialMetaMediationProtocol <NSObject>

/// 广告adn的logo，如果logo有宽高，请尽量配置width和height
@property (nonatomic, strong, readonly, nullable) BUImage *adLogo;

/// 广告标识图标，目前只有百度返回
@property (nonatomic, strong, readonly, nullable) BUImage *adTextLogo;

/// 视频纵横比(width/height)，如果没有值或者异常返回0
@property (nonatomic, assign, readonly) CGFloat videoAspectRatio;

/// app购买价格，例如'免费'，没有则为nil
@property (nonatomic, strong, readonly, nullable) NSString *appPrice;

/// 广告商标识，广告商的名称或者链接
@property (nonatomic, copy, readonly, nullable) NSString *advertiser;

/// 品牌名称，若广告返回中无品牌名称则为空
@property (copy, nonatomic, readonly, nullable) NSString *brandName;

@end


NS_ASSUME_NONNULL_END
