//
//  MSMacro.h
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/7/27.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#ifndef MSMacro_h
#define MSMacro_h

//是否是竖屏
#define IsPortrait ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown)

#define MSWS(weakSelf) __weak __typeof(&*self)weakSelf = self;

// RGB颜色转换（16进制->10进制）
#define MSUIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define MSUIColorFromRGBA(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF000000) >> 24))/255.0 \
green:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
blue:((float)(rgbValue & 0xFF00 >> 8))/255.0 \
alpha:((float)(rgbValue & 0xFF))/255.0]

#define msScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define msScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define msIs_ipad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define msIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define msIs_iPhoneX msScreenWidth >=375.0f && msScreenHeight >=812.0f&& msIs_iphone

 /*底部安全区域远离高度*/
#define msBottomSafeHeight (CGFloat)(msIs_iPhoneX?(34.0):(0))
/*iPhoneX的状态栏高度差值*/

static inline BOOL isMSIPhoneXSeries(void) {
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = nil;
        if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
            mainWindow = [[UIApplication sharedApplication].delegate window];
        } else {
            NSArray *windows = [UIApplication sharedApplication].windows;
            for (UIWindow *window in windows) {
                if (window.hidden == NO) {
                    mainWindow = window;
                    break;
                }
            }
        }
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            return YES;
        }
    }
    return NO;
}

#endif /* MSMacro_h */
