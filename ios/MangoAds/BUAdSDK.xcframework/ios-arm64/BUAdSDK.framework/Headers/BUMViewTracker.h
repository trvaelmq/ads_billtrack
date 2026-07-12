//
//  BUMViewTracker.h
//  BUAdSDK
//
//  Created by 🦁 on 2022/12/16.
//

#import "BUInterfaceBaseObject.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, BUMViewTrackerRepeatType) {
    BUMViewTrackerRepeatType_none   = 1,          //上报一次
    BUMViewTrackerRepeatType_repeat = 2,          //重复检测上报
};

typedef NS_ENUM (NSInteger, BUMViewTrackerLastPresentation) {
    BUMViewTrackerLastPresentation_outScreen = 0,        //上次检测的上报时在屏幕外
    BUMViewTrackerLastPresentation_inScreen  = 1,        //上次检测的上报时在屏幕上
};

@protocol BUMViewTracker <NSObject>
@property (nonatomic, assign) BOOL isWitness;
@property (nonatomic, assign) BUMViewTrackerRepeatType repeatType;
@property (nonatomic, assign) BUMViewTrackerLastPresentation lastPresentation;
@property (nonatomic, assign) NSTimeInterval showTimestamp;
@property (nonatomic, copy) void (^ showEvent)(id<BUMViewTracker>);
@property (nonatomic, copy) void (^ hideEvent)(id<BUMViewTracker>);
@property (nonatomic, strong) NSDictionary *extra;
@property (nonatomic, strong) id admodel;

- (BOOL)invalid;
- (BOOL)checkIfViewInScreen;
- (void)snapShot;

@end

/*
 BUViewTracker用于单个view
 */
@interface BUMViewTracker : BUInterfaceBaseObject <BUMViewTracker>
@property (nonatomic, weak) UIView *view;
@property (nonatomic, strong) id admodel;
@property (nonatomic, strong) NSDictionary *extra;
@property (nonatomic, assign) BOOL isWitness;
@property (nonatomic, assign) BUMViewTrackerRepeatType repeatType;
@property (nonatomic, assign) BUMViewTrackerLastPresentation lastPresentation;
@property (nonatomic, copy) void (^ showEvent)(id<BUMViewTracker> tracker);
@property (nonatomic, copy) void (^ hideEvent)(id<BUMViewTracker> tracker);
@property (nonatomic, assign) NSTimeInterval showTimestamp;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *tag;

- (BOOL)checkIfViewInScreen;
- (BOOL)invalid;

@end

/*
 BUMNativeViewTracker用于多个view
 */
@interface BUMNativeViewTracker : BUInterfaceBaseObject  <BUMViewTracker>
@property (nonatomic, strong) NSPointerArray *views;
@property (nonatomic, strong) id admodel;
@property (nonatomic, strong) NSDictionary *extra;
@property (nonatomic, assign) BOOL isWitness;
@property (nonatomic, assign) BUMViewTrackerRepeatType repeatType;
@property (nonatomic, assign) BUMViewTrackerLastPresentation lastPresentation;
@property (nonatomic, copy) void (^ showEvent)(id<BUMViewTracker>);
@property (nonatomic, copy) void (^ hideEvent)(id<BUMViewTracker>);
@property (nonatomic, assign) NSTimeInterval showTimestamp;
@property (nonatomic, copy) NSString *tag;

- (BOOL)checkIfViewInScreen;
- (BOOL)invalid;

@end
