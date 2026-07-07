//
//  SFFeedVideoViewController.h
//  MSaasAdapter
//
//  Created by YJoo on 2025/7/10.
//

#import <UIKit/UIKit.h>
#import "SFFeedAdData.h"
#import "SFAdSourcesModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SFFeedVideoPlayDelegate <NSObject>

@optional

/**
激励视频广告点击下载
 */
- (void)feedAdClick;

/**
激励视频达到激励条件
 */
- (void)feedAdRewardEffective;

/**
激励视频广告已经关闭
 */
- (void)feedAdShowFinish;

@end

@interface SFFeedVideoViewController : UIViewController

@property (nonatomic, weak) id<SFFeedVideoPlayDelegate> delegate;
@property (nonatomic, strong) SFAdSourcesModel *baseModel;
@property (nonatomic, strong) SFFeedAdData *adData;  //广告数据

@property (nonatomic, strong) UIButton *backAppBtn;
@property (nonatomic, strong) UIView *appView;
@property (nonatomic, strong) UIView *mediaView;
@property (nonatomic, assign) CGFloat mediaDuration;
@property (nonatomic, assign) BOOL muted; //是否静音

@end

NS_ASSUME_NONNULL_END
