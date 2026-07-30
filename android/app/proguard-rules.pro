# ============================================================
# 芒果(SF/YD SaaS) 聚合广告 SDK + 优量汇(GDT) 混淆保留规则
#
# 说明：libs/*.aar 通过 fileTree 本地引入，AGP/R8 不会自动应用
# AAR 内置的 consumer proguard.txt。开启 minify 后必须在此手动保留，
# 否则 release 包会混淆/裁剪 SDK 类导致无广告或崩溃。
# 规则来源：各 aar 内 proguard.txt 原样抄录。
# ============================================================

# ---- 芒果核心 mg_2.9.0 (com.yd.saas.s2s) ----
-keep class com.yd.** { *; }
-keep class com.android.general.** { *; }
-keep class com.ms.saas.** { *; }
-keep class com.sm.saas.** { *; }
-keep class com.hm.saas.** { *; }
-keep class com.jinbig.hmad.** { *; }
-keep class com.jinbeig.wkad.saas.** { *; }
-keep class com.nnadsdk.wpn.sdk.** { *; }
-keep class com.tide.host.** { *; }
-keep class com.tide.protocol.** { *; }
-keep class com.ima.fs.sdk.** { *; }
-keep class com.google.android.inner_exoplayer2.** { *; }
-keep class com.zm.adxsdk.** { *; }
-keep class com.zm.wfsdk.phonemark.** { *; }
-keep class com.zm.fda.** { *; }
-keep class zm.com.** { *; }
-keep class com.hardcoremobi.** { *; }
-keep class com.hardcore.** { *; }
-keeppackagenames com.mg.ad.**
-keeppackagenames com.emsdk.**
-keeppackagenames com.mg.ad
-keeppackagenames com.emsdk
-dontwarn com.yd.saas.**
-ignorewarnings

# ---- 优量汇 GDT adapter (mg_adapter_gdt) ----
-keep class com.yd.saas.gdt.** { *; }

# ---- 优量汇 GDT SDK (com.qq.e) ----
-keep class com.qq.e.** {
    public protected *;
}

# ============================================================
# 以下为各平台 AAR 内置 consumer proguard.txt 的自动抽取合并
# (全平台接入 v3.1.8.6.17 demo，脚本从 libs/**/*.aar 提取)
# ============================================================

# ================= from mg_adapter_adhub_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.adhub.** { *; }


-ignorewarnings

-dontoptimize
-dontpreverify
-dontwarn android.app.**
-dontwarn android.support.**
-dontwarn sun.misc.**
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn android.support.**
-dontwarn com.beizi.fusion.**
-dontwarn com.beizi.ad.**

-keep class sun.misc.**{*;}
-keep class android.support.** { *; }
-keep class android.app.**{*;}
-keep class **.R$* {*;}

-keep class com.beizi.fusion.** {*; }
-keep class com.beizi.ad.** {*; }

-keep class com.qq.e.** {
    public protected *;
}

-keepattributes Exceptions,InnerClasses,Signature,Deprecated,SourceFile,LineNumberTable,*Annotation*,EnclosingMethod

-dontwarn  org.apache.**

-dontwarn com.baidu.mobads.sdk.api.**
-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
}

-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

-keep class com.baidu.mobads.** { *; }
-keep class com.style.widget.** {*;}
-keep class com.component.** {*;}
-keep class com.baidu.ad.magic.flute.** {*;}
-keep class com.baidu.mobstat.forbes.** {*;}

-keep class com.bytedance.sdk.openadsdk.** { *; }
-keep public interface com.bytedance.sdk.openadsdk.downloadnew.** {*;}
-keep class com.pgl.sys.ces.** {*;}
-keep class com.bytedance.embed_dr.** {*;}
-keep class com.bytedance.embedapplog.** {*;}

-keep class XI.CA.XI.**{*;}
-keep class XI.K0.XI.**{*;}
-keep class XI.XI.K0.**{*;}
-keep class XI.xo.XI.XI.**{*;}
-keep class com.asus.msa.SupplementaryDID.**{*;}
-keep class com.asus.msa.sdid.**{*;}
-keep class com.bun.lib.**{*;}
-keep class com.bun.miitmdid.**{*;}
-keep class com.huawei.hms.ads.identifier.**{*;}
-keep class com.samsung.android.deviceidservice.**{*;}
-keep class com.zui.opendeviceidlibrary.**{*;}
-keep class org.json.**{*;}
-keep public class com.netease.nis.sdkwrapper.Utils {public <methods>;}

-keep class org.chromium.** {*;}
-keep class org.chromium.** { *; }
-keep class aegon.chrome.** { *; }
-keep class com.kwai.**{ *; }
-dontwarn com.kwai.**
-dontwarn com.kwad.**
-dontwarn com.ksad.**
-dontwarn aegon.chrome.**

-ignorewarnings

-dontoptimize
-dontpreverify
-dontwarn android.app.**
-dontwarn android.support.**
-dontwarn sun.misc.**
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn android.support.**
-dontwarn com.beizi.fusion.**
-dontwarn com.beizi.ad.**

-keep class sun.misc.**{*;}
-keep class android.support.** { *; }
-keep class android.app.**{*;}
-keep class **.R$* {*;}

-keep class com.beizi.fusion.** {*; }
-keep class com.beizi.ad.** {*; }

-keep class com.qq.e.** {
    public protected *;
}

# ================= from adprof-sdk-2.2.5-release.aar =================


# ==================== 基础配置 ====================
# 启用代码压缩和优化（压缩包体）
# 注意：不设置 -dontshrink 和 -dontoptimize，启用压缩和优化
-optimizationpasses 7
-allowaccessmodification
-mergeinterfacesaggressively
-overloadaggressively
-repackageclasses 'com.adprof.sdk'

