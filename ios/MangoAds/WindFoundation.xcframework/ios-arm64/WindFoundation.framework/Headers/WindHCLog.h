//
//  WindHCLog.h
//  WindHTTPCache
//
//  Created by Single on 2017/8/17.
//  Copyright © 2017年 Single. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Log Enable Config
 */
#define WindHCLogEnable(target, console_log_enable, record_log_enable)               \
static BOOL const WindHCLog_##target##_ConsoleLogEnable = console_log_enable;        \
static BOOL const WindHCLog_##target##_RecordLogEnable = record_log_enable;

#define WindHCLogEnableValueConsoleLog(target)       WindHCLog_##target##_ConsoleLogEnable
#define WindHCLogEnableValueRecordLog(target)        WindHCLog_##target##_RecordLogEnable

/**
 *  Common
 */
WindHCLogEnable(Common,            YES, YES)

/**
 *  HTTP Server
 */
WindHCLogEnable(HTTPServer,        YES, YES)
WindHCLogEnable(HTTPConnection,    YES, YES)
WindHCLogEnable(HTTPResponse,      YES, YES)

/**
 *  Data Storage
 */
WindHCLogEnable(DataStorage,       YES, YES)
WindHCLogEnable(DataRequest,       YES, YES)
WindHCLogEnable(DataResponse,      YES, YES)
WindHCLogEnable(DataReader,        YES, YES)
WindHCLogEnable(DataLoader,        YES, YES)

WindHCLogEnable(DataUnit,          YES, YES)
WindHCLogEnable(DataUnitItem,      YES, YES)
WindHCLogEnable(DataUnitPool,      YES, YES)
WindHCLogEnable(DataUnitQueue,     YES, YES)

WindHCLogEnable(DataSourceManager, YES, YES)
WindHCLogEnable(DataFileSource,    YES, YES)
WindHCLogEnable(DataNetworkSource, YES, YES)

/**
 *  Download
 */
WindHCLogEnable(Download,          YES, YES)

/**
 *  Alloc & Dealloc
 */
WindHCLogEnable(Alloc,             YES, YES)
WindHCLogEnable(Dealloc,           YES, YES)

/**
 *  Log
 */
#define WindHCLogging(target, console_log_enable, record_log_enable, ...)            \
if (([WindHCLog log].consoleLogEnable && console_log_enable) || ([WindHCLog log].recordLogEnable && record_log_enable))       \
{                                                                                   \
    NSString *va_args = [NSString stringWithFormat:__VA_ARGS__];                    \
    NSString *log = [NSString stringWithFormat:@"%@  :   %@", target, va_args];     \
    if ([WindHCLog log].recordLogEnable && record_log_enable) {                      \
        [[WindHCLog log] addRecordLog:log];                                          \
    }                                                                               \
    if ([WindHCLog log].consoleLogEnable && console_log_enable) {                    \
        NSLog(@"%@", log);                                                          \
    }                                                                               \
}


/**
 *  Common
 */
#define WindHCLogCommon(...)                 WindHCLogging(@"WindHCMacro           ", WindHCLogEnableValueConsoleLog(Common),            WindHCLogEnableValueRecordLog(Common),            ##__VA_ARGS__)

/**
 *  HTTP Server
 */
#define WindHCLogHTTPServer(...)             WindHCLogging(@"WindHCHTTPServer       ", WindHCLogEnableValueConsoleLog(HTTPServer),        WindHCLogEnableValueRecordLog(HTTPServer),        ##__VA_ARGS__)
#define WindHCLogHTTPConnection(...)         WindHCLogging(@"WindHCHTTPConnection   ", WindHCLogEnableValueConsoleLog(HTTPConnection),    WindHCLogEnableValueRecordLog(HTTPConnection),    ##__VA_ARGS__)
#define WindHCLogHTTPResponse(...)           WindHCLogging(@"WindHCHTTPResponse     ", WindHCLogEnableValueConsoleLog(HTTPResponse),      WindHCLogEnableValueRecordLog(HTTPResponse),      ##__VA_ARGS__)

/**
 *  Data Storage
 */
