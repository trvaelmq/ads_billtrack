//
//  MSNativeFeedVideoInterface.h
//  MSAdSDK
//
//  Created by Liumaos on 2020/8/28.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSFeedVideoConfig.h"
#import "MSFeedVideoDelegate.h"

@protocol MSFeedVideoInterface <NSObject>
- (void)registerDataObject:(id<MSFeedAdMeta>)dataObject
            clickableViews:(NSArray<UIView *>*)clickableViews;
-(void)unregisterDataObject;
-(void) config:(MSFeedVideoConfig*)config
     presentVc:(UIViewController*)presentVc
      delegate:(id<MSFeedVideoDelegate>)delegate;
- (void)playVideo;
- (void)pauseVideo;
- (void)muteVideo:(BOOL)isMute;
- (void)replayVideo;
/**
 * 视频广告时长，单位 s
 */
- (CGFloat)totalTime;
/**
 * 视频广告已播放时长，单位 s
 */
- (CGFloat)currentTime;
/**
 当外部需要再次更新播放器size后需调用该接口通知内部
 调用时机：绑定事件（即调用registerDataObject接口）之后调用
 */
- (void)resizeAdVideo:(CGSize)adsize;

@optional
/**
 绑定子控件【使用特殊平台自渲染广告该方法必须调用】
 调用时机：registerDataObject前
 ⚠️注意：
 1、仅特殊平台调用该接口，传入的子控件将被添加到特殊平台提供的容器上
 2、因为该方法内部会先将这些子控件从父view上移除后再添加到特殊平台提供的容器上，
 考虑到媒体可能接入多家平台广告，在使用其他家平台广告进行渲染时务必保证子控件添加到父view上，
 建议在调用registerDataObject方法前做次检查
 @param iconImageView 广告icon       传入前设置好frame
 @param title         广告标题        传入前设置好frame
 @param CTAButton     交互类型按钮     传入前设置好frame
 @param logoFrame     广告logo frame
 @param closeBtnFrame 广告关闭按钮 frame
 @param playerFrame   广告播放器 frame
 */
- (void)renderWithIconImg:(UIImageView *)iconImageView
                  adTitle:(UILabel *)title
                descLabel:(UILabel *)descLabel
                CTAButton:(UIButton *)CTAButton
                logoFrame:(CGRect)logoFrame
            closeBtnFrame:(CGRect)closeBtnFrame
              playerFrame:(CGRect)playerFrame
               dataObject:(id<MSFeedAdMeta>)dataObject
                container:(UIView *)container;
@end


