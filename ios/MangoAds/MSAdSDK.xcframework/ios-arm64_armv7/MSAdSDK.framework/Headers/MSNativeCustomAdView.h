//
//  MSNativeCustomAdView.h
//  MSAdSDK
//
//  Created by leej on 2023/4/17.
//  Copyright © 2023 Adxdata. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSNativeCustomAdView : UIView
/**
 使用信息流自渲染组件须知
 1、MSNativeCustomAdView内部只负责处理添加子控件、绑定/解绑事件，特别说明：MSNativeCustomAdView内部不会布局子控件，布局子控件需媒体处理！！！
 2、MSFeedAdMeta中的图片素材需媒体自行加载并添加至iconImageView、imgViews中
 3、以下属性为调用loadNativeCustomAdWithFeedAdMeta接口时传入的控件
 4、接入细节参考demo中【MSNativeSimpleImageAdView控件】
 */
@property(nonatomic,strong,readonly) UILabel *metaTitleLabel;//标题
@property(nonatomic,strong,readonly) UILabel *metaContentLabel;//详情
@property(nonatomic,strong,readonly) UIImageView *metaLogo;//广告logo
@property(nonatomic,strong,readonly) UIButton *closeBtn;//关闭按钮
@property(nonatomic,strong,readonly) id<MSFeedAdMeta> feedAdData;//广告物料
@property(nonatomic,strong,readonly,nullable) UIImageView *iconImageView;//小图icon
@property(nonatomic,strong,readonly) NSArray<UIImageView *> *imgViews;//大图或组图集合
@property(nonatomic,strong,readonly,nullable) UILabel *metaActionLabel;//引导语
@property(nonatomic,strong,readonly,nullable) UILabel *metaSourceLabel;//来源
@property(nonatomic,strong,readonly,nullable) UILabel *metaAppSizeLabel;//app size
@property(nonatomic,strong,readonly,nullable) UILabel *metaAppPriceLabel;//app 价格
@property(nonatomic,strong,readonly,nullable) UILabel *metaAdxNameLabel;// adx名称
@property(nonatomic,strong,readonly,nullable) UILabel *metaAppCommentNumLabel;//app评论数
@property(nonatomic,strong,readonly,nullable) UILabel *metaAppDownloadCountDescLabel;//app下载数

/**
 加载自渲染控件接口
 @param feedAdMeta 广告物料 【不能为空】
 @param metaLogo 广告logo 【不能为空】
 @param closeBtn 关闭按钮【不能为空】
 @param imgViews 大图或组图集合【不能为空】
 @param iconImageView 小图icon 【MSFeedAdMeta中获取不到该参数传空即可】
 @param actionLabel 引导语【MSFeedAdMeta中获取不到该参数传空即可】
 @param metaTitleLabel 标题
 @param metaContentLabel 详情/副标题【MSFeedAdMeta中获取不到该参数传空即可】
 @param metaSourceLabel 广告来源【MSFeedAdMeta中获取不到该参数传空即可】
 */
- (void)loadNativeCustomAdWithFeedAdMeta:(id<MSFeedAdMeta>)feedAdMeta
                                metaLogo:(UIImageView *)metaLogo
                                closeBtn:(UIButton *)closeBtn
                                imgViews:(NSArray<UIImageView *> *)imgViews
                           iconImageView:(UIImageView *_Nullable)iconImageView
                             actionLabel:(UILabel *_Nullable)actionLabel
                              titleLabel:(UILabel *)metaTitleLabel
                             sourceLabel:(UILabel *_Nullable)metaSourceLabel
                            contentLabel:(UILabel *_Nullable)metaContentLabel;
/**
 加载自渲染控件接口
 @param feedAdMeta 广告物料 【不能为空】
 @param metaLogo 广告logo 【不能为空】
 @param closeBtn 关闭按钮【不能为空】
 @param imgViews 大图或组图集合【不能为空】
 @param iconImageView 小图icon 【MSFeedAdMeta中获取不到该参数传空即可】
 @param actionLabel 引导语【MSFeedAdMeta中获取不到该参数传空即可】
 @param metaTitleLabel 标题
 @param metaContentLabel 详情/副标题【MSFeedAdMeta中获取不到该参数传空即可】
 @param metaSourceLabel 广告来源【MSFeedAdMeta中获取不到该参数传空即可】
 @param metaAppSizeLabel app size【MSFeedAdMeta中获取不到该参数传空即可】
 @param metaAppPriceLabel app 价格【MSFeedAdMeta中获取不到该参数传空即可】
 @param metaAdxNameLabel adx名称【MSFeedAdMeta中获取不到该参数传空即可】
 @param metaAppCommentNumLabel app评论数【MSFeedAdMeta中获取不到该参数传空即可】
 @param metaAppDownloadCountDescLabel app下载数【MSFeedAdMeta中获取不到该参数传空即可】
 */
- (void)loadNativeCustomAdWithFeedAdMeta:(id<MSFeedAdMeta>)feedAdMeta
                                metaLogo:(UIImageView *)metaLogo
                                closeBtn:(UIButton *)closeBtn
                                imgViews:(NSArray<UIImageView *> *)imgViews
                           iconImageView:(UIImageView *_Nullable)iconImageView
                             actionLabel:(UILabel *_Nullable)actionLabel
                              titleLabel:(UILabel *)metaTitleLabel
                             sourceLabel:(UILabel *_Nullable)metaSourceLabel
                            appSizeLabel:(UILabel *_Nullable)metaAppSizeLabel
                            contentLabel:(UILabel *_Nullable)metaContentLabel
                            adxNameLabel:(UILabel *_Nullable)metaAdxNameLabel
                           appPriceLabel:(UILabel *_Nullable)metaAppPriceLabel
                      appCommentNumLabel:(UILabel *_Nullable)metaAppCommentNumLabel
                   appDownloadCountLabel:(UILabel *_Nullable)metaAppDownloadCountDescLabel;
/**
 展示广告
 @param presentVC 指定跳转vc【必传】
 */
- (void)showNativeAdWithClickViews:(NSArray<UIView *> *)clickViews presentVC:(UIViewController *)presentVC;
/**
 销毁广告
 */
- (void)destoryNativeCustomAdView;
@end

NS_ASSUME_NONNULL_END
