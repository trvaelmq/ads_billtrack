//
//  ZPTransitionManager.h
//  ZPTransition
//
//  Created by Codi on 2023/9/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZPTypedefConfig.h"
#import "ZPTransitionProperty.h"

@interface ZPTransitionManager : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) ZPTransitionProperty *property;

@property (nonatomic, copy) void(^animationDidStopBlock)(void);

- (BOOL)canAnimationWithType:(ZPTransitionAnimationType)animationType;

- (UIImage *)imageFromView:(UIView *)view atFrame:(CGRect)rect;


@end
