//
//  NSData+SMImageContentType.h
//  Window
//
//  Created by happyelements on 2018/7/26.
//  Copyright © 2018 Codi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WindFoundation/WindEnum.h>


@interface NSData (SMImageContentType)

/**
 *  Return image format
 *
 *  @param data the input image data
 *
 *  @return the image format as `SDImageFormat` (enum)
 */
+ (SigmobImageFormat)sm_imageFormatForImageData:(nullable NSData *)data;

/**
 Convert SDImageFormat to UTType
 
 @param format Format as SDImageFormat
 @return The UTType as CFStringRef
 */
//+ (nonnull CFStringRef)sm_UTTypeFromSDImageFormat:(SigmobImageFormat)format;

@end
