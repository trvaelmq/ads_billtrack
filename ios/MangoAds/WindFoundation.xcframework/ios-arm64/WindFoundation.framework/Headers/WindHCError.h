//
//  WindHCError.h
//  WindHTTPCache
//
//  Created by Single on 2017/8/17.
//  Copyright © 2017年 Single. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WindHCErrorCode) {
    WindHCErrorCodeResponseUnavailable  = -192700,
    WindHCErrorCodeUnsupportContentType = -192701,
    WindHCErrorCodeNotEnoughDiskSpace   = -192702,
    WindHCErrorCodeException            = -192703,
};

@interface WindHCError : NSObject

+ (NSError *)errorForResponseUnavailable:(NSURL *)URL
                                 request:(NSURLRequest *)request
                                response:(NSURLResponse *)response;

+ (NSError *)errorForUnsupportContentType:(NSURL *)URL
                                  request:(NSURLRequest *)request
                                 response:(NSURLResponse *)response;

+ (NSError *)errorForNotEnoughDiskSpace:(long long)totlaContentLength
                                request:(long long)currentContentLength
                       totalCacheLength:(long long)totalCacheLength
                         maxCacheLength:(long long)maxCacheLength;

+ (NSError *)errorForException:(NSException *)exception;

@end
