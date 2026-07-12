//
//  BUMSplashUserData.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUInterfaceBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

/// 开屏广告兜底数据
@interface BUMSplashUserData : BUInterfaceBaseObject

/// adn的名字，请使用如下值 'pangle','baidu','gdt','ks'，其他值可能导致无法加载广告
@property (nonatomic, copy) NSString *adnName;

// adn对应代码位
@property (nonatomic, copy) NSString *_Nonnull rit;

// adn对应appID
@property (nonatomic, copy) NSString *_Nonnull appID;

// adn对应appKey, 没有时可不传
@property (nonatomic, copy) NSString *_Nullable appKey;

@end

NS_ASSUME_NONNULL_END
