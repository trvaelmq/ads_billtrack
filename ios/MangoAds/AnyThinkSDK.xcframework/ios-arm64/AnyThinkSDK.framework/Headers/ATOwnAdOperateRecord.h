//
//  ATOwnAdOperateRecord.h
//  AnyThinkSDK
//
//  Created by GUO PENG on 2021/8/23.
//  Copyright © 2021 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// The interactive method of triggering clicks
typedef NS_ENUM(NSInteger, ATOwnAdMacroClickType) {
    ATOwnAdMacroClickTypeNormal = 0, /// 常规点击
    ATOwnAdMacroClickTypeSwipe = 1,  /// 滑动点击
    ATOwnAdMacroClickTypeShare = 2,  /// 摇一摇点击
};

//@class ATOfferModel;
@interface ATOwnAdOperateRecord : NSObject

/// 广告展示时间
@property (nonatomic, strong) NSNumber *displayTime;
/// 相对屏幕的横纵坐标
@property (nonatomic, assign) CGPoint downPoint;
/// 相对父视图的横纵坐标
@property (nonatomic, assign) CGPoint relativePoint;
/// 点击view 的左上角相对于 UIWindow 的坐标，单位pt
@property (nonatomic, assign) CGPoint viewScreenOriginInPt;
/// 计算视图相对于 key window 的可见区域百分比，本次广告展示出来的最大比例
@property (nonatomic, assign) NSInteger visiblePercentage;
/// 视频进度
@property (nonatomic, assign) NSInteger progress;
/// 宏替换点击类型
@property (nonatomic, assign) ATOwnAdMacroClickType clickType;
/// 主屏幕的原生比例因子，用于转换像素
@property (nonatomic, assign) CGFloat nativeScale;
/// 本次广告视图大小
@property (nonatomic, assign) CGSize adViewSize;
/// 标记是否为摇一摇随机坐标
@property (nonatomic, assign) BOOL isShareRandomCoordinate;
/// 摇一摇触发点击时，X 轴方向加速度峰值
@property (nonatomic, assign) double shakeMaxAccX;
/// 摇一摇触发点击时，Y 轴方向加速度峰值
@property (nonatomic, assign) double shakeMaxAccY;
/// 摇一摇触发点击时，Z 轴方向加速度峰值
@property (nonatomic, assign) double shakeMaxAccZ;
/// 标记是否触发过摇一摇点击
@property (nonatomic, assign) BOOL isShakeClick;
/// 标记是否触发过非摇一摇的点击，（如：手动点击、滑动点击）
@property (nonatomic, assign) BOOL isNonShakeClick;

/// 标记是否可以使用真实坐标
- (BOOL)canUseRealCoordinates;

@end

NS_ASSUME_NONNULL_END
