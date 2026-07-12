//
//  MSAdSDK.h
//  MSAdSDK
//
//  Created by yang on 2019/8/5.
//  Copyright © 2019年 yang. All rights reserved.
//

#import "MSPublicHeader.h"

@interface MSAdSDK : NSObject
//MSSDK入口 设置MSAppID
+ (BOOL)startSDKWithAppid:(NSString *)appId configBlock:(void(^)(void))configBlock;
//日志打印，调试广告时，打开日志，可查看具体详细log，上线前务必关闭log
+ (void)setLogLevel:(MSLogLevel)level;
//MS VersionName
+ (NSString *)getVersionName;
//MS VersionCode
+ (NSInteger)getVersionCode;
//获取平台版本号
+ (NSString*)platformVersion:(MSPlatform) platform;
//设置支持的通信协议
+ (void)setSecure:(MSSecure) secure;
//检测SDK聚合信息
+ (NSDictionary *)checkSdkIntegration;
@end
