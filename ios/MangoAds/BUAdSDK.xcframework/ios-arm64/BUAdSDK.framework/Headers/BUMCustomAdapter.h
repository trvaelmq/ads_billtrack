//
//  BUMCustomAdapter.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BUMCustomConfigAdapter;
@class BUMMediaBidResult;

typedef NS_ENUM(NSInteger, BUMMediatedAdStatusValue) {
    BUMMediatedAdStatusValueDeny = -1,
    BUMMediatedAdStatusValueUnknown = 0,
    BUMMediatedAdStatusValueSure = 1,
};

/// adn广告状态
typedef struct {
    BUMMediatedAdStatusValue isReady;
    BUMMediatedAdStatusValue unexpired;
    BUMMediatedAdStatusValue valid;
} BUMMediatedAdStatus;

extern const BUMMediatedAdStatus BUMMediatedAdStatusUnknown;

extern const BUMMediatedAdStatus BUMMediatedAdStatusNormal;

static inline
BOOL BUMMediatedAdStatusEqualsTo(BUMMediatedAdStatus aStatus, BUMMediatedAdStatus anotherStatus) {
    return aStatus.isReady == anotherStatus.isReady &&
        aStatus.unexpired == anotherStatus.unexpired &&
        aStatus.valid == anotherStatus.valid;
}

static inline
BUMMediatedAdStatus BUMMediatedAdStatusMake(BUMMediatedAdStatusValue isReady, BUMMediatedAdStatusValue unexpired, BUMMediatedAdStatusValue valid) {
    BUMMediatedAdStatus status = {BUMMediatedAdStatusValueUnknown, BUMMediatedAdStatusValueUnknown , BUMMediatedAdStatusValueUnknown};
    status.isReady = isReady;
    status.unexpired = unexpired;
    status.valid = valid;
    return status;
}

/// 自定义adapter广告类型基本协议
@protocol BUMCustomAdapter <NSObject>
@optional

- (NSString *)serverBiddingTokenWithParams:(NSDictionary *)params error:(NSError **)error;

/// 需要传递token以外值时,使用此方法
- (NSString *)serverBiddingTokenWithParams:(NSDictionary *)params otherInfo:(NSMutableDictionary *)otherInfo error:(NSError **)error;

/// 当前广告有广告正在展示时是否允许进行预加载广告，未实现则为NO。
- (BOOL)enablePreloadWhenCurrentIsDisplay;

/// 回调客户端竞价结果，比价成功时回传成功，比价失败、返回超时或价格低于竞价底价时回传失败
/// @param result bid结果对象
/// @warning 1.创建广告时需设置bidNotify属性为YES才会触发该回调
///          2.adn广告load失败不触发该回调，如需回传adn竞价结果，请在load失败处自行处理
///          3.信息流加载多条会触发多次，返回每条比价结果
- (void)didReceiveBidResult:(nonnull BUMMediaBidResult *)result;

/// 开发者无需实现，系统自动生成
@property (nonatomic, assign) BOOL isCustomAdapter;

/// 开发者无需实现，系统自动生成
@property (nonatomic, strong) id<BUMCustomConfigAdapter> configAdapter;

@end

NS_ASSUME_NONNULL_END
