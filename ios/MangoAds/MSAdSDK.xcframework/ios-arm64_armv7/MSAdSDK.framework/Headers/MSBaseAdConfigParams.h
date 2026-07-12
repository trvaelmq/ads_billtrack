//
//  MSBaseAdConfigParams.h
//  MSAdSDK
//
//  Created by leej on 2023/2/14.
//  Copyright © 2023 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,MSRewardAdShowDirection) {
    MSRewardAdShowVerticalDirection   = 0,     //竖屏
    MSRewardAdShowHorizontalDirection = 1,     //横屏
};

@interface MSBaseAdConfigParams : NSObject
/**
 server bidding注意点⚠️
 1、获取到的token和广告位为一一对应关系，请求广告时务必保证广告位和token传入正确，否则加载不到广告
 2、建议每次请求前调用一次（getBuyerIdWithContext、getSDKInfoWithPlacementId:接口）, 并使用最新值请求token，并将最新的token传给SDK
 */
/**
 获取 buyerId 用于 Server Bidding 请求获取 token,info参数为预留扩展参数
 建议每次请求前调用一次, 并使用最新值请求
 */
+ (NSString *)getBuyerIdWithContext:(NSDictionary *_Nullable)info;
/**
 获取用于 Server Bidding 请求SDK侧相关请求参数信息
 placementId为必传参数！！！
 建议每次请求前调用一次, 并使用最新值请求
 */
+ (NSString *)getSDKInfoWithPlacementId:(NSString *)placementId;
/**
 设置服务端竞价Token
 如果媒体使用的是server bidding功能此参数必传！！！
 建议每次请求前调用一次, 并使用最新值请求
 */
@property(nonatomic,copy)NSString *serverBiddingToken;
/**
 媒体指定渠道（可选参数）
 */
@property(nonatomic,copy)NSString *mediaChannel;

@end
#pragma mark 开屏广告参数
@interface MSSplashAdConfigParams : MSBaseAdConfigParams
/**
 开屏广告容器尺寸（默认屏幕size）
 adSize传值提示：
 1、全屏展示传屏幕size即可
 2、半屏+底部logo展示时 adSize = {全屏size.width,屏幕size.height - 底部logo.size.height}
 ⚠️ adSize高度不要低于屏幕高度的75%，低于约定最小高度，按约定的最小高度处理（即屏幕高度的75%）
 */
@property(nonatomic,assign)CGSize adSize;
/**
 *  拉取广告超时时间，默认为0秒即以服务端配置超时时长为准
 *  详解：
 *  1、拉取广告超时时间，超过此时间则放弃此次广告展示机会。
 *  2、超时规则：媒体设置的超时时长优先级大于平台配置超时时长
 *  3、计时规则：fetchDelay时长从调用load接口开始计时，平台配置超时时长从拉取到广告配置后开始计时
 */
@property(nonatomic,assign)NSInteger fetchDelay;
/**
 * 自定义底部视图
 * 提示：
 * 1、加载广告前将指定大小的bottomView传入
 * 2、bottomView的高度不要超过屏幕高度的25%，超过约定高度，按约定的最大高度处理（即屏幕高度的25%）
 */
@property(nonatomic,strong)UIView *bottomView;
 /**
  自定义跳过控件
  只支持MS平台
  */
@property(nonatomic,strong)UIView *skipView;
/**
 配置开屏可点击文案
 提示：
 1、请在加载广告前配置
 2、平台可配置限点文案且平台配置优先级最高
 */
@property(nonatomic,copy)NSString *splashClickText;
/**
 隐藏跳过按钮 （YES：隐藏 NO：展示）默认展示
 注意⚠️：
 1、加载广告前设置有效
 2、仅ms支持设置隐藏跳过按钮
 */
@property(nonatomic,assign)BOOL hideSkipButton;
/**
 开屏广告页是否开启状态栏 hideSplashStatusBar（YES：隐藏 NO：展示）默认展示
 只支持MS平台
 */
@property(nonatomic,assign)BOOL hideSplashStatusBar;
/**
 广告展示时间
 只支持MS平台
 */
@property(nonatomic,assign)NSInteger showTime;
/**
 开屏广告加载背景图-占位图 {全屏展示}
 只支持美数平台
 */
@property(nonatomic,strong)UIImage *backgroundImage;
/**
 开屏背景图填充模式。默认 UIViewContentModeScaleAspectFit
 只有设置 背景加载背景图 后有效
 只支持美数平台
 */
@property(nonatomic,assign)UIViewContentMode bgContentMode;

@end

