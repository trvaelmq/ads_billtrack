//
//  BUMCustomAdapterVersion.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BUMCustomAdapterVersion;

/// 自定义adapter协议版本，版本号 1.0
extern BUMCustomAdapterVersion * const BUMCustomAdapterVersion1_0;
/// 自定义adapter协议版本，版本号 1.1
extern BUMCustomAdapterVersion * const BUMCustomAdapterVersion1_1;

/// 自定义adapter使用的协议版本，请开发者实现/更新自定义adapter时使用最新版本的版本号即可
/// GroMore会根据实际情况控制adapter是否可用，[及时更新]
@interface BUMCustomAdapterVersion : NSString @end

NS_ASSUME_NONNULL_END
