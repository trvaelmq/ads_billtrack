//
//  WindHCDataUnitQueue.h
//  WindHTTPCache
//
//  Created by Single on 2017/8/11.
//  Copyright © 2017年 Single. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WindHCDataUnit.h"

@interface WindHCDataUnitQueue : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithPath:(NSString *)path NS_DESIGNATED_INITIALIZER;

- (NSArray<WindHCDataUnit *> *)allUnits;
- (WindHCDataUnit *)unitWithKey:(NSString *)key;

- (void)putUnit:(WindHCDataUnit *)unit;
- (void)popUnit:(WindHCDataUnit *)unit;

- (void)archive;

@end
