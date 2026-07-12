//
//  ZPTypedefConfig.h
//  ZPTransition
//
//  Created by Codi on 2023/9/20.
//

#ifndef ZPTypedefConfig_h
#define ZPTypedefConfig_h

@class ZPTransitionProperty;

typedef void(^ZPTransitionBlock)(ZPTransitionProperty *transition);

// ************** Enum **************
typedef NS_ENUM(NSInteger,ZPTransitionAnimationType){
    //----------- 系统 ------------
    //----------- 自定义 ------------
    ZPTransitionAnimationTypeDefault,
    ZPTransitionAnimationTypePageTransition,
    ZPTransitionAnimationTypeViewMoveToNextVC,
    ZPTransitionAnimationTypeViewMoveNormalToNextVC,
    ZPTransitionAnimationTypeCover,
    ZPTransitionAnimationTypeSpreadFromRight,
    ZPTransitionAnimationTypeSpreadFromLeft,
    ZPTransitionAnimationTypeSpreadFromTop,
    ZPTransitionAnimationTypeSpreadFromBottom,
    ZPTransitionAnimationTypePointSpreadPresent,
    ZPTransitionAnimationTypeBoom,
    ZPTransitionAnimationTypeBrickOpenVertical,
    ZPTransitionAnimationTypeBrickOpenHorizontal,
    ZPTransitionAnimationTypeBrickCloseVertical,
    ZPTransitionAnimationTypeBrickCloseHorizontal,
    ZPTransitionAnimationTypeInsideThenPush,
    ZPTransitionAnimationTypeTipFlip,
    ZPTransitionAnimationTypeFade,
};

typedef NS_ENUM(NSInteger,ZPTransitionType){
    ZPTransitionTypePop,
    ZPTransitionTypePush,
    ZPTransitionTypePresent,
    ZPTransitionTypeDismiss,
};


typedef NS_ENUM(NSInteger,ZPGestureType){
    ZPGestureTypeNone,
    ZPGestureTypePanLeft,
    ZPGestureTypePanRight,
    ZPGestureTypePanUp,
    ZPGestureTypePanDown,
    
};
//系统动画类型
typedef NS_ENUM(NSInteger,ZPTransitionSysAnimationType){
    ZPTransitionSysAnimationTypeFade = 1,                   //淡入淡出
    ZPTransitionSysAnimationTypePush,                       //推挤
    ZPTransitionSysAnimationTypeReveal,                     //揭开
    ZPTransitionSysAnimationTypeMoveIn,                     //覆盖
    ZPTransitionSysAnimationTypeCube,                       //立方体
    ZPTransitionSysAnimationTypeSuckEffect,                 //吮吸
    ZPTransitionSysAnimationTypeOglFlip,                    //翻转
    ZPTransitionSysAnimationTypeRippleEffect,               //波纹
    ZPTransitionSysAnimationTypePageCurl,                   //翻页
    ZPTransitionSysAnimationTypePageUnCurl,                 //反翻页
    ZPTransitionSysAnimationTypeCameraIrisHollowOpen,       //开镜头
    ZPTransitionSysAnimationTypeCameraIrisHollowClose,      //关镜头
    ZPTransitionSysAnimationTypeCurlDown,                   //下翻页
    ZPTransitionSysAnimationTypeCurlUp,                     //上翻页
    ZPTransitionSysAnimationTypeFlipFromLeft,               //左翻转
    ZPTransitionSysAnimationTypeFlipFromRight,              //右翻转
};

#endif /* ZPTypedefConfig_h */
