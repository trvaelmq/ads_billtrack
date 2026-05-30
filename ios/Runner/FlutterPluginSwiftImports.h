#ifndef FLUTTER_PLUGIN_SWIFT_IMPORTS_H
#define FLUTTER_PLUGIN_SWIFT_IMPORTS_H

/* 非 Flutter 生成文件：由 Podfile post_install 让 GeneratedPluginRegistrant.m 引用。
 * 兼容 CocoaPods 两种头文件解析方式：直接指向 framework/Headers，或通过 -F 的 framework 风格路径。 */

#if __has_include(<path_provider_foundation/PathProviderPlugin.h>)
#import <path_provider_foundation/PathProviderPlugin.h>
#elif __has_include(<path_provider_foundation-Swift.h>)
#import <path_provider_foundation-Swift.h>
#elif __has_include(<path_provider_foundation/path_provider_foundation-Swift.h>)
#import <path_provider_foundation/path_provider_foundation-Swift.h>
#else
@import path_provider_foundation;
#endif

#if __has_include(<shared_preferences_foundation/SharedPreferencesPlugin.h>)
#import <shared_preferences_foundation/SharedPreferencesPlugin.h>
#elif __has_include(<shared_preferences_foundation-Swift.h>)
#import <shared_preferences_foundation-Swift.h>
#elif __has_include(<shared_preferences_foundation/shared_preferences_foundation-Swift.h>)
#import <shared_preferences_foundation/shared_preferences_foundation-Swift.h>
#else
@import shared_preferences_foundation;
#endif

#endif /* FLUTTER_PLUGIN_SWIFT_IMPORTS_H */
