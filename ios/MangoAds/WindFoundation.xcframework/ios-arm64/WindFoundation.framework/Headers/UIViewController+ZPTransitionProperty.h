//
//  UIViewController+ZPTransitionProperty.h
//  ZPTransition
//
//  Created by Codi on 2023/9/20.
//

#import <UIKit/UIKit.h>

@class ZPTransitionProperty;
@class ZPTransitionManager;

@interface UIViewController (ZPTransitionProperty)

typedef void(^ZPTransitionBlock)(ZPTransitionProperty *transition);

@property (nonatomic, copy  ) ZPTransitionBlock zp_callBackTransition;

@property (nonatomic, strong) ZPTransitionManager *zp_transition;

@property (nonatomic, assign) BOOL  zp_delegateFlag;
@property (nonatomic, assign) BOOL  zp_addTransitionFlag;
@property (nonatomic, assign) BOOL  zp_backGestureEnable;

@property (nonatomic, assign) UINavigationControllerOperation  zp_operation;

@property (nonatomic, weak  ) id    zp_transitioningDelegate;
@property (nonatomic, weak  ) id    zp_tempNavDelegate;


@end
