//
//  BUMVideoAdReportSupport.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import <Foundation/Foundation.h>

/// 待上报的视频事件枚举类型
typedef NS_ENUM(NSInteger, BUMVideoAdEvent) {
    BUMVideoAdEventVideoDidPlay = 1, // 视频开始播放
    BUMVideoAdEventVideoDidFinish = 2, // 视频播放完成，无异常
    BUMVideoAdEventVideoDidPause = 3, // 视频暂停
    BUMVideoAdEventVideoDidResume = 4, // 视频恢复播放
    BUMVideoAdEventVideoDidBreak = 5, // 视频意外终止，如跳过、视频切出屏幕等
    BUMVideoAdEventVideoDidClick = 6, // 视频被点击
    BUMVideoAdEventVideoDidStartFailed = 7, // 视频开始播放时出现异常
    BUMVideoAdEventVideoDidPlayFailed = 8, // 视频播放中出现异常

};

typedef NSString * BUMVideoAdEventParameter;

/// 视频总时长，NSNumber类型，单位s
extern BUMVideoAdEventParameter const BUMVideoAdEventParameterVideoTotalDurationKey;
/// 视频播放时长，NSNumber类型，单位s
extern BUMVideoAdEventParameter const BUMVideoAdEventParameterVideoCurrentDurationKey;
/// 视频出现异常原因，NSError类型
extern BUMVideoAdEventParameter const BUMVideoAdEventParameterErrorKey;
