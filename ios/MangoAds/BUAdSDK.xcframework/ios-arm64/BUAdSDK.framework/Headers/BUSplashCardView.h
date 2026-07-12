//
//  BUSplashCardView.h
//  BUAdSDK
//
//  Created by ByteDance on 2022/3/23.
//

#import "BUInterfaceBaseView.h"

NS_ASSUME_NONNULL_BEGIN

__attribute__((objc_subclassing_restricted))

/// Please note: This Class does not take effect on Pangle global, only use it when you have traffic from mainland China.
@interface BUSplashCardView : BUInterfaceBaseView


/// Root view controller for handling ad actions.
@property (nonatomic, weak, readonly, nullable) UIViewController *rootViewController;

@end


NS_ASSUME_NONNULL_END
