//
//  MSNativeCustomVideoAdView.h
//  MSAdSDK
//
//  Created by leej on 2023/4/18.
//  Copyright © 2023 Adxdata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSFeedVideoView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MSNativeCustomVideoAdViewDelegate <NSObject>
//视频播放完成
- (void)msFeedVideoFinish;
//视频开始播放
- (void)msFeedVideoStart;
//视频暂停播放
- (void)msFeedVideoPause;
//视频恢复播放
- (void)msFeedVideoResume;
//视频播放出错
- (void)msFeedVideoError:(NSError *)error;
/// 视频播放进度
/// - Parameters:
///   - progress: 播放进度百分比 取值[0~100%]
///   - currentTime: 当前播放时间
///   - totalTime:   视频总时长
-(void)msFeedVideoPlayingProgress:(CGFloat)progress currentTime:(CGFloat)currentTime totalTime:(CGFloat)totalTime;
@end

@interface MSNativeCustomVideoAdView : UIView
/**
 使用信息流自渲染组件须知
 1、MSNativeCustomVideoAdView内部只负责处理添加子控件、绑定/解绑事件，特别说明：MSNativeCustomVideoAdView内部不会布局子控件，布局子控件需媒体处理！！！
 2、调用loadNativeCustomVideoAdViewWithFrame方法后内部自动创建播放器，媒体可通过self.videoView获取播放器控件，其中视频资源videoView会自行加载
 3、以下属性为调用loadNativeCustomVideoAdViewWithFrame接口时传入的控件
 4、接入细节参考demo中【MSNativeSimpleVideoAdView控件】
 */
@property(nonatomic,weak)id<MSNativeCustomVideoAdViewDelegate> videoDelegate;//播放器播放状态代理
@property(nonatomic,strong,readonly) UILabel *metaTitleLabel;//标题
@property(nonatomic,strong,readonly) UILabel *metaContentLabel;//详情
@property(nonatomic,strong,readonly) UIImageView *metaLogo;//广告logo
@property(nonatomic,strong,readonly) UIButton *closeBtn;//关闭按钮
@property(nonatomic,strong,readonly) id<MSFeedAdMeta> feedAdData;//广告物料
@property(nonatomic,strong,readonly,nullable) UIImageView *iconImageView;//小图icon
@property(nonatomic,strong,readonly) MSFeedVideoView *videoView;//视频播放器
@property(nonatomic,strong,readonly,nullable) UILabel *metaActionLabel;//引导语
@property(nonatomic,strong,readonly,nullable) UILabel *metaSourceLabel;//来源
@property(nonatomic,strong,readonly,nullable) UILabel *metaAppSizeLabel;//app size
@property(nonatomic,strong,readonly,nullable) UILabel *metaAppPriceLabel;//app 价格
@property(nonatomic,strong,readonly,nullable) UILabel *metaAdxNameLabel;// adx名称
@property(nonatomic,strong,readonly,nullable) UILabel *metaAppCommentNumLabel;//app评论数
@property(nonatomic,strong,readonly,nullable) UILabel *metaAppDownloadCountDescLabel;//app下载数

/**
 加载自渲染控件接口
 @param frame 容器frame
 @param feedAdMeta 广告物料
 @param metaLogo 广告logo 【不能为空】
 @param closeBtn 关闭按钮【不能为空】
 @param iconImageView 小图icon 【MSFeedAdMeta中获取不到该参数传空即可】
 @param actionLabel 引导语【MSFeedAdMeta中获取不到该参数传空即可】
 @param metaTitleLabel 标题
 @param metaContentLabel 详情/副标题【MSFeedAdMeta中获取不到该参数传空即可】
 @param metaSourceLabel 广告来源【MSFeedAdMeta中获取不到该参数传空即可】
 */
- (void)loadNativeCustomVideoAdViewWithFrame:(CGRect)frame
                                  feedAdMeta:(id<MSFeedAdMeta>)feedAdMeta
                                    metaLogo:(UIImageView *)metaLogo
                                    closeBtn:(UIButton *)closeBtn
                                 videoConfig:(MSFeedVideoConfig *)config
                               iconImageView:(UIImageView *)iconImageView
                                 actionLabel:(UILabel *)actionLabel
                                  titleLabel:(UILabel *)metaTitleLabel
                                 sourceLabel:(UILabel *_Nullable)metaSourceLabel
                                contentLabel:(UILabel *)metaContentLabel;
/**
 加载自渲染控件接口
 @param frame 容器frame
 @param feedAdMeta 广告物料
 @param metaLogo 广告logo 【不能为空】
 @param closeBtn 关闭按钮【不能为空】
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
- (void)loadNativeCustomVideoAdViewWithFrame:(CGRect)frame
                                  feedAdMeta:(id<MSFeedAdMeta>)feedAdMeta
                                    metaLogo:(UIImageView *)metaLogo
                                    closeBtn:(UIButton *)closeBtn
                                 videoConfig:(MSFeedVideoConfig *)config
                               iconImageView:(UIImageView *)iconImageView
                                 actionLabel:(UILabel *)actionLabel
                                  titleLabel:(UILabel *)metaTitleLabel
                                 sourceLabel:(UILabel *_Nullable)metaSourceLabel
                                appSizeLabel:(UILabel *_Nullable)metaAppSizeLabel
                                contentLabel:(UILabel *)metaContentLabel
                                adxNameLabel:(UILabel *_Nullable)metaAdxNameLabel
                               appPriceLabel:(UILabel *_Nullable)metaAppPriceLabel
                          appCommentNumLabel:(UILabel *_Nullable)metaAppCommentNumLabel
                       appDownloadCountLabel:(UILabel *_Nullable)metaAppDownloadCountDescLabel;
/**
 展示广告
 @param presentVC 指定跳转vc【必传】
 */
- (void)showNativeAdWithClickViews:(NSArray<UIView *> *)clickViews presentVC:(UIViewController *)presentVC;
///播放视频
- (void)playVideo;
///暂停视频
- (void)pauseVideo;
///视频静音
///注意⚠️由于各渠道SDK设置静音时机不一致，媒体在关闭静音时务必保证在调用showNativeAdWithClickViews接口后调用
- (void)muteVideo:(BOOL)isMute;
/**
 重播 注意⚠️视频未播放完毕，调用此接口无效，可通过视频播放完毕回调监听播放状态
 */
- (void)replayVideo;
/**
 * 视频广告时长，单位 s 视频开始播放时获取
 * 支持获取的平台（百度、广点通 、ms、快手）
 */
- (CGFloat)totalTime;
/**
 * 视频广告已播放时长，单位 s
 * 支持获取的平台（广点通 、ms）
 */
- (CGFloat)currentTime;
/**
 当外部需要再次更新播放器size后需调用该接口通知内部
 调用时机：调用showNativeAdWithClickViews接口后调用
 */
- (void)resizeAdVideo;
/**
 设置媒体自定义videoView（videoView必须是UIView或其子类）且遵守MSFeedVideoInterface协议
 注意：
 1、该接口仅在媒体使用【自定义平台功能】时使用
 */
- (void)setMediaCustomFeedVideoView:(UIView<MSFeedVideoInterface> *)videoView;
/**
 销毁广告
 */
- (void)destoryNativeCustomVideoAdView;
@end

NS_ASSUME_NONNULL_END
