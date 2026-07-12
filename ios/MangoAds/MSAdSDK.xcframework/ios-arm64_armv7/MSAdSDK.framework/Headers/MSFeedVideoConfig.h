//
//  MSNativeFeedVideoConfig.h
//  MSAdSDK
//
//  Created by Liumaos on 2020/8/28.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSFeedVideoConfig : NSObject

@property(nonatomic,assign) BOOL isMute;
//视频是否自动播放，默认YES 仅ms、广点通设置有效
@property(nonatomic,assign) BOOL isAutoPlay;

@end

NS_ASSUME_NONNULL_END