# 启用代码优化算法（压缩包体，但保留必要的优化）
-optimizations !code/simplification/arithmetic,!code/simplification/cast,!field/*,!class/merging/*,!code/allocation/variable

# 混淆配置（更严格的混淆）
-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-dontpreverify

# 隐藏源文件名（防止反编译看到源码结构）
-renamesourcefileattribute SourceFile

# 保留必要的属性（最小化保留）
-keepattributes Signature,Exceptions,InnerClasses,EnclosingMethod
-keepattributes *Annotation*
-keepattributes JavascriptInterface

# 混淆时是否记录日志
-verbose
# 保留 R 类
-keep class **.R$* {*;}

# ==================== Android 系统类保留（最小化）====================
# 只保留必要的 Android 组件类（SDK 内部使用的）
# 注意：Activity 类名必须保留（Manifest 需要），但允许混淆方法和字段
-keepnames public class * extends android.app.Activity
-keep public class * extends android.app.Application {
    public <methods>;
}
-keep public class * extends android.app.Service {
    public <methods>;
}
-keep public class * extends android.content.ContentProvider {
    public <methods>;
}

# AdxActivity 允许被混淆（只保留类名，因为 AndroidManifest 需要）
# 类名必须保留（Manifest 需要），但方法、字段可以被混淆
-keepnames class com.adprof.sdk.base.activity.AdxActivity
# 保留 companion object 中的常量（Kotlin 编译后是静态字段，其他类通过 AdxActivity 引用）
-keepclassmembers class com.adprof.sdk.base.activity.AdxActivity$Companion {
    public static final String KEY_GET_INFO_KEY;
    public static final String KEY_DP_URL;
    public static final String KEY_PKG_NAME;
    public static final String KEY_CALLER_PKG_NAME;
    public static final String KEY_DDP;
    public static final String TAG;
}

-keepnames class com.adprof.sdk.base.activity.XX

# 保留 companion object 中的常量（Kotlin 编译后是静态字段）
-keepclassmembers class com.adprof.sdk.base.activity.XX$Companion {
    public static final String KEY_GET_INFO_KEY;
    public static final String KEY_DP_URL;
    public static final String KEY_PKG_NAME;
    public static final String KEY_CALLER_PKG_NAME;
    public static final String KEY_DDP;
    public static final String TAG;
}

# Keep NoProguard interface and all classes that implement it
-keep interface com.adprof.sdk.api.NoProguard
-keep class * implements com.adprof.sdk.api.NoProguard { *; }

# ==================== 第三方库处理 ====================
-dontwarn org.apache.http.**
-dontwarn android.net.**
-keepattributes MethodParameters
# 忽略警告（减少构建噪音）
-ignorewarnings
#不混淆Serializable接口的子类中指定的某些成员变量和方法
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# ==================== 序列化类保留 ====================
# 保留序列化相关的成员（如果 SDK 中有序列化需求）


-keep class com.adprof.sdk.AdprofSdk{public *;}
-keep class com.adprof.sdk.BuildConfig{public *;}
-keep class com.adprof.sdk.api.AFFileProvider{public *;protected *;}

# 保留 native 方法类 X（不能被混淆）
-keep class com.adprof.sdk.base.x.X { *; }

# 保留 Android 系统类，确保 JNI 反射调用可用
# Intent 和 Uri 是系统类，不会被混淆，但为了确保反射访问的方法和字段可用，明确保留
-keep class android.content.Intent {
    <init>();
    <init>(java.lang.String);
    <init>(java.lang.String, android.net.Uri);
    public static final java.lang.String ACTION_VIEW;
    public static final int FLAG_ACTIVITY_NEW_TASK;
    public static final int FLAG_ACTIVITY_CLEAR_TASK;
    public android.content.Intent setAction(java.lang.String);
    public android.content.Intent setData(android.net.Uri);
    public android.content.Intent setFlags(int);
    public android.content.Intent addFlags(int);
    public static android.content.Intent createChooser(android.content.Intent, java.lang.CharSequence);
}

-keep class android.net.Uri {
    public static android.net.Uri parse(java.lang.String);
}

-keep class android.app.Activity {
    public void startActivityForResult(android.content.Intent, int);
}


# ==================== SDK 公共 API 保留（最小化）====================
# 只保留公共 API，内部实现类全部混淆
-keep class com.adprof.sdk.api.** {
    public <methods>;
    public <fields>;
}
-keep interface com.adprof.sdk.api.** {
    public <methods>;
}

-keepclassmembers class com.adprof.sdk.base.network.pb.** {
    public static final android.os.Parcelable$Creator CREATOR;
    public static final com.adprof.sdk.base.network.proto.ProtoAdapter ADAPTER;
}

-keepclassmembers class com.adprof.sdk.base.network.proto.** {
    public static final android.os.Parcelable$Creator CREATOR;
    public static final com.adprof.sdk.base.network.proto.ProtoAdapter ADAPTER;
}

# 保留BuildConfig
-keep class com.adprof.sdk.BuildConfig {
    *;
}

-keep class com.hihonor.**{*;}
-keep class com.huawei.**{*;}

# 保留荣耀SDK相关类
-keep class com.hihonor.ads.identifier.** { *; }
-keepclassmembers class com.hihonor.ads.identifier.** { *; }

# 特别保留AdvertisingIdClient和Info类
-keep class com.hihonor.ads.identifier.AdvertisingIdClient { *; }
-keep class com.hihonor.ads.identifier.AdvertisingIdClient$Info { *; }

# 保护枚举类（包括内部枚举类）
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
-keepclassmembers class * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}



-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}


-keepattributes Signature, Deprecated, *Annotation*, EnclosingMethod, Exceptions, *Enum*

# ================= from mg_adapter_adprof_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.adprof.** { *; }

# Adprof混淆
-dontwarn com.adprof.sdk.**
-keep class com.adprof.sdk.** {*;}
-keep interface com.adprof.**{ *;}

# ================= from mg_adapter_baidu_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.bd.** { *; }

-ignorewarnings
-dontwarn com.baidu.mobads.sdk.api.**
-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
}

-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

-keep class com.baidu.mobads.** { *; }
-keep class com.style.widget.** {*;}
-keep class com.component.** {*;}
-keep class com.baidu.ad.magic.flute.** {*;}
-keep class com.baidu.mobstat.forbes.** {*;}


-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
}

-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
-ignorewarnings

-keep class com.baidu.mobads.** { *; }
-keep class com.bun.miitmdid.core.** {*;}

-keep class com.style.widget.** {*;}
-keep class com.component.** {*;}

-keep class com.baidu.ad.magic.flute.** {*;}
-keep class com.baidu.mobstat.forbes.** {*;}

#保持 native 方法不被混淆
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep native methods
-keepclassmembers class * {
    native <methods>;
}


#FBReader native层调用java代码配置
-keep class org.geometerplus.zlibrary.core.library.ZLibrary {*;}
-keep class org.geometerplus.zlibrary.core.filesystem.ZLFile {*;}
-keep interface org.geometerplus.zlibrary.text.model.ZLTextModel {*;}
-keep class org.geometerplus.zlibrary.text.model.CachedCharStorageException {*;}
-keep class org.geometerplus.zlibrary.core.encodings.Encoding {*;}
-keep class org.geometerplus.zlibrary.core.encodings.EncodingConverter {*;}
-keep class org.geometerplus.zlibrary.core.encodings.JavaEncodingCollection {*;}
-keep class org.geometerplus.fbreader.formats.NativeFormatPlugin {*;}
-keep class org.geometerplus.fbreader.formats.PluginCollection {*;}
-keep class org.geometerplus.fbreader.Paths {*;}
-keep class org.geometerplus.fbreader.book.Book {*;}
-keep class org.geometerplus.fbreader.book.Tag {*;}
-keep class org.geometerplus.fbreader.bookmodel.NativeBookModel {*;}
-keep public class com.baidu.novel.android.common.util.Util { *; }

#保持okhttp不被混淆
-dontwarn com.baidu.searchbox.novel.okhttp3.**
-keep class com.baidu.searchbox.novel.okhttp3.**{ *; }
-keep interface com.baidu.searchbox.novel.okhttp3.**{ *; }

#gson
-keepclassmembers,allowobfuscation class * {
 @com.baidu.searchbox.novel.gson.annotations.SerializedName <fields>;
}

# 单针对该类做keep处理
-keep public class com.baidu.android.common.util.Util { *; }

# 自定义控件
-keepclasseswithmembers class * {
    public <init>(android.content.Context);
}
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

-keep class **.R$* {
 public static <fields>;
}

-keep class com.baidu.searchbox.reader.ReaderPluginApi{*;}
#UBC
-keep class com.baidu.ubc.* {*;}

#不能混淆RecyclerView的内部类，SDK有使用
-keep class android.support.v7.widget.RecyclerView {*;}
-keepnames class android.support.v7.widget.RecyclerView$* {
    public <fields>;
    public <methods>;
}
-keep class android.support.v7.widget.LinearLayoutManager {*;}
-keep class android.support.v7.widget.PagerSnapHelper {*;}
-keep class android.support.v4.view.ViewCompat {*;}
-keep class android.support.v4.util.LongSparseArray {*;}
-keep class android.support.v4.util.ArraySet {*;}
-keep class android.support.v4.view.accessibility.AccessibilityNodeInfoCompat {*;}

# ================= from mg_adapter_csj_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line_vertical number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line_vertical number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.tt.** { *; }

#聚合混淆
-keep class bykvm*.**
-keep class com.bytedance.msdk.adapter.**{ public *; }
-keep class com.bytedance.msdk.api.** {
 public *;
}
-keep class com.bytedance.msdk.base.TTBaseAd{*;}
-keep class com.bytedance.msdk.adapter.TTAbsAdLoaderAdapter{
    public *;
    protected <fields>;
}

# ================= from open_ad_sdk_7.5.1.0.aar =================
-keep class com.bytedance.pangle.** {*;}

-keep class ms.bz.bd.** {*;}
-keep class com.volcengine.mobsecBiz.** {*;}

-keep class com.bykv.vk.** {*;}
#自有Adapter入口
-keep class a.b.c.d.e.f.aob.AobFunction { *; }
-keep class a.b.c.d.e.f.bdu.BduFunction { *; }
-keep class a.b.c.d.e.f.gng.GngFunction { *; }
-keep class a.b.c.d.e.f.kou.KouFunction { *; }
-keep class a.b.c.d.e.f.mal.MalFunction { *; }
-keep class a.b.c.d.e.f.sob.SobFunction { *; }
-keep class a.b.c.d.e.f.uty.UtyFunction { *; }
-keep class a.b.c.d.e.f.xmi.XmiFunction { *; }
-keep class com.bytedance.android.**{*;}
-keep class com.byted.live.**{*;}
-keep class com.ss.ttm.**{*;}
-keep class com.ss.vcbkit.**{*;}
-keep class com.ss.videoarch.**{*;}
-keep class com.byakv.** {*;}
-keep class com.byazt.** {*;}

# ================= from mg_adapter_dm_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.dm.** { *; }
#TODO 多盟SDK混淆配置
-dontwarn com.domob.sdk.**
-keep class com.domob.sdk.**{*;}
-keep interface com.domob.sdk.**{*;}

#TODO protobuf混淆
-dontwarn com.google.protobuf.**
-dontwarn google.protobuf.**
-keep class com.google.protobuf.** { *; }
-keep class google.protobuf.** { *; }

#TODO oaid 混淆配置，不同版本混淆代码不太一致，注意你接入的oaid版本，不接入oaid可以不添加
-keep class XI.CA.XI.**{*;}
-keep class XI.K0.XI.**{*;}
-keep class XI.XI.K0.**{*;}
-keep class XI.vs.K0.**{*;}
-keep class XI.xo.XI.XI.**{*;}
-keep class com.asus.msa.SupplementaryDID.**{*;}
-keep class com.asus.msa.sdid.**{*;}
-keep class com.bun.lib.**{*;}
-keep class com.bun.miitmdid.**{*;}
-keep class com.huawei.hms.ads.identifier.**{*;}
-keep class com.samsung.android.deviceidservice.**{*;}
-keep class org.json.**{*;}
-keep public class com.netease.nis.sdkwrapper.Utils {
    public <methods>;
}

#TODO Glide 混淆配置
-dontwarn com.bumptech.glide.**
-keep class com.bumptech.glide.**{*;}
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep public class * extends com.bumptech.glide.AppGlideModule
-keep public enum com.bumptech.glide.load.resource.bitmap.ImageHeaderParser$** {
  **[] $VALUES;
  public *;
}

# ================= from mg_adapter_fg_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line_vertical number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line_vertical number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.fg.** { *; }
-keep class com.sy.adsdk.**{ *; }

# ================= from sy_ad_sdk_release_2.3.6.0_1768894693732.aar =================
-keep class com.sy.adsdk.**{ *; }

# ================= from mg_adapter_fl_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.fl.** { *; }

# ================= from fissionSdk-release-1.0.91.74-amp.aar =================


-keep class com.tide.host.** { *; }

-keep class com.tide.protocol.** { *; }

#androidx
-keep class com.google.android.material.** {*;}
-keep class androidx.** {*;}
-keep public class * extends androidx.**
-keep interface androidx.** {*;}
-dontwarn com.google.android.material.**
-dontnote com.google.android.material.**
-dontwarn androidx.**

#关闭优化
-dontoptimize
#忽略警告
-ignorewarnings
#R文件不混淆
-keepattributes Signature
#保留行号
-keepattributes SourceFile,LineNumberTable
#避免混淆注解、内部类、泛型、匿名类
-keepattributes *Annotation*,InnerClasses,Signature,EnclosingMethod

-keep class com.zm.fissionsdk.** { *; }
-keep class com.zm.adxsdk.** { *; }

-keep class com.google.android.inner_exoplayer2.** { *; }

-keep class com.zm.adxsdk.protocol.**{ *; }

-keep class com.zm.wfsdk.phonemark.**{ *; }

-keep class com.zm.adxsdk.tools.** { *; }
-keep class com.google.common.base.Defaults { *; }

#关闭压缩--防止部分反射方法或者参数被删除
#-dontshrink
#关闭优化
-dontoptimize
#忽略警告
-ignorewarnings
#R文件不混淆
-keepattributes Signature
#保留行号
-keepattributes SourceFile,LineNumberTable
#避免混淆注解、内部类、泛型、匿名类
-keepattributes *Annotation*,InnerClasses,Signature,EnclosingMethod

-keep class com.zm.fda.**{ *; }








-keep class com.tide.host.** { *; }

-keep class com.tide.protocol.** { *; }

#androidx
-keep class com.google.android.material.** {*;}
-keep class androidx.** {*;}
-keep public class * extends androidx.**
-keep interface androidx.** {*;}
-dontwarn com.google.android.material.**
-dontnote com.google.android.material.**
-dontwarn androidx.**

#关闭优化
-dontoptimize
#忽略警告
-ignorewarnings
#R文件不混淆
-keepattributes Signature
#保留行号
-keepattributes SourceFile,LineNumberTable
#避免混淆注解、内部类、泛型、匿名类
-keepattributes *Annotation*,InnerClasses,Signature,EnclosingMethod

-keep class com.zm.fissionsdk.** { *; }
-keep class com.zm.adxsdk.** { *; }

-keep class com.google.android.inner_exoplayer2.** { *; }

-keep class com.zm.adxsdk.protocol.**{ *; }

-keep class com.zm.wfsdk.phonemark.**{ *; }

-keep class com.zm.adxsdk.tools.** { *; }
-keep class com.google.common.base.Defaults { *; }

#关闭压缩--防止部分反射方法或者参数被删除
#-dontshrink
#关闭优化
-dontoptimize
#忽略警告
-ignorewarnings
#R文件不混淆
-keepattributes Signature
#保留行号
-keepattributes SourceFile,LineNumberTable
#避免混淆注解、内部类、泛型、匿名类
-keepattributes *Annotation*,InnerClasses,Signature,EnclosingMethod

-keep class com.zm.fda.**{ *; }

# ================= from mg_adapter_fs_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line_vertical number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line_vertical number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.fs.** { *; }

# ================= from GDTSDK.unionNormal.4.671.1541.aar =================
-keep class com.qq.e.** {
    public protected *;
}

# ================= from mg_adapter_gdt_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line_vertical number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line_vertical number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.gdt.** { *; }

-keep class com.qq.e.** {
    public protected *;
}

# ================= from mg_adapter_hc_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line_vertical number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line_vertical number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.hc.** { *; }

# ================= from noah-13.9.4008-139.aar =================
#反射调用adn构造
-keep class com.noah.adn.**Adn{
    public <methods>;
}

-dontwarn com.noah.**
-keep class com.noah.** { *; }
-keep class com.noah.sp.SharedPreferencesNewImpl { *; }
-keep class com.noah.sp.SharedPreferencesNewImpl$* { *; }
-keep class com.noah.sp.SpThreadPool { *; }
-keep class com.noah.sp.SharedPreferencesUtils { *; }

-keep class com.noah.plugin.api.load.compat.PathMapperV21 { *; }
-keep class com.noah.plugin.** { *; }
-keep class com.noah.sp.** { *; }
-keep class com.noah.sdk.dg.** { *; }

-keep class com.noah.apm.**{*;}
-dontwarn com.alibaba.wireless.security.**

#依赖的adn的组件，不打到包里面，外部可以选择性添加依赖
-dontwarn com.adcolony.**
-dontwarn com.ironsource.**
-dontwarn com.google.android.gms.ads.**
-dontwarn com.facebook.ads.**
-dontwarn com.vungle.**
-dontwarn com.applovin.**
-dontwarn com.startapp.**
-dontwarn com.noah.external.utdid.tapjoy.**
-dontwarn com.facebook.bidding.**
-dontwarn com.unity3d.**
-dontwarn com.qq.**
-dontwarn com.bytedance.**
-dontwarn com.alimm.tanx.**
-dontwarn com.shuqi.**
-dontwarn com.noah.external.download.**
-dontwarn com.ucx.analytics.**
-dontwarn oauth.signpost.**

#lambda相关告警
-dontwarn java.lang.invoke.**

# EventBus 莫名其妙的反射
-keepclassmembers,includedescriptorclasses class ** { public void onEvent*(**); }
#避免插件的ui组件被混淆
-keepnames class com.noah.sdk.plug.** { *; }
## 以上是自己解决各种问题添加的混淆规则



## 以下是adn开发文档明确要求添加的混淆规则，直接copy过来
# AdColony sdk 开发文档要求添加
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# om sdk 开发文档要求添加
-keep class com.iab.omid.** { *; }
-dontwarn com.iab.omid.**
# om sdk 要求添加

# tapjoy sdk 开发文档要求添加
-keep class com.noah.external.utdid.tapjoy.** { *; }
-keep class com.moat.** { *; }
# tapjoy sdk 开发文档要求添加

# 头条穿山甲开发文档要求添加
-keep class com.bytedance.sdk.openadsdk.** { *; }
-keep public interface com.bytedance.sdk.openadsdk.downloadnew.** {*;}
-keep class com.pgl.sys.ces.* {*;}
-dontwarn com.ss.android.socialbase.downloader.downloader.a
-dontwarn com.ss.android.socialbase.downloader.model.DownloadInfo

# 头条穿山甲开发文档要求添加

#HuaWei
-keep class com.huawei.hms.ads.identifier.**{*;}
-keep class com.huawei.openalliance.ad.** { *; }
-dontwarn com.huawei.**

#oaid
-keep class com.bun.miitmdid.core.** {*;}
-keep class com.bun.supplier.** {*;}

# Vungle sdk 开发文档要求添加
-keep class com.vungle.warren.** { *; }
-keep class com.vungle.warren.downloader.DownloadRequest
-dontwarn com.vungle.warren.error.VungleError$ErrorCode
-dontwarn com.vungle.warren.downloader.DownloadRequest$Status
-keepclassmembers enum com.vungle.warren.** { *; }
# Moat SDK
-keep class com.moat.** { *; }
-dontwarn com.moat.**
-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement
-keepattributes *Annotation*
# Retrofit
-keepattributes Signature, InnerClasses
-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement
-dontwarn javax.annotation.**
-dontwarn kotlin.Unit
-dontwarn retrofit2.-KotlinExtensions
-keepclassmembers,allowshrinking,allowobfuscation interface * {
    @retrofit2.http.* <methods>;
}
# Okio+OkHttp
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**
-dontwarn org.conscrypt.**
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase
-keepclassmembers class * extends com.vungle.warren.persistence.Memorable {
   public <init>(byte[]);
}
# Vungle sdk 开发文档要求添加

# Ironsource sdk 开发文档要求添加
-keepclassmembers class com.ironsource.sdk.controller.IronSourceWebView$JSInterface {
    public *;
}
-keepclassmembers class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}
-keep public class com.google.android.gms.ads.** {
   public *;
}
-keep class com.ironsource.adapters.** { *;
}
-dontwarn com.moat.**
-keep class com.moat.** { public protected private *; }
# Ironsource sdk 开发文档要求添加

#utdid组件的UmidUtils需要依赖无线保镖的com.alibaba.wireless.security.open.SecurityGuardManager，Noah sdk使用utdid的业务不需要用到无线保镖
-dontwarn com.noah.external.utdid.ta.audid.utils.UmidUtils

###以下为百度开发者文档要求添加
-dontwarn com.baidu.mobads.sdk.api.**
-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
}
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
-keep class com.baidu.mobads.** { *; }
-keep class com.style.widget.** {*;}
-keep class com.component.** {*;}
-keep class com.baidu.ad.magic.flute.** {*;}
-keep class com.baidu.mobstat.forbes.** {*;}
#9.22版本新增加混淆
-keep class android.support.v7.widget.RecyclerView {*;}
-keepnames class android.support.v7.widget.RecyclerView$* {
    public <fields>;
    public <methods>;
}
-keep class android.support.v7.widget.LinearLayoutManager {*;}
-keep class android.support.v7.widget.PagerSnapHelper {*;}
-keep class android.support.v4.view.ViewCompat {*;}
-keep class android.support.v4.util.LongSparseArray {*;}
-keep class android.support.v4.util.ArraySet {*;}
-keep class android.support.v4.view.accessibility.AccessibilityNodeInfoCompat {*;}

###以上为百度开发者文档要求添加
#######################################################################################################


#######################################################################################################
###以下为快手开发者文档要求添加
-keep class org.chromium.** {*;}
-keep class org.chromium.** { *; }
-keep class aegon.chrome.** { *; }
-keep class com.kwai.**{ *; }
-dontwarn com.kwai.**
-dontwarn com.kwad.**
-dontwarn com.ksad.**
-dontwarn aegon.chrome.**
###以上为快手开发者文档要求添加
#######################################################################################################

#######################################################################################################
###以下为京东开发者文档要求添加
-keep class com.jd.ad.sdk.** { *; }
###以上为快手开发者文档要求添加
#######################################################################################################

#######################################################################################################
###以下为阿里妈妈开发者文档要求添加
-keep class com.alibaba.openid.OpenDeviceId {
public static java.lang.String getOAID(android.content.Context);
}
-keep class com.noah.external.utdid.ut.device.UTDevice {
public static java.lang.String getUtdid(android.content.Context);
}

-dontwarn com.noah.adn.alimama.sdk.**
-dontwarn com.noah.adn.alimama.**
-dontwarn com.noah.external.utdid.ut.mini.**
###以上为阿里妈妈开发者文档要求添加
#######################################################################################################

#######################################################################################################

-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
-keep class com.noah.adn.extend.utils.GsonTypeAdapter

## 游客赢
-dontwarn com.tencent.klevin.**
-keep class com.tencent.klevin.**{*;}
-dontwarn com.tencent.klevin.tgpa.**
-keep class com.tencent.klevin.tgpa.**{*;}

-keep class com.noah.sdk.dg.util.HCDebugUtil {
    public <methods>;
}
-keep class com.noah.sdk.business.monitor.MonitorInfoProviderImpl {
    public <methods>;
}
-keep class com.noah.sdk.dg.floating.NoahViewPagerAdapter {
    public <methods>;
}
-dontwarn com.noah.sdk.dg.**

-keep class com.noah.sdk.dg.external.HCDebugUtil {
    public <methods>;
}

##商业化落地页Web容器隔离
-keep class com.noah.sdk.business.webview.**{*;}
-keep interface com.noah.adn.base.web.js.jssdk.IJsApiInterface{*;}

## 针对类似UC这种混淆androidx的情况
# tanx ad
-keep class androidx.appcompat.app.ActionBar{*;}
-keep class androidx.core.view.MenuItemCompat{*;}
-keep class kotlin.Metadata{*;}
-keep class kotlin.enums.EnumEntries{*;}
-keep class kotlin.enums.EnumEntriesKt{*;}
-keep class kotlin.jvm.internal.Intrinsics{*;}
-keep class kotlin.collections.CollectionsKt{*;}
-keep class kotlin.collections.MapsKt{*;}
-keep class kotlin.jvm.JvmStatic{*;}
-keep class kotlin.jvm.internal.Reflection{*;}
-keep class kotlin.Pair{*;}
-keep class kotlin.TuplesKt{*;}
-keep class kotlin.ranges.RangesKt{*;}
-keep class kotlin.text.StringsKt{*;}
-keep class kotlin.Unit{*;}
-keep class kotlin.jvm.functions.Function0{*;}
-keep class kotlin.DeprecationLevel{*;}
-keep class kotlin.jvm.internal.DefaultConstructorMarker{*;}
-keep class kotlin.reflect.KFunction{*;}
-keep class kotlin.reflect.KParameter{*;}
-keep class kotlin.reflect.KClass{*;}
-keep class kotlin.ExceptionsKt{*;}
-keep class kotlin.collections.ArrayDeque{*;}
-keep class kotlin.jvm.internal.Ref{*;}
-keep class kotlin.io.CloseableKt{*;}
-keep class kotlin.io.TextStreamsKt{*;}
-keep class kotlin.text.Charsets{*;}
-keep class kotlin.io.FilesKt{*;}

# jd ad
-keep class androidx.collection.ArrayMap{*;}
-keep class androidx.core.util.Pools{*;}
-keep class androidx.collection.SimpleArrayMap{*;}
-keep class androidx.collection.SparseArrayCompat{*;}
-keep class androidx.core.util.Pair{*;}
-keep class androidx.core.util.Pools$Pool{*;}
-keep class androidx.core.util.Pools$SynchronizedPool{*;}
-keep class androidx.core.content.ContextCompat{*;}
-keep class androidx.collection.LruCache{*;}
-keep class androidx.core.view.animation.PathInterpolatorCompat{*;}
-keep class androidx.core.content.res.ResourcesCompat{*;}
-keep class androidx.appcompat.content.res.AppCompatResources{*;}
-keep class androidx.vectordrawable.graphics.drawable.Animatable2Compat{*;}
-keep class androidx.vectordrawable.graphics.drawable.Animatable2Compat$AnimationCallback
-keep class androidx.appcompat.widget.AppCompatImageView{*;}
-keep class androidx.collection.ArraySet{*;}
-keep class androidx.collection.LongSparseArray{*;}
-keep class androidx.core.view.ViewCompat{*;}
-keep class androidx.fragment.app.Fragment{*;}
-keep class androidx.fragment.app.FragmentActivity{*;}
-keep class androidx.fragment.app.FragmentManager{*;}
-keep class androidx.fragment.app.FragmentTransaction{*;}

# baidu ad
-keep class androidx.recyclerview.widget.LinearSmoothScroller{*;}
-keep class androidx.recyclerview.widget.OrientationHelper{*;}
-keep class androidx.recyclerview.widget.SnapHelper{*;}
# ks ad
-keep class androidx.viewpager.widget.PagerAdapter{*;}
-keep class androidx.lifecycle.GenericLifecycleObserver{*;}
-keep class androidx.lifecycle.Lifecycle{*;}
-keep class androidx.lifecycle.LifecycleOwner{*;}
-keep class androidx.lifecycle.LifecycleObserver{*;}
-keep class androidx.appcompat.view.ContextThemeWrapper{*;}
-keep class androidx.localbroadcastmanager.content.LocalBroadcastManager{*;}
-keep class androidx.fragment.app.DialogFragment{*;}
-keep class androidx.core.view.MotionEventCompat{*;}
-keep class androidx.core.view.NestedScrollingChild{*;}
-keep class androidx.core.view.NestedScrollingChildHelper{*;}
-keep class androidx.core.view.VelocityTrackerCompat{*;}
-keep class androidx.core.graphics.drawable.RoundedBitmapDrawable{*;}
-keep class androidx.core.graphics.drawable.RoundedBitmapDrawableFactory{*;}

## ifly
-dontwarn com.shu.priory.**
-keep class com.shu.priory.** {*;}

## iqy
-dontwarn com.mcto.sspsdk.**
-keep class com.mcto.sspsdk.** { *; }
-keep class com.noah.adn.iqy.IqyHelper$* {
    public <methods>;
}
-keep class com.noah.adn.iqy.IqyHelper {
    public <methods>;
}

#如果接入微信小游戏调起，需按微信要求添加以下keep
-keep class com.tencent.mm.opensdk.** {
    *;
}
-keep class com.tencent.wxop.** {
    *;
}
-keep class com.tencent.mm.sdk.** {
    *;
}
#针对uc书旗内渠上的动态sdk特殊添加，不需要可以直接删除
-keep class com.noah.external.player.**{*;}
-keep class com.noah.external.download.download.downloader.CreateTaskInfo {
    public <methods>;
}
-keep class com.noah.external.download.download.downloader.impl.DownloadWorker {
    public <methods>;
}
-keep class com.noah.external.download.download.downloader.impl.UcDownloadTask {
    public <methods>;
}
-keep interface com.noah.external.download.download.downloader.impl.UcDownloadTask$IDownloadTaskCallback{*;}
-keep class com.noah.external.download.download.downloader.UcDownloader {
    public <methods>;
}
-keep enum com.noah.external.download.download.downloader.impl.DownloadTaskState {*;}
-keep class com.noah.external.nav.** {*;}
-keep class com.noah.external.fastjson.**{*;}
-keep class com.noah.sp.SharedPreferencesUtils {
    public <methods>;
}

## mimo
-keep class com.miui.zeus.** { *; }
-keep class com.noah.adn.mimo.MimoHelper$* {
    public <methods>;
}
-keep class com.noah.adn.mimo.MimoHelper {
    public <methods>;
}
-dontwarn com.miui.zeus.mimo.sdk.**

## oppo
-keep class com.opos.** { *;}
-keep class com.heytap.msp.mobad.** { *;}
-keep class com.heytap.openid.** {*;}

-dontwarn com.opos.**
-dontwarn com.heytap.msp.mobad.**
-dontwarn com.heytap.openid.**

-keeppackagenames com.heytap.nearx.tapplugin
-keep class com.noah.adn.oppo.OppoAdHelper$* {
    public <methods>;
}
-keep class com.noah.adn.oppo.OppoAdHelper {
    public <methods>;
}

## qumeng
-keep class com.qumeng.** { *;}

-dontwarn com.qumeng.advlib.**
-dontwarn com.noah.sdk.util.QumengClassInvoke

-keep class com.noah.adn.qumeng.QumengHelper$* {
    public <methods>;
}
-keep class com.noah.adn.qumeng.QumengHelper {
    public <methods>;
}
## qumeng end

## 多盟 start
# 多盟SDK混淆配置
-dontwarn com.domob.sdk.**
-keep class com.domob.sdk.**{*;}
-keep interface com.domob.sdk.**{*;}

## GlideSD混淆配置
-dontwarn com.bumptech.glide.**
-keep class com.bumptech.glide.**{*;}
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep public class * extends com.bumpt.glide.module.AppGlideModule
-keep public enum com.bumptech.glide.load.resource.bitmap.ImageHeaderParser$** {
    **[] $VALUES;
    public *;
}

-keep class com.noah.adn.domob.DomobHelper$* {
    public <methods>;
}
-keep class com.noah.adn.domob.DomobHelper {
    public <methods>;
}
-dontwarn com.noah.adn.domob.protobufutil.**
## 多盟 end

## 美数 start
-dontwarn sun.misc.**
-keep class com.google.gson.examples.android.model.** { <fields>; }
-keep class com.google.gson.examples.android.model.** { <fields>; }
-keepclassmembers,allowobfuscation class * {
    @com.google.gson.annotations.SerializedName <fields>;
}
-dontwarn com.meishu.sdk.**
-keep class com.meishu.sdk.** { *; }
-keep class com.noah.adn.meishu.MeishuAdHelper$* {
    public <methods>;
}
-keep class com.noah.adn.meishu.MeishuAdHelper {
    public <methods>;
}
## 美数 end
## 泛为 start
-keep class com.noah.adn.ptg.PtgAdvertHelper$* {
    public <methods>;
}
-keep class com.noah.adn.ptg.PtgAdvertHelper {
    public <methods>;
}
-dontwarn com.ptg.**
-dontwarn com.fo.**
-keep class com.ptg.** { *;}
-keep class com.fo.** { *;}
## 泛为 end

## 应用前后台监控 start
-keep class com.noah.monitor.plm.** {
    public <methods>;
}
## 应用前后台监控 end



# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in C:\AndroidSDK/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}
-keep class com.noah.external.download.download.downloader.impl.segment.Segment { *; }
-keep class com.noah.external.download.download.downloader.impl.segment.FileHeader { *; }



















# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in C:\AndroidSDK/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}
-keep class com.noah.external.download.download.downloader.impl.segment.Segment { *; }
-keep class com.noah.external.download.download.downloader.impl.segment.FileHeader { *; }
















# region 自动填充 aar androidx 规则
-keep class androidx.core.app.NotificationCompat** { *; }
-keep class androidx.core.app.ActivityCompat** { *; }
-keep class androidx.viewpager.widget.PagerAdapter** { *; }
-keep class androidx.core.view.GravityCompat** { *; }
-keep class androidx.lifecycle.LifecycleObserver** { *; }
-keep class androidx.viewpager.widget.ViewPager** { *; }
-keep class androidx.recyclerview.widget.DefaultItemAnimator** { *; }
-keep class androidx.lifecycle.Lifecycle** { *; }
-keep class androidx.constraintlayout.widget.ConstraintLayout** { *; }
-keep class androidx.lifecycle.LifecycleOwner** { *; }
-keep class androidx.core.content.FileProvider** { *; }
-keep class androidx.lifecycle.ProcessLifecycleOwner** { *; }
-keep class androidx.core.app.NotificationManagerCompat** { *; }
-keep class androidx.core.util.Pair** { *; }
-keep class androidx.recyclerview.widget.LinearLayoutManager** { *; }
-keep class androidx.recyclerview.widget.RecyclerView** { *; }
-keep class androidx.core.content.ContextCompat** { *; }
-keep class androidx.lifecycle.LifecycleEventObserver** { *; }
# endregion

# ================= from mg_adapter_huawei_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.hw.** { *; }

-keep class com.huawei.openalliance.ad.** { *; }
-keep class com.huawei.hms.ads.** { *; }

# ================= from hr-sdk_1.5.3.20_release.aar =================


# GSON
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.examples.android.model.** { <fields>; }
-keep class com.google.gson.examples.android.model.** { <fields>; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
-keepclassmembers,allowobfuscation class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# ad
-keep class cn.haorui.sdk.** { *; }

-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# ================= from mg_adapter_hy_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.hy.** { *; }

# 美数

# GSON
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.examples.android.model.** { <fields>; }
-keep class com.google.gson.examples.android.model.** { <fields>; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
-keepclassmembers,allowobfuscation class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# ad
-keep class cn.haorui.sdk.** { *; }

-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# ================= from jad_yun_sdk_jingdong_2.6.26_20250327.aar =================



# 在APP打包阶段keep的代码
-keep class com.jd.android.sdk.coreinfo.CoreInfo {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$App {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$Device {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$System {*;}
-keep class com.jd.android.sdk.coreinfo.ScreenSize {*;}
-keep class com.jd.android.sdk.coreinfo.util.Logger {*;}

# 在APP打包阶段keep的代码
-keep class com.jd.android.sdk.coreinfo.CoreInfo {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$App {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$Device {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$System {*;}
-keep class com.jd.android.sdk.coreinfo.ScreenSize {*;}
-keep class com.jd.android.sdk.coreinfo.util.Logger {*;}



# 在APP打包阶段keep的代码
-keep class com.jd.android.sdk.coreinfo.CoreInfo {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$App {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$Device {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$System {*;}
-keep class com.jd.android.sdk.coreinfo.ScreenSize {*;}
-keep class com.jd.android.sdk.coreinfo.util.Logger {*;}

# 在APP打包阶段keep的代码
-keep class com.jd.android.sdk.coreinfo.CoreInfo {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$App {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$Device {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$System {*;}
-keep class com.jd.android.sdk.coreinfo.ScreenSize {*;}
-keep class com.jd.android.sdk.coreinfo.util.Logger {*;}





# 在APP打包阶段keep的代码
-keep class com.jd.android.sdk.coreinfo.CoreInfo {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$App {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$Device {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$System {*;}
-keep class com.jd.android.sdk.coreinfo.ScreenSize {*;}
-keep class com.jd.android.sdk.coreinfo.util.Logger {*;}

# 在APP打包阶段keep的代码
-keep class com.jd.android.sdk.coreinfo.CoreInfo {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$App {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$Device {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$System {*;}
-keep class com.jd.android.sdk.coreinfo.ScreenSize {*;}
-keep class com.jd.android.sdk.coreinfo.util.Logger {*;}



# 在APP打包阶段keep的代码
-keep class com.jd.android.sdk.coreinfo.CoreInfo {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$App {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$Device {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$System {*;}
-keep class com.jd.android.sdk.coreinfo.ScreenSize {*;}
-keep class com.jd.android.sdk.coreinfo.util.Logger {*;}

# 在APP打包阶段keep的代码
-keep class com.jd.android.sdk.coreinfo.CoreInfo {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$App {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$Device {*;}
-keep class com.jd.android.sdk.coreinfo.CoreInfo$System {*;}
-keep class com.jd.android.sdk.coreinfo.ScreenSize {*;}
-keep class com.jd.android.sdk.coreinfo.util.Logger {*;}

# ================= from mg_adapter_jzt_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.jd.** { *; }

-keep class com.jd.ad.sdk.** { *; }

# ================= from mg_adapter_kd_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.kd.** { *; }
-dontskipnonpubliclibraryclasses
# SDK API
-keep class com.dydroid.ads.**  {*;}
-keep class com.litesuits.go.**  {*;}
#R
-keepclassmembers class **.R$* {
  public static <fields>;
}
-keepattributes *Annotation*,InnerClasses
-keepnames class * implements android.os.Parcelable {
  public static final ** CREATOR;
}

# ================= from kssdk-ad-5.1.20.1-publishRelease-a40be1a093.aar =================
-keep class com.kwai.**{ *; }
-keep class com.ksad.**{ *; }
-keep class com.kwad.** { *;}
-keep class com.kuaishou.aegon.**{ *; }

-dontwarn com.kwai.**
-dontwarn com.kwad.**
-dontwarn com.ksad.**
-dontwarn aegon.chrome.**
-dontwarn com.kuaishou.aegon.**
-dontwarn com.tachikoma.core.**

#ijkplayer
-keep class org.chromium.** {*;}
-keep class org.chromium.** { *; }
-keep class aegon.chrome.** { *; }
-keeppackagenames com.badlogic.gdx.math
-keeppackagenames com.google.vrtoolkit.cardboard.sensors

-dontwarn okio.**
-dontwarn okhttp3.**
# 混淆一级即可
-keep class okhttp3.* {*;}
-keep class com.google.gson.* {*;}

#保留注解，如果不添加改行会导致我们的@Keep注解失效
-keepattributes *Annotation*
-keep class android.support.annotation.Keep
-keep @android.support.annotation.Keep class * {*;}

# 安全sdk
-dontwarn com.kuaishou.android.security.**
-keep class com.kuaishou.android.security.**{*;}
-keep class com.yxcorp.kuaishou.addfp.** { *;}

#直播相关混淆
-dontwarn io.netty.**
-dontwarn com.kuaishou.livestream.message.**
-dontwarn com.kuaishou.protobuf.**
-keep class com.google.protobuf.nano.** {*;}
-keep class com.kuaishou.livestream.message.nano.** {*;}
-keep class com.kuaishou.protobuf.livestream.nano.** {*;}
-keep class com.kuaishou.merchant.message.nano.** {*;}
-keep class com.kuaishou.protobuf.merchant.message.nano.** {*;}

#直播广告
-keep class okio.** {*;}
-keep class io.** {*;}
-keep class com.yxcorp.** {*;}
-keep class com.kuaishou.** {*;}
-keep class org.reactivestreams.** {*;}

-keep class com.kuaishou.livestream.** {*;}
-keep class com.kuaishou.security.kste.** {*;}
-keep class com.seclib.kste.** {*;}

# 安全sdk
-dontwarn com.kuaishou.android.security.**
-keep class com.kuaishou.dfp.**{*;}
-keep class com.kuaishou.dfp.KWEGIDDFP {*;}
-keep class com.kuaishou.dfp.ResponseDfpCallback {*;}
-keep class com.kuaishou.dfp.env.jni.Watermelon {*;}
-dontwarn com.squareup.okhttp3.**
-keep class com.squareup.okhttp3.** { *;}
-dontwarn okio.**
-keep class com.google.protobuf.** {*;}
-keep class com.kuaishou.dfp.env.Proxy.** {*;}
#new added for android 10
-keep class com.bun.miitmdid.core.** {*;}

#TK框架
-keep class com.tachikoma.core.manager.IProviderCollector {*;}
-keep class * implements com.tachikoma.core.manager.IProviderCollector { *;}

-keep class com.tkruntime.v8.**{*;}

-keep class com.kwad.proguard.annotations.DoNotStrip
-keep @com.kwad.proguard.annotations.DoNotStrip class * { *; }

-keepclassmembers,includedescriptorclasses class * { native <methods>; }

#风控sdk
-keep class com.kuaishou.weapon.**{ *; }

# oaid相关
-dontwarn com.kwad.sdk.oaid.OADIDSDKHelper**
-keep class * implements com.bun.miitmdid.interfaces.IIdentifierListener { *; }
-keep class com.bun.miitmdid.core.MdidSdkHelper{*;}
-keep public class com.kwad.sdk.crash.online.monitor.block.BlockEvent { *; }

# support v7 v4 等，会在DEX模式中使用
-keep class android.support.**{ *; }

# android arch
-keep class android.arch.** { *; }

# 调试页面相关，不会对外输出
-keep class com.kwad.debug.** { *; }
#WaynePlayer混淆开始
-keep interface com.kwai.video.player.** {*;}
-keep class aegon.chromium.** { *; }
-keep class com.kwai.video.cache.** { *; }
-keep class com.kwai.video.hodor.** {*;}
-keep class com.kwai.video.player.** {*;}
-keep class com.kwai.video.aemonplayer.** {*;}
-keep class com.kwai.player.debuginfo.** { *; }
-keep class aegon.chrome.** { *; }
-keep class kotlin.jvm.functions.** { *; }
#WaynePlayer混淆结束

#支付sdk混淆
-keep class com.kwad.auth.login.KwadRouteHandlerActivity { *; }
-keep class **.kwad.KwadHandlerActivity { *; }



-keep class com.kwad.sdk.glide.framesequence.FrameSequence { *; }
-keep class com.kwad.sdk.glide.framesequence.FrameSequenceDrawable { *; }




-keep class com.kwad.components.offline.api.** { *;}

-keep class * implements com.kwad.components.offline.api.IOfflineCompo { *; }

-keep class com.kwad.components.offline.api.core.annotation.DoNotStrip
-keep @com.kwad.components.offline.api.core.annotation.DoNotStrip class * { *; }





-keep class com.kwad.sdk.glide.framesequence.FrameSequence { *; }
-keep class com.kwad.sdk.glide.framesequence.FrameSequenceDrawable { *; }




-keep class com.kwad.components.offline.api.** { *;}

-keep class * implements com.kwad.components.offline.api.IOfflineCompo { *; }

-keep class com.kwad.components.offline.api.core.annotation.DoNotStrip
-keep @com.kwad.components.offline.api.core.annotation.DoNotStrip class * { *; }

# ================= from mg_adapter_ks_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

#-keep class com.kwad.sdk.** { *;}
#-keep class com.ksad.download.** { *;}
#-keep class com.kwai.filedownloader.** { *;}
-keep class com.yd.saas.ks.** { *; }

-keep class org.chromium.** {*;}
-keep class org.chromium.** { *; }
-keep class aegon.chrome.** { *; }
-keep class com.kwai.**{ *; }
-keep class com.kwad.**{ *; }

-keepclasseswithmembernames class * {
 native <methods>;
}

-dontwarn com.kwai.**
-dontwarn com.kwad.**
-dontwarn com.ksad.**
-dontwarn aegon.chrome.**

-keepattributes Signature
-keepclassmembers class * implements java.lang.reflect.InvocationHandler {
    *;
}

# ================= from mg_adapter_linkad_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.linkad.** { *; }
#聚合
-keep class cj.mobile.**{*;}
-keep interface cj.mobile.**{*;}
#聚合

#oaid
-keep class com.asus.msa.**{*;}
-keep class com.bun.**{*;}
-keep class com.huawei.hms.ads.identifier.**{*;}
-keep class com.netease.nis.sdkwrapper.**{*;}
-keep class com.samsung.android.deviceidservice.**{*;}
-keep class com.zui.**{*;}
-keep class XI.**{*;}
#oaid

#sigmob
-keep class com.sigmob.**{*;}
-dontwarn com.sigmob.**
#sigmob

#taku
-keep public class com.anythink.**
-keepclassmembers class com.anythink.** {
*;
}

-keep public class com.anythink.network.**
-keepclassmembers class com.anythink.network.** {
public *;
}

-dontwarn com.anythink.hb.**
-keep class com.anythink.hb.**{ *;}

-dontwarn com.anythink.china.api.**
-keep class com.anythink.china.api.**{ *;}

-keep class com.anythink.myoffer.ui.**{ *;}
-keepclassmembers public class com.anythink.myoffer.ui.** {
public *;
}
#taku

#优推
-keep class com.alliance.ssp.ad.** {*;}
#优推

#奇运
-keep class cn.jy.ad.sdk.**{*;}
#奇运

#多盟
-dontwarn com.domob.sdk.**
-keep class com.domob.sdk.**{*;}
-keep interface com.domob.sdk.**{*;}
#多盟

# ================= from mg_adapter_lm_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line_vertical number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line_vertical number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.lm.** { *; }
-keep class com.wqrz.sdk.** { *; }

# ================= from fusionsdk_2.9.3.333.aar =================
-keep class com.leyou.fusionsdk.** {*;}
-keep class com.baidu.** { *; }
-keep class com.jd.ad.sdk.** { *; }
-keep class com.qq.e.** {
    public protected *;
}

-keep class com.bytedance.sdk.openadsdk.** { *; }
-keep public interface com.bytedance.sdk.openadsdk.downloadnew.** {*;}
-keep class com.ss.sys.ces.* {*;}

-keep class XI.CA.XI.**{*;}
-keep class XI.K0.XI.**{*;}
-keep class XI.XI.K0.**{*;}
-keep class XI.vs.K0.**{*;}
-keep class XI.xo.XI.XI.**{*;}
-keep class com.asus.msa.SupplementaryDID.**{*;}
-keep class com.asus.msa.sdid.**{*;}
-keep class com.bun.lib.**{*;}
-keep class com.bun.miitmdid.**{*;}
-keep class com.huawei.hms.ads.identifier.**{*;}
-keep class com.samsung.android.deviceidservice.**{*;}
-keep class org.json.**{*;}
-keep public class com.netease.nis.sdkwrapper.Utils {
    public <methods>;
}

-keep class org.chromium.** {*;}
-keep class org.chromium.** { *; }
-keep class aegon.chrome.** { *; }
-keep class com.kwai.**{ *; }
-keep class com.kwad.**{ *; }
-keepclasseswithmembernames class * {
    native <methods>;
}

-keep class com.sigmob.**{*;}
-keep class sun.misc.Unsafe { *; }
-dontwarn com.sigmob.**
-keep class com.sigmob.**.**{*;}


-dontwarn com.kwai.**
-dontwarn com.kwad.**
-dontwarn com.ksad.**
-dontwarn aegon.chrome.**

-keep class com.kwad.sdk.** { *;}
-keep class com.ksad.download.** { *;}
-keep class com.kwai.filedownloader.** { *;}
-keep class com.mcto.sspsdk.** { *; }

-keep class com.tencent.**{*;}

-keepclassmembers class com.leyou.fusionsdk.model.FusionConfig {
#     *** set*(...);
#     *** get*(...);
*;
}

-keep class com.leyou.fusionsdk.controller.CustomController{*;}

-keep class com.leyou.fusionsdk.controller.FusionLocation{*;}


-keep class com.leyou.fusionsdk.model.FusionConfig$Builder {
     *** appId*(...);
     *** userId*(...);
     *** init*(...);
     *** build(...);
     *** customController(...);
     *** directDownloadNetworkType(...);
     *** channelId(...);

 }

-keepclassmembers class * {
    *** getContext(...);
    *** getActivity(...);
    *** getResources(...);
    *** startActivity(...);
    *** startActivityForResult(...);
    *** registerReceiver(...);
    *** unregisterReceiver(...);
    *** query(...);
    *** getType(...);
    *** insert(...);
    *** delete(...);
    *** update(...);
    *** call(...);
    *** setResult(...);
    *** startService(...);
    *** stopService(...);
    *** bindService(...);
    *** unbindService(...);
    *** requestPermissions(...);
    *** getIdentifier(...);
   }

-keep class com.bytedance.pangle.** {*;}
-keep class com.bytedance.sdk.openadsdk.** { *; }
-keep class com.bytedance.frameworks.** { *; }

-keep class ms.bd.c.Pgl.**{*;}
-keep class com.bytedance.mobsec.metasec.ml.**{*;}

-keep class com.ss.android.**{*;}

-keep class com.bytedance.embedapplog.** {*;}
-keep class com.bytedance.embed_dr.** {*;}

-keep class com.bykv.vk.** {*;}



-keep class bykvm*.**
-keep class com.bytedance.msdk.adapter.**{ public *; }
-keep class com.bytedance.msdk.api.** {
 public *;
}
-keep class com.bytedance.msdk.base.TTBaseAd{*;}
-keep class com.bytedance.msdk.adapter.TTAbsAdLoaderAdapter{
    public *;
    protected <fields>;
}

-keep class com.jd.ad.sdk.** { *; }
-keep class com.leyou.fusionsdk.api.AdSdk{*;}
-keep class com.leyou.fusionsdk.api.*{*;}
-keep class com.leyou.fusionsdk.proto.*{*;}
-keep class com.leyou.fusionsdk.activity.AdDetailActivity{*;}

# ================= from mg_adapter_ly_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.ly.** { *; }

# ================= from mg_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line_vertical number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line_vertical number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.** { *; }
-keep class com.android.general.** { *; }
-keep class com.ms.saas.** { *; }
-keep class com.sm.saas.** { *; }
-keep class com.hm.saas.** { *; }
-keep class com.jinbig.hmad.** { *; }
-keep class com.jinbeig.wkad.saas.** { *; }
-ignorewarnings
-dontwarn com.yd.saas.**
-keep class com.nnadsdk.wpn.sdk.** { *; }
-keeppackagenames com.mg.ad.**
-keeppackagenames com.emsdk.**
-keeppackagenames com.mg.ad
-keeppackagenames com.emsdk

-keep class com.tide.host.** { *; }
-keep class com.tide.protocol.** { *; }
-keep class com.ima.fs.sdk.** { *; }
-keep class com.google.android.inner_exoplayer2.** { *; }
-keep class com.zm.adxsdk.** { *; }
-keep class com.zm.wfsdk.phonemark.**{ *; }
-keep class com.zm.fda.**{ *; }
-keep class zm.com.**{ *; }
-keep class com.hardcoremobi.**{ *; }
-keep class com.hardcore.**{ *; }

# ================= from mbridge_dycreator.aar =================
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.mbridge.** {*; }
-keep interface com.mbridge.** {*; }
-dontwarn com.mbridge.**
-keepclassmembers class **.R$* { public static final int mbridge*; }


-keep public class com.mbridge.* extends androidx.** { *; }
-keep public class androidx.viewpager.widget.PagerAdapter{
*;
}
-keep public class androidx.viewpager.widget.ViewPager.OnPageChangeListener{
*;
}
-keep interface androidx.annotation.IntDef{
*;
}
-keep interface androidx.annotation.StringDef{
*;
}
-keep interface androidx.annotation.Nullable{
*;
}
-keep interface androidx.annotation.CheckResult{
*;
}
-keep interface androidx.annotation.NonNull{
*;
}
-keep public class androidx.fragment.app.Fragment{
*;
}
-keep public class androidx.core.content.FileProvider{
                                                     *;
                                                     }
-keep public class androidx.core.app.NotificationCompat{
                                                       *;
                                                       }
-keep public class androidx.appcompat.widget.AppCompatImageView {
                                                                *;
                                                                }
-keep public class androidx.recyclerview.*{
                                          *;
                                          }
-keep class com.mbridge.msdk.foundation.tools.FastKV{
    *;
}

-keep class com.mbridge.msdk.foundation.tools.FastKV$Builder{
    *;
}

#
-keep public class android.support.v7.widget.RecyclerView{
      *;
      }

-keep public class android.support.v7.widget.DividerItemDecoration{
     *;
   }
-keep public class android.support.v7.widget.LinearLayoutManager{
        *;
      }
-keep public class android.support.v7.widget.GridLayoutManager{
        *;
}
-keep public class android.support.v7.widget.OrientationHelper{
        *;
}
-keep public class android.support.v7.widget.StaggeredGridLayoutManager{
        *;
}
-keep public class android.support.v4.app.Fragment{
        *;
}

-keep public class android.support.v4.app.FragmentActivity{
        *;
}

-keep public class android.support.v4.app.FragmentManager{
        *;
}
-keep public class android.support.v4.app.FragmentTransaction{
        *;
}
-keep public class android.support.v4.app.FragmentStatePagerAdapter{
        *;
}
-keep public class android.support.v4.view.ViewPager{
        *;
}
-keep public class android.support.v4.view.PagerAdapter{
        *;
}
-keep interface android.support.v4.view.ViewPager.OnPageChangeListener{
        *;
}
-keep public class android.support.v4.view.MotionEventCompat{
        *;
}
-keep public class android.support.v4.view.ViewConfigurationCompat{
        *;
}
-keep public class android.support.v4.view.ViewCompat{
        *;
}
-keep interface android.support.annotation.Nullable{
        *;
}
-keep interface android.support.annotation.RequiresApi{
        *;
}
-keep interface android.support.annotation.NonNull{
        *;
}
-keep interface android.support.annotation.IntDef{
        *;
}
-keep interface android.support.annotation.StringDef{
        *;
}
-keep interface android.support.annotation.RequiresPermission{
        *;
}
-keep interface android.support.annotation.CheckResult{
        *;
}
-keep interface android.support.annotation.StringRes{
        *;
}
-keep interface android.support.annotation.CallSuper{
        *;
}
-keep public class android.support.v4.app.NotificationManagerCompat{
        *;
}
-keep public class android.support.v4.app.NotificationCompat{
        *;
}
-keep public class android.support.v4.content.FileProvider{
        *;
}
-keep public class android.support.v7.widget.AppCompatButton{
        *;
}
-keep public class android.support.v7.widget.AppCompatImageView{
        *;
}
-keep public class android.support.v7.widget.AppCompatTextView{
        *;
}

-keep class com.mbridge.msdk.scheme.**{
    *;
}

-keep class com.mbridge.msdk.foundation.same.DomainNameUtils{
    *;
}

# ================= from mbridge_same.aar =================
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.mbridge.** {*; }
-keep interface com.mbridge.** {*; }
-dontwarn com.mbridge.**
-keepclassmembers class **.R$* { public static final int mbridge*; }


-keep public class com.mbridge.* extends androidx.** { *; }
-keep public class androidx.viewpager.widget.PagerAdapter{
*;
}
-keep public class androidx.viewpager.widget.ViewPager.OnPageChangeListener{
*;
}
-keep interface androidx.annotation.IntDef{
*;
}
-keep interface androidx.annotation.StringDef{
*;
}
-keep interface androidx.annotation.Nullable{
*;
}
-keep interface androidx.annotation.CheckResult{
*;
}
-keep interface androidx.annotation.NonNull{
*;
}
-keep public class androidx.fragment.app.Fragment{
*;
}
-keep public class androidx.core.content.FileProvider{
                                                     *;
                                                     }
-keep public class androidx.core.app.NotificationCompat{
                                                       *;
                                                       }
-keep public class androidx.appcompat.widget.AppCompatImageView {
                                                                *;
                                                                }
-keep public class androidx.recyclerview.*{
                                          *;
                                          }
-keep class com.mbridge.msdk.foundation.tools.FastKV{
    *;
}

-keep class com.mbridge.msdk.foundation.tools.FastKV$Builder{
    *;
}

#
-keep public class android.support.v7.widget.RecyclerView{
      *;
      }

-keep public class android.support.v7.widget.DividerItemDecoration{
     *;
   }
-keep public class android.support.v7.widget.LinearLayoutManager{
        *;
      }
-keep public class android.support.v7.widget.GridLayoutManager{
        *;
}
-keep public class android.support.v7.widget.OrientationHelper{
        *;
}
-keep public class android.support.v7.widget.StaggeredGridLayoutManager{
        *;
}
-keep public class android.support.v4.app.Fragment{
        *;
}

-keep public class android.support.v4.app.FragmentActivity{
        *;
}

-keep public class android.support.v4.app.FragmentManager{
        *;
}
-keep public class android.support.v4.app.FragmentTransaction{
        *;
}
-keep public class android.support.v4.app.FragmentStatePagerAdapter{
        *;
}
-keep public class android.support.v4.view.ViewPager{
        *;
}
-keep public class android.support.v4.view.PagerAdapter{
        *;
}
-keep interface android.support.v4.view.ViewPager.OnPageChangeListener{
        *;
}
-keep public class android.support.v4.view.MotionEventCompat{
        *;
}
-keep public class android.support.v4.view.ViewConfigurationCompat{
        *;
}
-keep public class android.support.v4.view.ViewCompat{
        *;
}
-keep interface android.support.annotation.Nullable{
        *;
}
-keep interface android.support.annotation.RequiresApi{
        *;
}
-keep interface android.support.annotation.NonNull{
        *;
}
-keep interface android.support.annotation.IntDef{
        *;
}
-keep interface android.support.annotation.StringDef{
        *;
}
-keep interface android.support.annotation.RequiresPermission{
        *;
}
-keep interface android.support.annotation.CheckResult{
        *;
}
-keep interface android.support.annotation.StringRes{
        *;
}
-keep interface android.support.annotation.CallSuper{
        *;
}
-keep public class android.support.v4.app.NotificationManagerCompat{
        *;
}
-keep public class android.support.v4.app.NotificationCompat{
        *;
}
-keep public class android.support.v4.content.FileProvider{
        *;
}
-keep public class android.support.v7.widget.AppCompatButton{
        *;
}
-keep public class android.support.v7.widget.AppCompatImageView{
        *;
}
-keep public class android.support.v7.widget.AppCompatTextView{
        *;
}

-keep class com.mbridge.msdk.scheme.**{
    *;
}

-keep class com.mbridge.msdk.foundation.same.DomainNameUtils{
    *;
}

# ================= from mg_adapter_mtg_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.mtg.** { *; }

-keepattributes Signature
-keepattributes *Annotation*
-keep class com.mbridge.** {*; }
-keep interface com.mbridge.** {*; }
-keep interface androidx.** { *; }
-keep class androidx.** { *; }
-keep public class * extends androidx.** { *; }

-keep class android.support.v4.** { *; }
-dontwarn com.mbridge.**
-keep class **.R$* { public static final int mbridge*; }


# ================= from mg_adapter_oppo_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

-keep class com.yd.saas.oppo.** { *; }

#广告proguard配置开始

-keep class com.opos.** { *;}
-keep class com.heytap.msp.mobad.** { *;}
-keep class com.heytap.openid.** {*;}

-keep class okio.**{ *; }

-keeppackagenames com.heytap.nearx.tapplugin


#广告proguard配置结束

# ================= from mobad_normal_pub_810004_2025_04_01.aar =================
-keep class com.opos.** { *;}

#-keep class com.opos.** { *;}
-keep class com.cdo.oaps.ad.**{ *; }
-keepattributes Exceptions,InnerClasses
-keep class com.oplus.instant.router.Instant{
public <fields>;
public <methods>;
}
-keep class com.oplus.instant.router.Instant$*{
public <methods>;
}
-keep class com.oplus.instant.router.callback.Callback{
public <methods>;
}
-keep class com.oplus.instant.router.callback.Callback$*{
public <fields>;
public <methods>;
}
-keep class com.oplus.quickgame.sdk.** {*;}
-keep class com.heytap.msp.mobad.api.**{*;}

#网络库需要keep的类
-keep class com.heytap.nearx.okhttp.extension.HeyConfig
-keep,allowobfuscation @interface androidx.annotation.Keep
-keep @androidx.annotation.Keep class *
-keepclassmembers class * {
@androidx.annotation.Keep *;
}
-dontwarn javax.annotation.**
-dontwarn org.codehaus.mojo.animal_sniffer.*
-keep @com.heytap.baselib.database.annotation.DbEntity class * {*;}
-keep class com.heytap.ipswitcher.config.HostEntity {*;}
-keep class com.heytap.nearx.okhttp** {*;}
-keep class com.heytap.nearx.tap** {*;}

#定制版wire-runtime需要
#由于联盟内部做了混淆优化，会导致包名，故keep到nearx包，只在consumer生效
-keep class com.heytap.nearx.**{*;}
-keep public class * extends com.heytap.nearx.**{
*;
}

-keep class com.usertrace.cdo.usertrace.domain.dto.**{*;}
-keep class com.nearme.log.core.CLoganProtocol { *; }

#tbl
-keep class com.oplus.tbl.exoplayer2.** { *;}
-keep class com.oplus.tblplayer.** { *;}


#third sdk need
-keep class com.opos.cmn.ac.AcTools{*;}
# native方法
-keep class com.oplus.log.core.CLoganProtocol { *; }
-keep class com.opos.cmn.nt.crypt.EncryptUtils{*;}
#-keepnames class com.opos.cmn.biz.interaction.**{
#	*;
#}
#-keepnames class com.opos.exoplayer.ui.**
#-keepnames class com.opos.cmn.biz.ststrategy.**{
#    *;
#}
#-keepnames class com.opos.videocache.**
#-keepnames class com.opos.exoplayer.core.**
#-keepnames class com.opos.cmn.third.id.**
#openid need
-dontwarn android.content.pm.**
-keep class android.support.annotation.Keep
-keep @android.support.annotation.Keep class * {*;}
-keep class android.content.pm.** { *; }
-keep class com.tencent.mm.opensdk.** {
    *;
}
-keep class com.tencent.wxop.** {
    *;
}
-keep class com.tencent.mm.sdk.** {
    *;
}
#-keepnames class com.opos.acs.st.**
#-keepnames class com.opos.cmn.biz.ststrategy.**{
#    *;
#}
-keep class * implements com.opos.process.bridge.provider.IBridgeHandler
-keep @interface com.opos.process.bridge.annotation.BridgeMethod
-keepclassmembers,allowobfuscation class *{
    @com.opos.process.bridge.annotation.BridgeMethod *;
}
-keep class * implements com.opos.process.bridge.provider.IBridgeHandler$Factory {
    *;
}
-keepclassmembers class *{
    public static final com.opos.process.bridge.provider.IBridgeHandler$Factory FACTORY;
}
# gradle plugin
-keep interface com.opos.process.bridge.dispatch.IDispatcher {*;}
-keep interface com.opos.process.bridge.dispatch.IActivityDispatcher {*;}
-keep class * implements com.opos.process.bridge.dispatch.IDispatcher {*;}
-keep class * implements com.opos.process.bridge.dispatch.IActivityDispatcher {*;}
-keep public class com.opos.cmn.an.custom.policy.**{
    public <methods>;
    public <fields>;
}
-keep class com.opos.mob.template.dynamic.sdk.consts.Keys {*;}
#-keepnames class com.opos.cmn.third.oaps.**
-keep class com.heytap.msp.opos.sv.interapi.**{*;}
-keeppackagenames com.heytap.mspsdk**
-keep class com.heytap.mspsdk.MspSdk{*;}
-keep class com.opos.process.bridge.provider.**{*;}
-keep class com.opos.process.bridge.client.**{*;}
-keep class com.heytap.mspsdk.exception.**{*;}
-keep class com.heytap.mspsdk.log.**{*;}
-keep class com.heytap.mspsdk.constants.MspSdkCode{*;}
-keep class com.heytap.mspsdk.constants.Constants{*;}
#-keepnames class com.opos.cmn.third.id.**
#openid need
-dontwarn android.content.pm.**
-keep class android.support.annotation.Keep
-keep @android.support.annotation.Keep class * {*;}
-keep class android.content.pm.** { *; }
-keep class com.usertrace.cdo.usertrace.domain.dto.UserTraceConfigDto{*;}
#-keepnames class  com.opos.cmn.third.instant.**
#-keepnames  class com.nearme.instant.router.**
#快应用SDK 1.3.3以前版本需要
-keepattributes Exceptions,InnerClasses
-keep class com.nearme.instant.router.Instant{public <fields>;public <methods>;}
-keep class com.nearme.instant.router.Instant$*{public <methods>;}
-keep class com.nearme.instant.router.callback.Callback{public <methods>;}
-keep class com.nearme.instant.router.callback.Callback$*{public <fields>;public <methods>;}
-keep class com.nearme.instant.router.ui.**{*;}
-keep class com.nearme.instant.patchtool.**{*;}
-keep class com.heytap.instant.upgrade.**{*;}
#快应用SDK 1.3.3即以上版本需要
-keepattributes Exceptions,InnerClasses
-keep class com.oplus.instant.router.Instant{public <fields>;public <methods>;}
-keep class com.oplus.instant.router.Instant$*{public <methods>;}
-keep class com.oplus.instant.router.callback.Callback{public <methods>;}
-keep class com.oplus.instant.router.callback.Callback$*{public <fields>;public <methods>;}
-keep class com.heytap.msp.opos.sv.api.**{*;}
#-keepnames class com.opos.cmn.biz.ext.**{
#	*;
#}
-keeppackagenames com.heytap.mspsdk**
-keep class com.heytap.mspsdk.MspSdk{*;}
-keep class com.opos.process.bridge.provider.**{*;}
-keep class com.opos.process.bridge.client.**{*;}
-keep class com.heytap.mspsdk.exception.**{*;}
-keep class com.heytap.mspsdk.log.**{*;}
-keep class com.heytap.mspsdk.constants.MspSdkCode{*;}
-keep class com.heytap.mspsdk.constants.Constants{*;}
-keep class android.support.annotation.Keep
-keep @android.support.annotation.Keep class * {*;}
-keep class android.content.pm.** { *; }
-keep class com.heytap.msp.** implements android.os.IInterface{*;}
-keep class com.heytap.mspsdk.** implements android.os.IInterface{*;}
-keep class com.heytap.msp.** implements java.io.Serializable{*;}
-keep class com.heytap.mspsdk.** implements java.io.Serializable{*;}
-keep class com.heytap.msp.** implements android.os.Parcelable{
    public static final android.os.Parcelable$Creator *;
}
-keep class com.heytap.mspsdk.** implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}
#-keepnames class com.opos.cmn.biz.monitor.**{
#    *;
#}


#天蝎加固保留
-keep class com.opos.cmn.an.f {*;}
-keep class com.opos.cmn.an.j {*;}
-keep class com.opos.cmn.i {*;}
-keep class com.opos.mobad.c {*;}
-keep class com.opos.mobad.c.d {*;}
-keep class com.opos.mobad.provider.record {*;}
-keep class com.opos.mobad.service.d {*;}
-keep class com.opos.mobad.service.e {*;}
-keep class com.opos.mobad.service.h {*;}
-keep class com.opos.mobad.service.tasks {*;}

# ================= from mg_adapter_qtt_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.qtt.** { *; }

# ================= from qumeng-3.479.13.445.aar =================
-dontwarn com.qumeng.advlib.**
-dontwarn com.miui.externalserver.**
-dontwarn com.jifen.open.**
-dontwarn com.inno.innosdk.*.**
-dontwarn com.google.android.material.**
-dontnote com.google.android.material.**

-keep class com.qm.advlib.trdparty.secure.**{*;}
-keep class com.qm.advlib.trdparty.identifier.** {*;}
-keep class com.inno.*.** {*;}
-keep class com.qumeng.advlib** {*;}
-keep class com.alipay.sdk** {*;}
-keep class com.bun.miitmdid.core.MdidSdkHelper**{*;}
-keep class com.bun.miitmdid.interfaces.IIdentifierListener**{*;}
-keep class com.bun.supplier.IIdentifierListener**{*;}
#-keep class com.qttsdk.glxh.*.** {*;}
#百川
-keep class com.aggmoread.sdk.** {*;}
#京东
-keep class com.jd.ad.sdk.** { *; }

-keepclassmembers class * {
            native <methods>;
}


-keep class com.google.android.material.** {*;}

##必须要添加，androidx & support依赖移除适配
-keep public class * extends com.qumeng.advlib.__remote__.utils.androidx.**
-keep class com.qumeng.advlib.__remote__.utils.androidx.**{*;}

-keep class com.qumeng.advlib.__remote__.ui.incite.feedexpree.bxw.StatsHelper{
    public <methods>;
}
-keepclassmembers class com.qumeng.advlib.__remote__.ui.incite.feedexpree.bxw.StatsHelper$DeviceInfo {
    <fields>;
}

# ================= from mg_adapter_sigmob_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.sigmob.** { *; }

# 优化 不优化输入的类文件
-dontoptimize

# androidx

-keep class com.google.android.material.** {*;}
-keep class androidx.** {*;}
-keep public class * extends androidx.**
-keep interface androidx.** {*;}
-dontwarn com.google.android.material.**
-dontnote com.google.android.material.**
-dontwarn androidx.**

# android.support.v4

-dontwarn android.support.v4.**
-keep class android.support.v4.** { *; }
-keep interface android.support.v4.** { *; }
-keep public class * extends android.support.v4.**

# WindAd

-keep class sun.misc.Unsafe { *; }
-keep class com.sigmob.**.**{*;}
-keep interface com.sigmob.**.**{*;}
-keep class com.czhj.**{*;}
-keep interface com.czhj.**{*;}

# miitmdid

-dontwarn com.bun.**
-keep class com.bun.** {*;}
-keep class a.**{*;}
-keep class XI.CA.XI.**{*;}
-keep class XI.K0.XI.**{*;}
-keep class XI.XI.K0.**{*;}
-keep class XI.vs.K0.**{*;}
-keep class XI.xo.XI.XI.**{*;}
-keep class com.asus.msa.SupplementaryDID.**{*;}
-keep class com.asus.msa.sdid.**{*;}
-keep class com.huawei.hms.ads.identifier.**{*;}
-keep class com.samsung.android.deviceidservice.**{*;}
-keep class com.zui.opendeviceidlibrary.**{*;}
-keep class org.json.**{*;}
-keep public class com.netease.nis.sdkwrapper.Utils {public <methods>;}

# ================= from wind-common-1.9.4.aar =================
#保护注解
-keepattributes *Annotation*
-keepattributes *JavascriptInterface*

-keep class com.czhj.**{ *;}
-keep interface com.czhj.**{ *;}

-keep class com.tan.**{ *;}



#oaid
-dontwarn com.bun.**
-keep class com.bun.** {*;}
-keep class a.**{*;}
-keep class XI.CA.XI.**{*;}
-keep class XI.K0.XI.**{*;}
-keep class XI.XI.K0.**{*;}
-keep class XI.vs.K0.**{*;}
-keep class XI.xo.XI.XI.**{*;}
-keep class com.asus.msa.SupplementaryDID.**{*;}
-keep class com.asus.msa.sdid.**{*;}
-keep class com.huawei.hms.ads.identifier.**{*;}
-keep class com.samsung.android.deviceidservice.**{*;}
-keep class com.zui.opendeviceidlibrary.**{*;}
-keep class org.json.**{*;}
-keep public class com.netease.nis.sdkwrapper.Utils {public <methods>;}

-keep class com.sigmob.**{public *;}
-keep interface com.sigmob.** {public *; }




#oaid
-dontwarn com.bun.**
-keep class com.bun.** {*;}
-keep class a.**{*;}
-keep class XI.CA.XI.**{*;}
-keep class XI.K0.XI.**{*;}
-keep class XI.XI.K0.**{*;}
-keep class XI.vs.K0.**{*;}
-keep class XI.xo.XI.XI.**{*;}
-keep class com.asus.msa.SupplementaryDID.**{*;}
-keep class com.asus.msa.sdid.**{*;}
-keep class com.huawei.hms.ads.identifier.**{*;}
-keep class com.samsung.android.deviceidservice.**{*;}
-keep class com.zui.opendeviceidlibrary.**{*;}
-keep class org.json.**{*;}
-keep public class com.netease.nis.sdkwrapper.Utils {public <methods>;}

-keep class com.sigmob.**{public *;}
-keep interface com.sigmob.** {public *; }

# ================= from wind-sdk-4.25.11.aar =================
# 保护注解
-keepattributes *Annotation*
-keepattributes *JavascriptInterface*

-keep class com.sigmob.sdk.**{ *;}
-keep class com.sigmob.windad.**{ *;}
-keep class com.tan.mark.**{*;}
-keep interface com.sigmob.sdk.**{ *;}
-keep interface com.sigmob.windad.**{ *;}

# ================= from mg_adapter_tm_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.tm.** { *; }
-keep class com.tianmu.**{ *; }
-keep class tianmu.com.** { *; }
-keep interface tianmu.com.** { *; }

# ================= from anythink_adx_sdk_kuying_6.5.56_necessary.aar =================
-dontwarn com.smartdigimkt.**

-keep class com.smartdigimkt.** { *; }
-keepclassmembers class com.smartdigimkt.** {
   *;
}

-keep public class com.smartdigimkt.sdk.api.** { *;}
-keepclassmembers class com.smartdigimkt.sdk.api.** {
  *;
}

-keep class com.smartdigimkt.pd.**{ *;}
-keep class com.smartdigimkt.dlpd.**{ *;}
-keep class com.smartdigimkt.odpd.**{ *;}

-keep class com.smartdigimkt.basead.handler.**{
    public *;
}

-keep class com.smartdigimkt.expressad.playercommon.** { *; }

-keepclassmembers class * implements android.os.Parcelable {
    public static final ** CREATOR;
}

-keepclassmembers public class * extends com.smartdigimkt.expressad.atsignalcommon.windvane.WindVanePlugin{
    public <methods>;
}

-keep public class com.smartdigimkt.expressad.foundation.webview.BrowserView$DownloadListener{
     *;
}

-keep interface com.smartdigimkt.expressad.video.signal.communication.* {
   public <methods>;
}
-keep interface com.smartdigimkt.expressad.video.signal.factory.* {
   public <methods>;
}


-keep public class * extends com.smartdigimkt.expressad.atsignalcommon.windvane.WindVanePlugin {
   public <methods>;
}

-keep class com.smartdigimkt.expressad.atsignalcommon.bridge.* {
   public <methods>;
}

-keep class com.smartdigimkt.expressad.video.signal.communication.* {
   public <methods>;
}

-keep class com.smartdigimkt.expressad.splash.js.* {
   public <methods>;
}

-keep class com.smartdigimkt.expressad.advanced.js.* {
   public <methods>;
}

-keep class com.smartdigimkt.expressad.atsignalcommon.mraid.* {
    public <methods>;
}

-keep class com.smartdigimkt.expressad.atsignalcommon.webEnvCheck.* {
    public <methods>;
}


# keep adx bridge entiry annotation
-keep @interface com.smartdigimkt.sdk.core.bridge.entity.DataField {
    *;
}
-keep class com.smartdigimkt.sdk.core.bridge.entity.* {
    *;
}

-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}


-keepclassmembers public class * extends com.smartdigimkt.sdk.basead.webtemplet.WTBaseJSBridgePlugin{
    public <methods>;
}
-keep public class * extends com.smartdigimkt.sdk.basead.webtemplet.WTBaseJSBridgePlugin {
   public <methods>;
}

-keep class com.smartdigimkt.expressad.bridge.**{ *;}
-keep class com.smartdigimkt.basead.oversea_plugin.bridge.**{ *;}

# ================= from anythink_core_6.5.52.aar =================
# 保持四大组件类名不被混淆
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider

# 保持四大组件的构造函数不被混淆
-keepclassmembers class * extends android.app.Activity {
    public <init>(android.content.Context);
}
-keepclassmembers class * extends android.app.Service {
    public <init>();
}
-keepclassmembers class * extends android.content.BroadcastReceiver {
    public <init>();
}
-keepclassmembers class * extends android.content.ContentProvider {
    public <init>();
}

-keep class com.anythink.** { *; }
-keepclassmembers class com.anythink.** {
   *;
}

-keep public class com.anythink.network.**
-keepclassmembers class com.anythink.network.** {
   public *;
}

-dontwarn com.anythink.**
-dontwarn com.adjust.**
-dontwarn com.appsflyer.**

-keep class com.anythink.pd.**{ *;}
-keep class com.anythink.dlpd.**{ *;}
-keep class com.anythink.odpd.**{ *;}

-keep class com.anythink.basead.ui.**{ *;}
-keepclassmembers public class com.anythink.basead.ui.** {
   public *;
}
-keep class com.anythink.core.basead.ui.**{ *;}
-keepclassmembers public class com.anythink.core.basead.ui.** {
   public *;
}
-keep class com.anythink.basead.handler.**{
    public *;
}

-keep class com.anythink.expressad.** {*; }
-keep interface com.anythink.expressad.** {*; }

-keep class com.anythink.core.common.ui.**{ *;}
-keepclassmembers public class com.anythink.core.common.ui.** {
   public *;
}

-keep public class com.anythink.banner.unitgroup.api.**
-keepclassmembers class com.anythink.network.** {
   public *;
}

-keep public class * extends com.anythink.banner.unitgroup.api.CustomBannerAdapter
-keepclassmembers public class * extends com.anythink.banner.unitgroup.api.CustomBannerAdapter {
    public <methods>;
}

-keep public class * extends com.anythink.nativead.unitgroup.api.CustomNativeAdapter
-keepclassmembers public class * extends com.anythink.nativead.unitgroup.api.CustomNativeAdapter {
    public <methods>;
}

-keep public class * extends com.anythink.interstitial.unitgroup.api.CustomInterstitialAdapter
-keepclassmembers public class * extends com.anythink.interstitial.unitgroup.api.CustomInterstitialAdapter {
    public <methods>;
}

-keep public class * extends com.anythink.rewardvideo.unitgroup.api.CustomRewardVideoAdapter
-keepclassmembers public class * extends com.anythink.rewardvideo.unitgroup.api.CustomRewardVideoAdapter {
    public <methods>;
}

-keep public class * extends com.anythink.splashad.unitgroup.api.CustomSplashAdapter
-keepclassmembers public class * extends com.anythink.splashad.unitgroup.api.CustomSplashAdapter {
    public <methods>;
}

# # keep adx bridge entiry annotation
-keep @interface com.anythink.core.bridge.entity.DataField {
    *;
}
-keepclassmembers class com.anythink.core.bridge.entity.* {
    public <init>();
}


-dontwarn com.anythink.**
-dontwarn com.bun.**
-dontwarn com.adjust.**
-dontwarn com.appsflyer.**

-keep class com.bun.**{ *;}

-keep class com.anythink.pd.**{ *;}

-keep public class com.anythink.china.common.ApkFileProvider { *;}


-keep class com.anythink.dlopt.api.**{ *;}
-keep class com.anythink.dlpd.**{ *;}

-keep public class com.anythink.dlopt.common.ApkFileProvider { *;}



-keep class com.anythink.odopt.api.**{ *;}
-keep class com.anythink.odpd.**{ *;}

# ================= from anythink_network_adx_kuying_sdk_necessary_6.5.56.1.1.aar =================

# 保持四大组件类名不被混淆
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider

# 保持四大组件的构造函数不被混淆
-keepclassmembers class * extends android.app.Activity {
    public <init>(android.content.Context);
}
-keepclassmembers class * extends android.app.Service {
    public <init>();
}
-keepclassmembers class * extends android.content.BroadcastReceiver {
    public <init>();
}
-keepclassmembers class * extends android.content.ContentProvider {
    public <init>();
}

-keep class com.anythink.** { *; }
-keepclassmembers class com.anythink.** {
   *;
}

-keep public class com.anythink.network.**
-keepclassmembers class com.anythink.network.** {
   public *;
}

-dontwarn com.anythink.**
-dontwarn com.adjust.**
-dontwarn com.appsflyer.**

-keep class com.anythink.pd.**{ *;}
-keep class com.anythink.dlpd.**{ *;}
-keep class com.anythink.odpd.**{ *;}

-keep class com.anythink.basead.ui.**{ *;}
-keepclassmembers public class com.anythink.basead.ui.** {
   public *;
}
-keep class com.anythink.core.basead.ui.**{ *;}
-keepclassmembers public class com.anythink.core.basead.ui.** {
   public *;
}
-keep class com.anythink.basead.handler.**{
    public *;
}

-keep class com.anythink.expressad.** {*; }
-keep interface com.anythink.expressad.** {*; }

-keep class com.anythink.core.common.ui.**{ *;}
-keepclassmembers public class com.anythink.core.common.ui.** {
   public *;
}

-keep public class com.anythink.banner.unitgroup.api.**
-keepclassmembers class com.anythink.network.** {
   public *;
}

-keep public class * extends com.anythink.banner.unitgroup.api.CustomBannerAdapter
-keepclassmembers public class * extends com.anythink.banner.unitgroup.api.CustomBannerAdapter {
    public <methods>;
}

-keep public class * extends com.anythink.nativead.unitgroup.api.CustomNativeAdapter
-keepclassmembers public class * extends com.anythink.nativead.unitgroup.api.CustomNativeAdapter {
    public <methods>;
}

-keep public class * extends com.anythink.interstitial.unitgroup.api.CustomInterstitialAdapter
-keepclassmembers public class * extends com.anythink.interstitial.unitgroup.api.CustomInterstitialAdapter {
    public <methods>;
}

-keep public class * extends com.anythink.rewardvideo.unitgroup.api.CustomRewardVideoAdapter
-keepclassmembers public class * extends com.anythink.rewardvideo.unitgroup.api.CustomRewardVideoAdapter {
    public <methods>;
}

-keep public class * extends com.anythink.splashad.unitgroup.api.CustomSplashAdapter
-keepclassmembers public class * extends com.anythink.splashad.unitgroup.api.CustomSplashAdapter {
    public <methods>;
}

# # keep adx bridge entiry annotation
-keep @interface com.anythink.core.bridge.entity.DataField {
    *;
}
-keepclassmembers class com.anythink.core.bridge.entity.* {
    public <init>();
}


-dontwarn com.anythink.**
-dontwarn com.bun.**
-dontwarn com.adjust.**
-dontwarn com.appsflyer.**

-keep class com.bun.**{ *;}

-keep class com.anythink.pd.**{ *;}

-keep public class com.anythink.china.common.ApkFileProvider { *;}


-keep class com.anythink.dlopt.api.**{ *;}
-keep class com.anythink.dlpd.**{ *;}

-keep public class com.anythink.dlopt.common.ApkFileProvider { *;}



-keep class com.anythink.odopt.api.**{ *;}
-keep class com.anythink.odpd.**{ *;}

# ================= from mg_adapter_topon_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.topon.** { *; }
-keep public class com.anythink.**
-keepclassmembers class com.anythink.** {
   *;
}

-keep public class com.anythink.network.**
-keepclassmembers class com.anythink.network.** {
   public *;
}

-dontwarn com.anythink.hb.**
-keep class com.anythink.hb.**{ *;}

-dontwarn com.anythink.china.api.**
-keep class com.anythink.china.api.**{ *;}

-keep class com.anythink.myoffer.ui.**{ *;}
-keepclassmembers public class com.anythink.myoffer.ui.** {
   public *;
}

# ================= from UBiMAX.SDK_1.5.1.aar =================
-keep class com.ubixnow.** { *; }
-keep class com.ubix.** { *; }
-keep class com.ubimax.** { *; }

-keep class * extends com.ubimax.api.UMTCustomInitManager { public *;}
-keep class * extends com.ubimax.splash.api.UMTCustomSplashAdapter { public *;}
-keep class * extends com.ubimax.interstitial.api.UMTCustomInterstitialAdapter { public *;}
-keep class * extends com.ubimax.feed.api.UMTCustomFeedAdapter { public *;}
-keep class * extends com.ubimax.feed.api.UMTCustomFeedAdBean { public *;}
-keep class * extends com.ubimax.reward.api.UMTCustomRewardAdapter { public *;}
-keep class * extends com.ubimax.banner.api.UMTCustomBannerAdapter { public *;}

# ================= from UBiX_Merak.SDK_2.10.0.aar =================
-keep class com.ubix.** { *;}

# ================= from UBiX_N.O.W.SDK_2.12.2.aar =================
-keep class com.ubixnow.** { *; }
-keep class com.ubix.** { *; }

#fancy混淆开始
-keep class com.ptg.** {*;}
-keep class com.fo.** { *;}
#fancy混淆结束


# 美约混淆开始
-keep class com.my.adpoymer.** { *; }
# 美约混淆结束

# 优酷混淆开始
-keep class com.insightvision.openadsdk.** { *; }
-keep public class * extends java.io.Serializable{*;}
# 优酷混淆结束


# 科大讯飞混淆开始
-dontwarn com.shu.priory.*
-keep class com.shu.priory.** { *;}
# 科大讯飞混淆结束

# ================= from mg_adapter_ubix_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.ubix.** { *; }
# ubix 混淆
-keep public class com.ubix.** { *;}
-keep public class com.ubixnow.** { *;}

# ================= from mg_adapter_vivo_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.vivo.** { *; }

-keepattributes SourceFile,LineNumberTable
-dontwarn com.squareup.okhttp.**
-dontwarn okhttp3.**
-keep class com.vivo.*.** { *; }
-dontwarn com.bytedance.article.common.nativecrash.NativeCrashInit
-keep class com.bytedance.sdk.openadsdk.** {*;}
-keep public interface com.bytedance.sdk.openadsdk.downloadnew.** {*;}
-keep class com.pgl.sys.ces.* {*;}
-keep class com.qq.e.** {
 public protected *;
}
-keep class android.support.v4.**{
 public *;
}
-keep class android.support.v7.widget.** {*;}
-dontwarn com.vivo.secboxsdk.**
-keep class com.vivo.secboxsdk.SecBoxCipherException { *; }
-keep class com.vivo.secboxsdk.jni.SecBoxNative { *; }
-keep class com.vivo.secboxsdk.BuildConfig { *; }
-keep class com.kwad.sdk.** { *;}
-keep class com.ksad.download.** { *;}
-keep class com.kwai.filedownloader.** { *;}

# ================= from open_ad_5.9.8.7_1390fa3df_1288g.aar =================

-keep class com.vivo.mobilead.antifraud.** { *; }

-keep class com.vivo.mobilead.antifraud.** { *; }

# ================= from mg_adapter_xf_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.xf.** { *; }
-dontwarn com.shu.priory.*
-keep class com.shu.priory.** { *;}

# ================= from mg_adapter_xiaomi_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.xiaomi.** { *; }

-keep class com.miui.zeus.** { *; }

# ================= from mimo-ad-sdk.aar =================
-dontwarn android.support.**
-dontwarn androidx.**
-dontwarn java.lang.**
-dontwarn sun.misc.**
-dontwarn com.google.android.material.**
-dontnote com.google.android.material.**
-dontwarn com.market.**
-dontwarn com.xiaomi.market.**

-keepattributes Exceptions,InnerClasses,Signature,Deprecated,SourceFile,LineNumberTable,*Annotation*,EnclosingMethod

-keepclasseswithmembernames class * {
    native <methods>;
}

-keep class * extends android.os.IInterface{
    *;
}

-keep class * implements java.io.Serializable {
    *;
}

# keep support sdk
-keep class android.support.** {*;}
# keep androidx sdk
-keep class androidx.** {*;}
-keep class com.google.android.material.** {*;}

# keep recyclerview sdk
-keep class androidx.recyclerview.widget.** { *; }

# keep gson sdk
-keep class com.google.gson.examples.android.model.** { <fields>; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

# keep glide sdk
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep class * extends com.bumptech.glide.module.AppGlideModule {
  <init>(...);
}
-keep public enum com.bumptech.glide.load.ImageHeaderParser$** {
  **[] $VALUES;
  public *;
}
-keep class com.bumptech.glide.load.data.ParcelFileDescriptorRewinder$InternalRewinder {
  *** rewind();
}
-keep class * implements com.bumptech.glide.request.RequestListener { *; }

# keep analytics sdk
-keep class com.miui.analytics.** { *; }
-keep class com.xiaomi.analytics.* { *; }
-keep class com.xiaomi.onetrack.** { *; }

# keep market sdk
-keep class com.market.** { *; }
-keep class com.xiaomi.market.** { *; }

# keep mimo sdk
-keep class com.miui.zeus.** { *; }


-repackageclasses com.miui.zeus.landingpage.sdk

-keep class com.miui.zeus.landingpage.sdk.* { *; }
-keep class com.miui.zeus.landingpage.sdk.js.* { *;}
### keep 商店sdk START
-keep class com.market.** { *; }
-dontwarn com.market.**
-keep class com.xiaomi.market.** { *; }
### keep 商店sdk END

-keep class com.miui.zeus.safe.sdk.** { *; }



-repackageclasses com.miui.zeus.landingpage.sdk

-keep class com.miui.zeus.landingpage.sdk.* { *; }
-keep class com.miui.zeus.landingpage.sdk.js.* { *;}
### keep 商店sdk START
-keep class com.market.** { *; }
-dontwarn com.market.**
-keep class com.xiaomi.market.** { *; }
### keep 商店sdk END

-keep class com.miui.zeus.safe.sdk.** { *; }

# ================= from mg_adapter_yt_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.yt.** { *; }
-keep class com.alliance.ssp.ad.** { *; }
-keep,allowobfuscation,allowshrinking class com.google.gson.reflect.TypeToken
-keep,allowobfuscation,allowshrinking class * extends com.google.gson.reflect.TypeToken

# ================= from mg_adapter_zy_2.9.0_77613416_release.aar =================
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.yd.saas.zy.** { *; }
# Octopus混淆
-dontwarn com.octopus.ad.**
-keep class com.octopus.ad.** {*;}
