//
//  MSBaseViewAd.h
//  MSAdSDK
//
//  Created by leej on 2023/2/7.
//  Copyright © 2023 Adxdata. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSBaseViewAd : UIView
//当前广告位id
@property(nonatomic,copy)NSString *pid;
/**
 获取媒体配置信息
 */
-(NSDictionary *)mediaExt;
/**广告类型 */
-(MSAdType)adType;
/**
 调用说明 请查看MSBaseAd.h声明文件
 竞价成功上报
 */
-(void)sendWinNotificationWithInfo:(NSDictionary *)adInfo;
/**
 调用说明 请查看MSBaseAd.h声明文件
 竞价失败上报
 */
-(void)sendLossNotificationWithInfo:(NSDictionary *)adInfo;
@end

NS_ASSUME_NONNULL_END
