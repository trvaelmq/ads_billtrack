//
//  BUMViewTrackerHelper.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUInterfaceBaseObject.h"
#import <UIKit/UIKit.h>

@interface BUMViewTrackerHelper : BUInterfaceBaseObject

+ (BOOL)checkIfViewInScreen:(UIView *)view;

/// 当前屏幕内展示的面积
+ (CGFloat)visibleAreaWithView:(UIView *)view;

@end
