//
//  BUMUIResponderHelper.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUInterfaceBaseObject.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUMUIResponderHelper : BUInterfaceBaseObject

// 获取当前应用的广义mainWindow
+ (nullable UIWindow *)mainWindow;

// 获取广义mainWindow的rootViewController
+ (nullable UIViewController *)mainWindowRootViewController;

// 广义mainWindow的大小（兼容iOS7）
+ (CGSize)windowSize;

// 获取指定UIResponder的链下游第一个ViewController对象
+ (nullable UIViewController *)nextViewControllerFor:(UIResponder *_Nullable)responder;

// 获取指定UIResponder的链下游第一个UINavigationController对象
+ (nullable UINavigationController *)nextNavigationControllerFor:(UIResponder *_Nullable)responder;

/** 查找当前显示的ViewController*/
+ (UIViewController *)topViewController;

+ (UIViewController *)topViewControllerOfWindow:(UIWindow *)window;

+ (UIViewController *)recursiveFindCurrentShowViewControllerFromViewController:(UIViewController *)fromVC;
@end

NS_ASSUME_NONNULL_END
