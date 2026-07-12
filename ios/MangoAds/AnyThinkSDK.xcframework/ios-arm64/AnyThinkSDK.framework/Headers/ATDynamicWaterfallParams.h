//
//  ATDynamicWaterfallParams.h
//  AnyThinkSDK
//
//  Created by GUO PENG on 2024/5/24.
//  Copyright © 2024 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATDynamicWaterfallParams : NSObject
//动态瀑布流参数
//最大计算条数
@property (nonatomic, assign) NSInteger dynamicWaterfallMaxNCount;
//最小计算条数
@property (nonatomic, assign) NSInteger dynamicWaterfallMinMCount;
//是否基于流量分组维度
@property (nonatomic, assign) BOOL dynamicWaterfallOnlyGroup;
//查询的时间
@property (nonatomic, assign) NSInteger dynamicWaterfallDateCount;
//上浮层数
@property (nonatomic, assign) NSInteger dynamicWaterfallUpwards;
//层数系数
@property (nonatomic, assign) CGFloat dynamicWaterfallWeight;

//从数据查出来的数据，对比后得出的最高价
@property (nonatomic, strong) NSString *highestPrice;
@property (nonatomic, strong) NSString *highestPriceUnitID;

@property (nonatomic, assign) BOOL isNeedFetchDatabaseHighestPrice;

- (void)parseWithJsonString:(NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END
