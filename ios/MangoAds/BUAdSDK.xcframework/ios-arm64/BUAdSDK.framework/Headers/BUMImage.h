//
//  BUMImage.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUInterfaceBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface BUMImage : BUInterfaceBaseObject

// image.If is nil,Please use imageURL as the standard to display image.
@property (nonatomic, copy) UIImage *image;

// image address URL
@property (nonatomic, copy) NSURL *imageURL;

// image width
@property (nonatomic, assign) float width;

// image height
@property (nonatomic, assign) float height;

// image scale
@property (nonatomic, assign) float scale;

@end

NS_ASSUME_NONNULL_END
