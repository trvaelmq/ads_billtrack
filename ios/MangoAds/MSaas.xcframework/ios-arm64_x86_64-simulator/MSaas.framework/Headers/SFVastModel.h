//
//  SFVastModel.h
//  MSaasAdapter
//
//  Created by YJoo on 2024/11/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SFVastType) {
    SFVastTypeVideo = 0,
    SFVastTypePic,
    SFVastTypeVideoAndPic
};

@class MediaFileModel, CompanionModel, NonLinearModel, LinearModel;

@interface SFVastModel : NSObject

//VAST - Ad - InLine
@property (nonatomic, copy) NSString *adSystem;
@property (nonatomic, copy) NSString *adTitle;
@property (nonatomic, copy) NSString *adDescription;
@property (nonatomic, copy) NSString *survey;
@property (nonatomic, copy) NSString *error;

@property (nonatomic, strong) NSMutableArray *creative; //包含具体内容 linear companion unlinear
@property (nonatomic, strong) NSArray *impressionArr;  //展示上报url

-(NSMutableArray *) analysisVAST: (NSString *) xmlStr;

@end


@interface MediaFileModel : NSObject

@property (nonatomic, copy) NSString *idTag;
@property (nonatomic, copy) NSString *delivery;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *bitrate;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *scalable;
@property (nonatomic, copy) NSString *maintainAspectRatio;
@property (nonatomic, copy) NSString *apiFramework;

@end

@interface CompanionModel : NSObject

@property (nonatomic, copy) NSString *companionClickThrough;
@property (nonatomic, strong) NSMutableArray *clickTrackingArr;
@property (nonatomic, copy) NSString *creativeType;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *companionId;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *idTag;

@end

@interface LinearModel : NSObject

@property (nonatomic, copy) NSString *duration;
@property (nonatomic, strong) MediaFileModel *mediaFile;
@property (nonatomic, copy) NSDictionary *TrackingEvents;  //还不清楚是干嘛的
@property (nonatomic, copy) NSString *clickThrough;
@property (nonatomic, strong) NSMutableArray *clickTrackingArr;
@property (nonatomic, copy) NSString *idTag;
@property (nonatomic, copy) NSString *iconStaticResource;
@property (nonatomic, strong) NSMutableArray *iconClickTrackingArr;
@property (nonatomic, copy) NSString *iconClickThrough;

@property (nonatomic, strong) NSMutableDictionary *trackingEventDic;     //视频进度 key事件  value上报地址
//@property (nonatomic, copy) NSString *trackingEventUrl;  //视频进度上报

@end

@interface NonLinearModel : NSObject

@property (nonatomic, copy) NSString *idTag;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *expandedWidth;
@property (nonatomic, copy) NSString *expandedHeight;
@property (nonatomic, copy) NSString *scalable;
@property (nonatomic, copy) NSString *maintainAspectRatio;
@property (nonatomic, copy) NSString *minSuggestedDuration;
@property (nonatomic, copy) NSString *apiFramework;

@end

NS_ASSUME_NONNULL_END