#pragma mark 激励视频参数
@interface MSRewardAdConfigParams : MSBaseAdConfigParams
/**
 设置视频是否开启静音，默认不开启，加载广告前设置有效
 注意事项：
 1、此设置仅支持快手、广点通、ms，
 2、快手、穿山甲需在三方平台广告位上设置
 */
@property(nonatomic,assign)BOOL videoMuted;
/**
 必须，媒体选择服务端验证需设置的userId
 */
@property(nonatomic,copy)NSString *userId;
/**
 设置视频展示方向 默认竖屏展示
 支持平台【快手】
 */
@property(nonatomic,assign)MSRewardAdShowDirection direction;

@end

#pragma mark 横幅banner广告参数
@interface MSBannerAdConfigParams : MSBaseAdConfigParams
/**
 * 广告刷新间隔，范围 [30, 120] 秒，默认值 30 秒。 [可选]
 * 注意事项：
 * 1、该配置仅支持广点通、穿山甲
 * 2、当interval设置为0 不刷新，使用穿山甲banner刷新功能时需在穿山甲平台广告位上进行配置
 */
@property(nonatomic,assign)int interval;
/**
 * Banner条展示关闭按钮，默认打开
 */
@property(nonatomic,assign)BOOL showCloseBtn;

@end

#pragma mark 插屏广告参数
@interface MSInterstitialAdConfigParams : MSBaseAdConfigParams
/**
 * 是否静音，默认 YES。
 * 设置时机：加载广告前。
 * 注意事项：此设置仅支持快手、广点通、ms，其他平台需在三方平台广告位进行设置
 */
@property (nonatomic,assign)BOOL videoMuted;
/**
 * 点击广告后是否关闭广告，默认 NO，即手动关闭。加载广告前设置。
 * 注意：此设置仅对ms平台广告生效
 */
@property (nonatomic,assign)BOOL isNeedCloseAdAfterClick;

@end

#pragma mark 信息流混合接口参数
@interface MSNativeFeedAdConfigParams : MSBaseAdConfigParams
/**
 * 加载广告条数 默认1条
 * 传入时机：加载广告前
 */
@property(nonatomic,assign)NSInteger adCount;
/**
 * 注意⚠️⚠️⚠️此参数针对自渲染广告有效
 * 视频广告是否显示视频详情页面，默认为 NO，点击直接跳转网页，设置为YES时，点击后显示视频详情页面
 * 传入时机：加载广告前
 */
@property(nonatomic,assign)BOOL showVideoDetail;
/**
 注意⚠️⚠️⚠️此参数针对模版广告有效
 通过此参数设置模版的上下左右边距
 默认值均为20
 传入时机：加载广告前
 */
@property(nonatomic,assign)UIEdgeInsets edgeInsets;
/**
 注意⚠️⚠️⚠️此参数针对模版广告有效
 设置图片高度
 提示：
 1、仅支持MS平台左图右文样式调整
 传入时机：加载广告前
 */
@property(nonatomic,assign)CGFloat imageHeight;
/**
 设置模版广告size
 传入时机：加载广告前
 注意⚠️
 prerenderAdSize默认屏宽、高度自适应（prerenderAdSize =（屏宽，0））
 如果媒体指定size，prerenderAdSize.width和prerenderAdSize.height不能小于屏宽的30%
 当设置prerenderAdSize.height = 0时为自适应高度
 */
@property(nonatomic,assign)CGSize prerenderAdSize;
/**
 *  是否静音，默认 YES。
 *  传入时机：加载广告前
 */
@property(nonatomic,assign)BOOL videoMuted;
/**
 是否自动播放 默认 YES
 传入时机：加载广告前
 仅ms、广点通平台设置有效
 */
@property(nonatomic,assign)BOOL isAutoPlay;

@end

#pragma mark 全屏视频参数
@interface MSExpressFullScreenVideoAdConfigParams : MSBaseAdConfigParams
/**
 *  是否静音，默认 YES。
 *  设置时机：加载广告前设置。
 *  仅ks、ms平台设置有效
 */
@property(nonatomic,assign)BOOL videoMuted;

@end

#pragma mark draw信息流参数
@interface MSDrawAdConfigParams : MSBaseAdConfigParams
/**
 指定广告view size
 默认全屏尺寸
 传入时机：加载广告前传入
 */
@property(nonatomic,assign)CGSize adSize;

@end

#pragma mark 贴片广告参数
@interface MSVideoAdConfigParams : MSBaseAdConfigParams
/**
 指定广告view size 默认320*240
 传入时机：加载广告前传入
 */
@property(nonatomic,assign)CGSize adSize;

@end
NS_ASSUME_NONNULL_END
