
#ifndef __SMExtensionConst__H__
#define __SMExtensionConst__H__

#import <Foundation/Foundation.h>

#ifndef SM_LOCK
#define SM_LOCK(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
#endif

#ifndef SM_UNLOCK
#define SM_UNLOCK(lock) dispatch_semaphore_signal(lock);
#endif

// 信号量
#define SMExtensionSemaphoreCreate \
static dispatch_semaphore_t signalSemaphore; \
static dispatch_once_t onceTokenSemaphore; \
dispatch_once(&onceTokenSemaphore, ^{ \
    signalSemaphore = dispatch_semaphore_create(1); \
});

#define SMExtensionSemaphoreWait SM_LOCK(signalSemaphore)
#define SMExtensionSemaphoreSignal SM_UNLOCK(signalSemaphore)

// 过期
#define SMExtensionDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 构建错误
#define SMExtensionBuildError(clazz, msg) \
NSError *error = [NSError errorWithDomain:msg code:250 userInfo:nil]; \
[clazz setSM_error:error];

// 日志输出
#ifdef DEBUG
#define SMExtensionLog(...) NSLog(__VA_ARGS__)
#else
#define SMExtensionLog(...)
#endif

/**
 * 断言
 * @param condition   条件
 * @param returnValue 返回值
 */
#define SMExtensionAssertError(condition, returnValue, clazz, msg) \
[clazz setSM_error:nil]; \
if ((condition) == NO) { \
    SMExtensionBuildError(clazz, msg); \
    return returnValue;\
}

#define SMExtensionAssert2(condition, returnValue) \
if ((condition) == NO) return returnValue;

/**
 * 断言
 * @param condition   条件
 */
#define SMExtensionAssert(condition) SMExtensionAssert2(condition, )

/**
 * 断言
 * @param param         参数
 * @param returnValue   返回值
 */
#define SMExtensionAssertParamNotNil2(param, returnValue) \
SMExtensionAssert2((param) != nil, returnValue)

/**
 * 断言
 * @param param   参数
 */
#define SMExtensionAssertParamNotNil(param) SMExtensionAssertParamNotNil2(param, )

/**
 * 打印所有的属性
 */
#define SMLogAllIvars \
- (NSString *)description \
{ \
    return [self sm_keyValues].description; \
}
#define SMExtensionLogAllProperties SMLogAllIvars

/** 仅在 Debugger 展示所有的属性 */
#define SMImplementDebugDescription \
- (NSString *)debugDescription \
{ \
return [self sm_keyValues].debugDescription; \
}

/**
 *  类型（属性类型）
 */
FOUNDATION_EXPORT NSString *const SMPropertyTypeInt;
FOUNDATION_EXPORT NSString *const SMPropertyTypeShort;
FOUNDATION_EXPORT NSString *const SMPropertyTypeFloat;
FOUNDATION_EXPORT NSString *const SMPropertyTypeDouble;
FOUNDATION_EXPORT NSString *const SMPropertyTypeLong;
FOUNDATION_EXPORT NSString *const SMPropertyTypeLongLong;
FOUNDATION_EXPORT NSString *const SMPropertyTypeChar;
FOUNDATION_EXPORT NSString *const SMPropertyTypeBOOL1;
FOUNDATION_EXPORT NSString *const SMPropertyTypeBOOL2;
FOUNDATION_EXPORT NSString *const SMPropertyTypePointer;

FOUNDATION_EXPORT NSString *const SMPropertyTypeIvar;
FOUNDATION_EXPORT NSString *const SMPropertyTypeMethod;
FOUNDATION_EXPORT NSString *const SMPropertyTypeBlock;
FOUNDATION_EXPORT NSString *const SMPropertyTypeClass;
FOUNDATION_EXPORT NSString *const SMPropertyTypeSEL;
FOUNDATION_EXPORT NSString *const SMPropertyTypeId;

#endif
