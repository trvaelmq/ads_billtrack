//
//  MSFeedVideoView.h
//  MSAdSDK
//
//  Created by Liumaos on 2020/8/28.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSFeedAdMeta.h"
#import "MSFeedVideoConfig.h"
#import "MSFeedVideoDelegate.h"
#import "MSFeedVideoInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSFeedVideoView : UIView
/// 回调代理
@property(nonatomic,weak) id<MSFeedVideoDelegate> delegate;
/// 视频广告配置
@property(nonatomic,strong) MSFeedVideoConfig *videoConfig;
/// 展示广告的视图控制器
@property(nonatomic,weak) UIViewController *presentVc;

-(instancetype) initWithFrame:(CGRect)frame
                     delegate:(id<MSFeedVideoDelegate>)delegate
                       config:(MSFeedVideoConfig*)config
                    presentVc:(UIViewController*)presentVc;
/// 绑定广告数据
/// @param dataObject 广告数据
/// @param clickableViews 响应点击事件的视图
-(void) registerDataObject:(id<MSFeedAdMeta>)dataObject
            clickableViews:(NSArray<UIView *>*)clickableViews;
///解绑数据 ⚠️⚠️⚠️  需要在适当时机(比如:父容器UIView释放的时候)调用该方法解绑释放数据,需与绑定广告数据方法成对出现
-(void) unregisterDataObject;
///播放视频 绑定广告数据后调用
-(void) playVideo;

///暂停视频 绑定广告数据后调用
-(void) pauseVideo;

///视频静音 绑定广告数据后调用
-(void) muteVideo:(BOOL)isMute;
/**
 重播 注意⚠️视频未播放完毕，调用此接口无效，可通过视频播放完毕回调监听播放状态
 */
- (void)replayVideo;
/**
 * 视频广告时长，单位 s
 * 支持获取的平台（百度、广点通 、ms、快手）
 * 获取时机：注意⚠️由于三方平台获取时机差异
 * 快手平台请在【registerDataObject绑定事件后获取】
 * 其余平台请在开始播放回调中获取
 */
- (CGFloat)totalTime;
/**
 * 视频广告已播放时长，单位 s
 * 支持获取的平台（广点通 、ms）
 * 获取时机：开始播放后获取
 */
- (CGFloat)currentTime;
/**
 设置媒体自定义videoView（videoView必须是UIView或其子类）且遵守MSFeedVideoInterface协议
 注意：
 1、该接口仅在媒体使用【自定义平台功能】时使用
 2、每次调用registerDataObject绑定事件接口前设置
 */
- (void)setMediaCustomFeedVideoView:(id<MSFeedVideoInterface>)videoView;
/**
 当外部需要再次更新播放器size后需调用该接口通知内部
 */
- (void)resizeAdVideo;
@end

NS_ASSUME_NONNULL_END
