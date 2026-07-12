//
//  BUMConst.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#ifndef BUM_const_h
#define BUM_const_h

#pragma mark - 全屏视频、激励视频展示扩展

#pragma mark 扩展展示参数字段 ** swift请勿直接使用枚举，应使用rawValue
/// BUMShowExtroInfoKey, type of scene, only used for pangle SDK now.And the value of key see BURitSceneType
static NSString * BUMShowExtroInfoKeySceneType          = @"ABUShowExtroInfoKeySceneType";

/// scene description, the description defined by the developer, which needs to be assigned when BUShowExtroInfoKeySceneType = 0
static NSString * BUMShowExtroInfoKeySceneDescription   = @"ABUShowExtroInfoKeySceneDescription";


/// 三方Adn枚举
typedef NS_ENUM (NSInteger, BUMAdnType) {
    BUMAdnNoPermission  = -3,  // 无权限访问
    BUMAdnNoData        = -2,  // 暂时无真实数据，未获取到最佳广告，一般在未展示之前提前调用
    BUMAdnNone          = 0,   // 未知adn
    BUMAdnPangle        = 1,   // pangle -> 穿山甲adn
    BUMAdnAdmob         = 2,   // admob -> 谷歌Admob
    BUMAdnGDT           = 3,   // gdt -> 腾讯广点通adn
    BUMAdnMTG           = 4,   // mintegral -> Mintegral adn
    BUMAdnUnity         = 5,   // unity -> unity adn
    BUMAdnBaidu         = 6,   // baidu -> 百度adn
    BUMAdnKs            = 7,   // ks -> 快手Adn
    BUMAdnSigmob        = 8,   // sigmob -> Sigmob adn
    BUMAdnKlevin        = 9,   // klevin -> Klevin游可赢 // 6700版本已经移除支持
};

#endif /* BUM_const_h */
