//
//  WindDislikeWords.h
//  WindSDK
//
//  Created by Codi on 2021/8/16.
//  Copyright © 2021 Codi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WindDislikeWords : NSObject

@property (nonatomic, copy, readonly) NSString *dislikeId;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSArray<WindDislikeWords *> *options;

@end

