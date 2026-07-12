//
//  BUImage+Mediation.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUImage.h"

@protocol BUImageMediationProtocol;
typedef NSObject<BUImageMediationProtocol> BUImageMediation;

NS_ASSUME_NONNULL_BEGIN

@interface BUImage (Mediation)

@property (nonatomic, strong, nullable, readonly) BUImageMediation *mediation;

@end



@protocol BUImageMediationProtocol <NSObject>

// image.If is nil,Please use imageURL as the standard to display image.
@property (nonatomic, copy) UIImage *image;

// image scale
@property (nonatomic, assign) float scale;

@end

NS_ASSUME_NONNULL_END
