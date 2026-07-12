//
//  WindHCDataDownload.h
//  WindHTTPCache
//
//  Created by Single on 2017/8/12.
//  Copyright © 2017年 Single. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WindHCDataResponse.h"
#import "WindHCDataRequest.h"
#import "WindHCMacro.h"

WindHTTPCACHE_EXTERN NSString * const WindHCContentTypeVideo;
WindHTTPCACHE_EXTERN NSString * const WindHCContentTypeAudio;
WindHTTPCACHE_EXTERN NSString * const WindHCContentTypeApplicationMPEG4;
WindHTTPCACHE_EXTERN NSString * const WindHCContentTypeApplicationOctetStream;
WindHTTPCACHE_EXTERN NSString * const WindHCContentTypeBinaryOctetStream;

@class WindHCDownload;

@protocol WindHCDownloadDelegate <NSObject>

- (void)wind_download:(WindHCDownload *)download didCompleteWithError:(NSError *)error;
- (void)wind_download:(WindHCDownload *)download didReceiveResponse:(WindHCDataResponse *)response;
- (void)wind_download:(WindHCDownload *)download didReceiveData:(NSData *)data;

@end

@interface WindHCDownload : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)download;

@property (nonatomic) NSTimeInterval timeoutInterval;

/**
 *  Header Fields
 */
@property (nonatomic, copy) NSArray<NSString *> *whitelistHeaderKeys;
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> *additionalHeaders;

/**
 *  Content-Type
 */
@property (nonatomic, copy) NSArray<NSString *> *acceptableContentTypes;
@property (nonatomic, copy) BOOL (^unacceptableContentTypeDisposer)(NSURL *URL, NSString *contentType);

- (NSURLSessionTask *)downloadWithRequest:(WindHCDataRequest *)request delegate:(id<WindHCDownloadDelegate>)delegate;

@end
