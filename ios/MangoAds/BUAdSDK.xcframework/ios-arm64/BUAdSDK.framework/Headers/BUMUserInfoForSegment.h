//
//  BUMUserInfoForSegment.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUInterfaceBaseObject.h"

typedef NS_ENUM (NSInteger, BUUserInfoGender) {
    BUUserInfoGenderFemale                   = 0,
    BUUserInfoGenderMale                     = 1,
    BUUserInfoGenderUnknown                  = 2,
    BUUserInfoGenderUnSet                    = 3 //default，can't use.
};

NS_ASSUME_NONNULL_BEGIN

@interface BUMUserInfoForSegment : BUInterfaceBaseObject

/// user_id
@property (nonatomic, copy, nullable) NSString *user_id;
/// 渠道
@property (nonatomic, copy, nullable) NSString *channel;
/// 子渠道
@property (nonatomic, copy, nullable) NSString *sub_channel;
/// 用户年龄
@property (nonatomic, assign) NSInteger age;
/// 用户性别
@property (nonatomic, assign) BUUserInfoGender gender;
/// 价值分组
@property (nonatomic, copy, nullable) NSString *user_value_group;

/// 自定义设置
/**
 要求:
    自定义参数key&value要求均为string
    字符为数字,字母,"-","_"任意组合
    长度上限为100
 */
@property (nonatomic, copy, nullable) NSDictionary *customized_id;

@end

NS_ASSUME_NONNULL_END
