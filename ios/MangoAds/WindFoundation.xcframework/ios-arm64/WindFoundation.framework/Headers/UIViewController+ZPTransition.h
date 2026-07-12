//
//  UIViewController+ZPTransition.h
//  ZPTransition
//
//  Created by Codi on 2023/9/20.
//

#import <UIKit/UIKit.h>
#import "ZPTypedefConfig.h"
#import "ZPTransitionProperty.h"


@interface UIViewController (ZPTransition)<UIViewControllerTransitioningDelegate>


- (void)zp_presentViewController:(UIViewController *)toViewController 
                   animationType:(ZPTransitionAnimationType )animationType
                      completion:(void (^)(void))completion;

- (void)zp_presentViewController:(UIViewController *)toViewController
                  makeTransition:(ZPTransitionBlock )transitionBlock;

- (void)zp_presentViewController:(UIViewController *)toViewController
                   makeTransition:(ZPTransitionBlock )transitionBlock
                      completion:(void (^)(void))completion;

@end
