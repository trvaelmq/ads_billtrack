//
//  SFVideoView.h
//  AdDemo
//
//  Created by lurich on 2021/9/8.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <MSaas/SFFeedManager.h>
#import <MSaas/SFVideoConfig.h>
#import <MSaas/SFVastModel.h>

@class SFVideoView;

NS_ASSUME_NONNULL_BEGIN

@protocol SFVideoViewPlayerDelegate <NSObject>

- (void)sf_nativeAdView:(SFVideoView *)videoView playerStatusChanged:(SFMediaPlayerStatus)status;

@end

@interface SFVideoView : UIView

@property (nonatomic, weak) id<SFVideoViewPlayerDelegate> delegate;

/// 是否自动控制播放
@property (nonatomic, assign) BOOL isAutoControl;
//@property (nonatomic, assign) BOOL isAutoPlay;
@property (nonatomic, strong) SFVideoConfig *videoConfig;
@property (nonatomic, copy) NSString *requestID;
@property (nonatomic, assign) NSTimeInterval currentTime;

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) BOOL isFullInterStitial;
@property (nonatomic, copy) NSString *clickThrough;
@property (nonatomic, strong) NSMutableArray *clickTrackingArr;
@property (nonatomic, assign) BOOL isVast; //是否是vast类型
@property (nonatomic, assign) NSInteger videoTime;

@property (nonatomic, strong) LinearModel *linearModel; //用于保存每个视频的linearModel

/// 播放进度的回调
@property(nonatomic , copy , readwrite)void (^playBlock)(CGFloat progress);
/// 暂停播放的回调
@property(nonatomic , copy , readwrite)void (^playPause)(void);
/// 开始播放的回调
@property(nonatomic , copy , readwrite)void (^playStart)(void);
/// 播放是否静音的回调
@property(nonatomic , copy , readwrite)void (^playMuteChange)(BOOL isMute);

- (void)renderWirhVideo:(NSString *)videoUrl Image:(nullable NSString *)imageUrl;

- (void)replay;

- (void)video_play;
- (void)video_pause;

/// 声音控制 YES：静音； NO：有声
- (void)videoMuted:(BOOL)muted;

/// 释放当前的播放器
-(void)freePlayer;

@end

NS_ASSUME_NONNULL_END
