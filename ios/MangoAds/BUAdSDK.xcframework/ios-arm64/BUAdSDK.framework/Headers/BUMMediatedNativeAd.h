//
//  BUMMediatedNativeAd.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUInterfaceBaseObject.h"
#import "BUMMediatedNativeAdData.h"
#import "BUMMediatedNativeAdViewCreator.h"

NS_ASSUME_NONNULL_BEGIN

@interface BUMMediatedNativeAd : BUInterfaceBaseObject

// 广告物料，包含有最全的广告数据
@property (nonatomic, strong, nonnull) id<BUMMediatedNativeAdData> data;

// 广告视图创建对象，对常用广告展示元素进行创建（存在意义：对部分adn创建特定视图的支持）
@property (nonatomic, strong, nonnull) id<BUMMediatedNativeAdViewCreator> viewCreator;

// 广告视图对象（存在意义：对部分adn创建特定视图的支持）
@property (nonatomic, strong, nonnull) UIView *view;

// adn获取到的原始广告数据
@property (nonatomic, strong, nonnull) id originMediatedNativeAd;


@end

NS_ASSUME_NONNULL_END
