//
//  BUMVersion.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import <Foundation/Foundation.h>

#ifndef BUM_VERSION_H_
#define BUM_VERSION_H_

struct BUMVersion {
    NSInteger great;  // Great version.
    NSInteger major;  // Major version.
    NSInteger minor;  // Minor version.
    NSInteger patch;  // Patch version.
};
typedef struct BUMVersion BUMVersion;

/// create a version struct by values
static inline BUMVersion BUMVersionMake(NSUInteger great, NSUInteger major, NSUInteger minor, NSUInteger patch);

/// create a version struct by string, 4 values required, if less than 4, will be 0 from great, e.g @"1.2.3", great value is 0
static inline BUMVersion BUMVersionFromString(NSString *string);

/// convert version struct to string, may be called for log most
static inline NSString *NSStringFromBUMVersion(BUMVersion version);

/// compare two versions, first > second = 1, first < second = -1, first == second = 0
static inline int BUMVersionCompare(BUMVersion version1, BUMVersion version2);

/// compare two versions by string, BUMVersionCompare method will be called
static inline int BUMVersionCompareByString(NSString *version1, NSString *version2);

#pragma mark - Functions

static inline
BUMVersion BUMVersionMake(NSUInteger great, NSUInteger major, NSUInteger minor, NSUInteger patch) {
    BUMVersion version;
    version.great = great;
    version.major = major;
    version.minor = minor;
    version.patch = patch;
    return version;
}

static inline
BUMVersion BUMVersionFromString(NSString *string) {
    NSArray *vcs = [string componentsSeparatedByString:@"."];
    int limitCount = 4;
    BUMVersion version = {0};
    int minCount = MIN(limitCount, (int) vcs.count);
    NSInteger *p = (NSInteger *) &version;
    for (int i = 0; i < minCount; i++) {
        p[i] = [vcs[i] integerValue];
    }
    return version;
}

static inline
NSString *NSStringFromBUMVersion(BUMVersion version) {
    NSInteger *p = (NSInteger *) &version;
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; i < 4; i++) {
        if (p[i] == 0 && list.count == 0) continue;
        [list addObject:@(p[i])];
    }

    return [list componentsJoinedByString:@"."];
}

static inline
int BUMVersionCompare(BUMVersion version1, BUMVersion version2) {
    NSInteger *p1 = (NSInteger *) &version1;
    NSInteger *p2 = (NSInteger *) &version2;
    for (int i = 0; i < 4; i++) {
        if (p1[i] == p2[i]) continue;
        if (p1[i] > p2[i]) return 1;
        return -1;
    }
    return 0;
}

static inline
int BUMVersionCompareByString(NSString *version1, NSString *version2) {
    BUMVersion v1 = BUMVersionFromString(version1);
    BUMVersion v2 = BUMVersionFromString(version2);
    return BUMVersionCompare(v1, v2);
}

#endif
