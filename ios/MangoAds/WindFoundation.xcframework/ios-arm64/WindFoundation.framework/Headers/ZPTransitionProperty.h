//
//  ZPTransitionProperty.h
//  ZPTransition
//
//  Created by Codi on 2023/9/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZPTypedefConfig.h"

@interface ZPTransitionProperty : NSObject
/**
 *  转场动画时间
 */
@property (nonatomic, assign) NSTimeInterval animationTime;

/**
 *  转场方式 ：push,pop,present,dismiss
 */
@property (nonatomic, assign) ZPTransitionType transitionType;

/**
 *  转场动画类型
 */
@property (nonatomic, assign) ZPTransitionAnimationType animationType;

/**
 *  是否采用系统原生返回方式
 */
@property (nonatomic, assign) BOOL isSysBackAnimation;

/**
 *  是否通过手势返回
 */
@property (nonatomic, assign) BOOL backGestureEnable;


/**
 *  在动画之前隐藏NavigationBar,动画结束后显示,默认为YES
 */
@property (nonatomic, assign) BOOL autoShowAndHideNavBar;

/**
 *  返回上个界面的手势 默认：右滑 ：ZPGestureTypePanRight
 */
@property (nonatomic,assign) ZPGestureType backGestureType;

/**
 *  转场动画类型
 */
@property (nonatomic, assign) ZPTransitionAnimationType backAnimationType;

/**
 *  View move 等动画中指定的起始视图
 *
 */
@property (nonatomic, strong) UIView *startView;
/**
 *  View move 等动画中指定的结束视图
 *
 */
@property (nonatomic, strong) UIView *targetView;

 /// startView通过toView转换后的frame
@property (nonatomic, assign) CGRect fromRect;

@end