#define WindHCLogDataStorage(...)            WindHCLogging(@"WindHCDataStorage      ", WindHCLogEnableValueConsoleLog(DataStorage),       WindHCLogEnableValueRecordLog(DataStorage),       ##__VA_ARGS__)
#define WindHCLogDataRequest(...)            WindHCLogging(@"WindHCDataRequest      ", WindHCLogEnableValueConsoleLog(DataRequest),       WindHCLogEnableValueRecordLog(DataRequest),       ##__VA_ARGS__)
#define WindHCLogDataResponse(...)           WindHCLogging(@"WindHCDataResponse     ", WindHCLogEnableValueConsoleLog(DataResponse),      WindHCLogEnableValueRecordLog(DataResponse),      ##__VA_ARGS__)
#define WindHCLogDataReader(...)             WindHCLogging(@"WindHCDataReader       ", WindHCLogEnableValueConsoleLog(DataReader),        WindHCLogEnableValueRecordLog(DataReader),        ##__VA_ARGS__)
#define WindHCLogDataLoader(...)             WindHCLogging(@"WindHCDataLoader       ", WindHCLogEnableValueConsoleLog(DataLoader),        WindHCLogEnableValueRecordLog(DataLoader),        ##__VA_ARGS__)

#define WindHCLogDataUnit(...)               WindHCLogging(@"WindHCDataUnit         ", WindHCLogEnableValueConsoleLog(DataUnit),          WindHCLogEnableValueRecordLog(DataUnit),          ##__VA_ARGS__)
#define WindHCLogDataUnitItem(...)           WindHCLogging(@"WindHCDataUnitItem     ", WindHCLogEnableValueConsoleLog(DataUnitItem),      WindHCLogEnableValueRecordLog(DataUnitItem),      ##__VA_ARGS__)
#define WindHCLogDataUnitPool(...)           WindHCLogging(@"WindHCDataUnitPool     ", WindHCLogEnableValueConsoleLog(DataUnitPool),      WindHCLogEnableValueRecordLog(DataUnitPool),      ##__VA_ARGS__)
#define WindHCLogDataUnitQueue(...)          WindHCLogging(@"WindHCDataUnitQueue    ", WindHCLogEnableValueConsoleLog(DataUnitQueue),     WindHCLogEnableValueRecordLog(DataUnitQueue),     ##__VA_ARGS__)

#define WindHCLogDataSourceManager(...)      WindHCLogging(@"WindHCDataSourceManager", WindHCLogEnableValueConsoleLog(DataSourceManager), WindHCLogEnableValueRecordLog(DataSourceManager), ##__VA_ARGS__)
#define WindHCLogDataFileSource(...)         WindHCLogging(@"WindHCDataFileSource   ", WindHCLogEnableValueConsoleLog(DataFileSource),    WindHCLogEnableValueRecordLog(DataFileSource),    ##__VA_ARGS__)
#define WindHCLogDataNetworkSource(...)      WindHCLogging(@"WindHCDataNetworkSource", WindHCLogEnableValueConsoleLog(DataNetworkSource), WindHCLogEnableValueRecordLog(DataNetworkSource), ##__VA_ARGS__)

/**
 *  Download
 */
#define WindHCLogDownload(...)               WindHCLogging(@"WindHCDownload         ", WindHCLogEnableValueConsoleLog(Download),          WindHCLogEnableValueRecordLog(Download),          ##__VA_ARGS__)

/**
 *  Alloc & Dealloc
 */
#define WindHCLogAlloc(obj)                  WindHCLogging(obj, WindHCLogEnableValueConsoleLog(Alloc),   WindHCLogEnableValueRecordLog(Alloc),   @"alloc")
#define WindHCLogDealloc(obj)                WindHCLogging(obj, WindHCLogEnableValueConsoleLog(Dealloc), WindHCLogEnableValueRecordLog(Dealloc), @"dealloc")

@interface WindHCLog : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)log;

/**
 *  DEBUG   : default is NO.
 *  RELEASE : default is NO.
 */
@property (nonatomic) BOOL consoleLogEnable;

/**
 *  DEBUG   : default is NO.
 *  RELEASE : default is NO.
 */
@property (nonatomic) BOOL recordLogEnable;

- (void)addRecordLog:(NSString *)log;

- (NSURL *)recordLogFileURL;
- (void)deleteRecordLogFile;

/**
 *  Error
 */
- (void)addError:(NSError *)error forURL:(NSURL *)URL;
- (NSDictionary<NSURL *, NSError *> *)errors;
- (NSError *)errorForURL:(NSURL *)URL;
- (void)cleanErrorForURL:(NSURL *)URL;

@end
