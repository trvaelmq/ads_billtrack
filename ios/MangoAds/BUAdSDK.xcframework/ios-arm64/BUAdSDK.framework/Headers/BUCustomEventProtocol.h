//
//  BUCustomEventProtocol.h
//  Pods
//
//  Created by ByteDance on 4/17/25.
//

#ifndef BUCustomEventProtocol_h
#define BUCustomEventProtocol_h
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@protocol BUCustomEventProtocol <NSObject>

@optional
/// This method will call when special ad event raised;
/// @param nativeAd ad
/// @param code eventCode
/// @param info event Info
- (void)onCustomEventCode:(NSInteger)code info:(NSDictionary *)info;

@end
NS_ASSUME_NONNULL_END

#endif /* BUCustomEventProtocol_h */
