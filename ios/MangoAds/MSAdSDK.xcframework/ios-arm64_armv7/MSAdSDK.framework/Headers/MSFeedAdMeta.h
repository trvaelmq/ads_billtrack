//
//  MSFeedAdMeta.h
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/7/31.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef MSFeedAdMeta_h
#define MSFeedAdMeta_h

typedef NS_ENUM(NSInteger, MSCreativeType) {
    MSCreativeTypeImage      = 1, // 图片
    MSCreativeTypeVideo      = 2, // 视频
    MSCreativeTypeSmallImage = 11, // 小图
    MSCreativeTypeLargeImage = 12, // 大图
    MSCreativeTypeThreeImage = 13, // 三图
    MSCreativeTypePrerender  = 100000, // 预渲染
};
typedef NS_ENUM(NSInteger, MSAdInteractionType) {
    MSAdInteractionNormalType = 0, // 普通交互
    MSAdInteractionRockType   = 1, // 摇一摇交互
    MSAdInteractionTwistType  = 2, // 扭一扭交互
};
@protocol MSFeedAdMeta <NSObject>

- (MSCreativeType)metaCreativeType;//类型

- (NSString * _Nullable)metaTitle;//标题

- (NSString * _Nullable)metaContent;//内容

- (NSString * _Nullable)metaIcon;//广告图标

- (UIImageView * _Nonnull)metaLogo;//平台Logo

- (NSString * _Nullable)metaSource;//来源

- (NSString * _Nullable)metaAppScore;//应用评分 应用类广告的星级（5星制度）【支持平台：穿山甲、快手、广点通】

- (NSString * _Nullable)metaAppCommentNum;//应用评论数【支持平台：穿山甲】

- (NSString * _Nullable)metaAppSize;//应用大小【支持平台：穿山甲】

- (NSString * _Nullable)metaAppPrice;//应用价格【支持平台：广点通】

- (NSString * _Nullable)metaAdxName;//adx 名称【支持平台：穿山甲】

- (NSString * _Nullable)metaAppDownloadCountDesc;//应用下载数【支持平台：快手】

- (CGSize)metaMainImageSize;//主图图片尺寸
/**
 获取图片素材
 注意：如果素材是视频类型，该接口返回封面，封面可能为空【封面支持平台：MS】
 */
- (NSArray<NSString *> * _Nullable)metaImageUrls;//多图信息流

- (NSString * _Nullable)metaVideoUrl;//信息流视频（支持平台：MS）

- (NSTimeInterval)metaVideoDuration;//视频时长

- (NSInteger)metaTargetType;//广告交互类型(0:网页跳转,1:下载) 默认 值:0

- (NSString * _Nullable)metaFromId;

- (MSPlatform)metaPlatform;//广告物料归属平台

- (NSString * _Nullable)metaActionTitle;//引导语[立即下载、查看详情等]

- (NSString * _Nullable)metaCustomPlatformIdentifier;//自定义平台标识
/**
 提示：2.2.16.0及以上版本逻辑调整
 广告交互仅支持摇一摇/扭一扭触发一次，摇一摇/扭一扭触发后交互类型将调整为普通交互类型，媒体在收到点击回调后根据交互类型刷新交互图标
 如交互类型为普通交互则不再展示摇一摇或扭一扭图标
 */
- (MSAdInteractionType)metaAdInteractionType;//广告点击交互(仅MS渠道支持该配置)

- (UIImageView * _Nullable)metaShakeTwistImageView;//摇一摇或扭一扭图标 注意广告交互为摇一摇或扭一扭才存在该图标(仅MS渠道支持该配置)

#pragma mark- Action
/**
 设置logo frame 绑定事件前传入
 注意：frame设置不要超出展示广告容器frame范围，否则可能展示不出logo
 */
- (void)setMetaLogoFrame:(CGRect)frame;
/**
 隐藏广告logo及品牌logo
 调用时机：attachAd前
 注意：视频类型广告隐藏logo也是通过该方法
 */
- (void)hiddenAdLogo;
/**
 绑定子控件【使用特殊平台自渲染广告该方法必须调用】
 调用时机：attachAd前
 注意：
 1、特殊平台调用该接口，传入的子控件将被添加到特殊平台提供的容器上
 2、因为该方法内部会先将这些子控件从父view上移除后再添加到特殊平台提供的容器上，
 考虑到媒体可能接入多家平台广告，在使用其他家平台广告进行渲染时务必保证子控件添加到父view上，
 建议在调用attachAd方法前做次检查
 @param container     广告容器         传入前设置好frame
 @param mainImageView 主图            传入前设置好frame
 @param iconImageView 广告icon        传入前设置好frame
 @param title         广告标题         传入前设置好frame
 @param CTAButton     交互类型按钮      传入前设置好frame
 @param logoFrame     广告logo frame
 @param closeBtnFrame 广告关闭按钮 frame
 */
- (void)renderWithContainer:(UIView *_Nonnull)container
                    mainImg:(UIImageView *_Nonnull)mainImageView
                    iconImg:(UIImageView *_Nonnull)iconImageView
                    adTitle:(UILabel *_Nonnull)title
                  descLabel:(UILabel *_Nonnull)descLabel
                  CTAButton:(UIButton *_Nonnull)CTAButton
                  logoFrame:(CGRect)logoFrame
              closeBtnFrame:(CGRect)closeBtnFrame;
/**
 绑定数据到View
 特别说明：
 renderSubViews ：集合中包含的是需要展示的广告元素子控件（title、content、图片、icon等）
 @param container            广告容器                               传入前需设置frame 【必传】
 @param renderSubViews 广告元素子控件                    传入前需设置frame 【必传】
 @param clickViews         支持点击的广告元素子控件   传入前需设置frame 【必传】
 @param closeView           支持关闭的广告元素子控件   传入前需设置frame
 @param presentVc            跳转落地页VC                    【必传】
 */
- (void)attachAd:(UIView *_Nonnull)container
     renderViews:(NSArray<UIView*>*_Nonnull)renderSubViews
       clickView:(NSArray<UIView*>*_Nonnull)clickViews
       closeView:(UIView *_Nullable)closeView
       presentVc:(UIViewController*_Nonnull)presentVc;

//解绑数据
- (void)unAttachAd;
/**
 检测图片是否是gif图
 需传入图片data，该接口仅对该广告物料中主图进行检测！！！
 */
- (BOOL)checkMetaGifImageData:(NSData *_Nonnull)imageData;
/**
 获取该物料广告是否有效
 注意：包括图文及视频类型广告都通过该接口获取
 */
- (BOOL)isAdValid;
@end

#endif /* MSFeedAdMeta_h */
