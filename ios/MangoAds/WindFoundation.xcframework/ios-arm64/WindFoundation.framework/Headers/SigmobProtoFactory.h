//
//  SigmobProtoFactory.h
//  WindFoundation
//
//  Created by Codi on 2021/10/27.
//

#import <Foundation/Foundation.h>
#import <WindFoundation/SigmobCommon.pbobjc.h>

@class SigmobConfigRequest;

@interface SigmobProtoFactory : NSObject

+ (SigmobDevice *)getPBDevice;

+ (SigmobGeo *)getPBGeo;

+ (SigmobNetwork *)getPBNetwork;

+ (SigmobApp *)getPBApp;

+ (SigmobVersion *)getPBVersion:(NSString *)version;

+ (SigmobSize *)getPBSize_Class;

+ (SigmobSize *)getPBResolutionSize;

+ (SigmobDeviceId *)getPBDeviceId;

@end
