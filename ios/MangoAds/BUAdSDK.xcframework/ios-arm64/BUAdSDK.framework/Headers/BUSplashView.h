//
//  BUSplashView.h
//  BUAdSDK
//
//  Created by ByteDance on 2022/6/21.
//

#import "BUInterfaceBaseView.h"

NS_ASSUME_NONNULL_BEGIN
/// Please note: This Class does not take effect on Pangle global, only use it when you have traffic from mainland China.
@interface BUSplashView : BUInterfaceBaseView

// Whether splash view is valid.
- (BOOL)isAdValid;

@end

NS_ASSUME_NONNULL_END
