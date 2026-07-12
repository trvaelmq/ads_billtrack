//
//  BUInterfaceAdapter.h
//  ProtocolTest
//
//  Created by zth on 2022/2/17.
//

/**
 接口适配器
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString * BUInterfaceAdapterKey;
extern BUInterfaceAdapterKey const BUInterfaceAdapterSlotIDKey; // 媒体传入ID           类型：NSString
extern BUInterfaceAdapterKey const BUInterfaceAdapterAdSlotKey; // 媒体传入广告参数对象   类型：BUAdslot

@interface BUInterfaceAdapter : NSObject

/// 接口转换
/// @param originalClass 原接口类Param
/// @return 新接口类
+ (Class )adapterWithOriginalClass:(Class)originalClass;

/// 接口转换
/// @param originalClass 原接口类
/// @param extraData 携带的额外信息
/// @return 新接口类
/// @warning 请注意extraData 请不要携带NSObject类型的对象.
+ (Class )adapterWithOriginalClass:(Class)originalClass extraData:(NSDictionary<BUInterfaceAdapterKey, NSObject *> *)extraData;

/// 判断一个对象是否是GM对象
/// @warning : 关于跨业务传递对象的处理，没有好的解决方案，暂时穷举存在问题的地方临时处理，可全局搜索该方法
+ (BOOL)isGroMoreObject:(NSObject *_Nullable)object;

@end

NS_ASSUME_NONNULL_END
