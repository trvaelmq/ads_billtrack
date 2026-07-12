//
//  MSBaseLoader.h
//  MSAdSDK
//
//  Created by Liumaos on 2020/7/14.
//  Copyright © 2020 XiXiHaha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSDKDefines.h"

NS_ASSUME_NONNULL_BEGIN
/**
 广告请求成功后，通过-(NSDictionary *)mediaExt;获取竞胜广告的具体信息
 以下为具体信息对应的key
 */
//渠道appid
extern NSString *const kMSAdMediaAdnAppidKey;
//渠道pid
extern NSString *const kMSAdMediaAdnPidKey;
//渠道名称
extern NSString *const kMSAdMediaAdnNameKey;
//渠道名称int值 映射关系参考MSPlatform枚举
extern NSString *const kMSAdMediaAdnPlatformKey;
//渠道出价 单位：分 [该渠道为客户端bidding模式下，返回渠道出价，非客户端bidding模式下，返回ms平台设置的出价]
extern NSString *const kMSAdMediaAdnEcpmKey;
//ms平台价格 单位：分 [获取该渠道在ms平台设置的出价]
extern NSString *const kMSAdMediaAdnPlatformPriceKey;
//ms平台 fromid [仅支持ms平台]
extern NSString *const kMSAdMediaAdnFromIdKey;
//场景code
extern NSString *const kMSAdMediaAdnScodeKey;
//场景扩展字段
extern NSString *const kMSAdMediaAdnSextKey;
//ms平台 adCats 为投放行业ID [仅支持ms平台]
extern NSString *const kMSAdMediaAdCatsKey;
//ms平台 adCids 为创意ID [仅支持ms平台]
extern NSString *const kMSAdMediaAdCidsKey;
//ms平台 aderIds为 广告主ID [仅支持ms平台]
extern NSString *const kMSAdMediaAderIdsKey;
//请求id
extern NSString *const kMSAdMediaAdnAdRequestIdentifierKey;
/**C2S bidding上报参数
 注意：上报接口传入的字典中value值类型为字符串！！！
 如何使用：
 1、美数竞价成功上报
 NSDictionary *adInfo = @{kMSAdMediaWinPrice:@"竞胜方价格",kMSAdMediaLossPrice:@"最大竞败方出价"}
 [MSBaseAd sendWinNotificationWithInfo:adInfo];
 2、美数竞价失败上报
 NSDictionary *adInfo = @{kMSAdMediaWinPrice:@"竞胜方价格",kMSAdMediaLossReason:@"美数竞败原因",kMSAdMediaWinADN:@"竞胜方渠道ID"}
 kMSAdMediaLossReason失败原因从(1：竞争力不足 101：未参与竞价 10001：其他)中按照实际情况填写
 kMSAdMediaWinADN渠道ID(1：美数其他非bidding广告位 2：第三方ADN 3：自售广告主 4：美数其他bidding广告位)中按照实际情况填写
 [MSBaseAd sendLossNotificationWithInfo:adInfo];
*/
/**以下为C2S bidding上报参数key**/
//竞胜方价格 单位：分 (kMSAdMediaWinPrice value值务必转为NSString类型)
#define kMSAdMediaWinPrice   @"_WIN_PRICE_"
//最大竞败方出价 单位：分 (kMSAdMediaLossPrice value值务必转为NSString类型)
#define kMSAdMediaLossPrice  @"_LOSS_PRICE_"
//美数竞败原因(MSMediaLossReason中取值，注意该值务必转为NSString类型)
#define kMSAdMediaLossReason @"_LOSS_REASON_"
//美数竞胜方渠道ID(MSMediaWinADN中取值，注意该值务必转为NSString类型)
#define kMSAdMediaWinADN     @"_ADN_ID_"

//失败原因枚举（即kMSAdMediaLossReason值，注意kMSAdMediaLossReason值务必转为NSString类型）
typedef NS_ENUM(NSInteger,MSMediaLossReason) {
    MSMediaLossReasonLowPrice    = 1,//竞争力不足
    MSMediaLossReasonNoBidding   = 101,//未参与竞价
    MSMediaLossReasonOther       = 10001 //其他
};
//美数竞胜方渠道ID枚举（即kMSAdMediaWinADN值，注意kMSAdMediaWinADN值务必转为NSString类型）
typedef NS_ENUM(NSInteger,MSMediaWinADN) {
    MSMediaWinADN_MSNoBidding    = 1,//美数其他非bidding广告位
    MSMediaWinADN_ThirdADN       = 2,//第三方ADN
    MSMediaWinADN_Advertisers    = 3, //自售广告主
    MSMediaWinADN_MSBidding      = 4 //美数其他bidding广告位
};

@interface MSBaseAd : NSObject
//当前广告位id
@property(nonatomic,copy)NSString *pid;
/**
 广告加载成功后获取媒体配置信息
 */
-(NSDictionary *)mediaExt;
/**广告类型 */
-(MSAdType)adType;
/**
 *  竞价成功上报
 *  竞胜之后调用, 需要在调用广告show接口前调用
 *
 *  @param adInfo 竞胜信息，字典类型，必填，支持的key（key是个宏，在MSBaseAd.h中有定义）为以下内容。
 *  kMSAdMediaWinPrice：竞胜价格 (单位: 分)。值类型为NSString
 *  kMSAdMediaLossPrice：最高失败出价 (单位: 分)。值类型为NSString
 *
 */
-(void)sendWinNotificationWithInfo:(NSDictionary *)adInfo;
/**
 *  竞败之后调用
 *
 *  @param adInfo 竞败信息，字典类型，必填，支持的key（key是个宏，在MSBaseAd.h中有定义）为以下内容
 *  kMSAdMediaWinPrice ：竞胜价格 (单位: 分)。值类型为NSString
 *  kMSAdMediaLossReason ：广告竞败原因。竞败原因参考枚举MSMediaLossReason中的定义，值类型为NSString
 *  kMSAdMediaWinADN ：竞胜方渠道ID。渠道ID参考枚举MSMediaWinADN中的定义，值类型为NSString
 *  对于【MSMediaWinADN】字段回传支持4个枚举值，分别代表：
 *  1 - 输给美数其他非bidding广告位
 *  2 - 输给第三方ADN
 *  3 - 输给自售广告主
 *  4 - 输给美数其他bidding广告位
 */
-(void)sendLossNotificationWithInfo:(NSDictionary *)adInfo;
@end

NS_ASSUME_NONNULL_END
