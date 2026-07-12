//
//  WindWKProcessPool.h
//  WebViewDemo
//
//  Created by Codi on 2021/11/19.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>


@class WindWebView;

@interface WindWKProcessPool : NSObject

@property (nonatomic, strong) WKProcessPool *processPool;

+ (instancetype)sharedInstance;
/// 从复用池中取出一个WebView，如果没有就创建
- (WindWebView *)getReusedWebView;
/// 把一个webView扔到复用池
- (void)recycleReusedWebView:(WindWebView *)webView;
/// 从可见池中移除
- (void)removeInVisiblePool:(WindWebView *)webView;

@end
