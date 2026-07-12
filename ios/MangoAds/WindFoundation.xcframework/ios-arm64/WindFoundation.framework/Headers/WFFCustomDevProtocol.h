//
//  WFFCustomDevProtocol.h
//  WindFoundation
//
//  Created by Codi on 2022/11/22.
//

@protocol WFFCustomDevProtocol <NSObject>

/**
 * 是否允许SDK主动使用地理位置信息
 *
 * @return YES可以获取，NO禁止获取
 */
- (BOOL)isCanUseLocation;

/**
 * 当isCanUseLocation=NO时，可传入地理位置信息，sdk使用您传入的地理位置信息
 *
 * @return 地理位置参数
 */

- (NSValue *)getLocation;

/**
 * 是否允许SDK主动获取IDFA信息
 *
 * @return YES可以获取，NO禁止获取。默认为YES
 */
- (BOOL)isCanUseIdfa;

/**
 * 当isCanUseIdfa=YES时，可传入idfa信息。sdk使用您传入的idfa信息
 *
 * @return idfa设备信息
 */
- (NSString *)getDevIdfa;

@end
