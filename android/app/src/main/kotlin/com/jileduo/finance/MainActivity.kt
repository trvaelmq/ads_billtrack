package com.jileduo.finance

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val adManager = AdManager()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)


        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.billtrack/ad_method")
            .setMethodCallHandler { call, result ->
                @Suppress("UNCHECKED_CAST")
                val args = call.arguments as? Map<String, Any>
                fun posId(fallback: String) = args?.get("posId") as? String ?: fallback
                when (call.method) {
                    // 设备唯一 ID：ANDROID_ID 随设备+签名稳定，卸载重装不变，用于服务端广告限频
                    "getDeviceId"        -> result.success(
                        android.provider.Settings.Secure.getString(
                            contentResolver, android.provider.Settings.Secure.ANDROID_ID
                        )
                    )
                    // 风控网关 signals 字段用：机型/系统版本/是否插卡/运营商，均为公开信息无需危险权限
                    "getDeviceSignals"   -> {
                        val tm = getSystemService(android.content.Context.TELEPHONY_SERVICE)
                                as? android.telephony.TelephonyManager
                        result.success(mapOf(
                            "deviceModel" to android.os.Build.MODEL,
                            "systemVersion" to android.os.Build.VERSION.RELEASE,
                            "simPresent" to (tm?.simState == android.telephony.TelephonyManager.SIM_STATE_READY),
                            "simCarrier" to tm?.networkOperatorName?.takeIf { it.isNotEmpty() }
                        ))
                    }
                    "initAdSdk"          -> { MyApplication.acceptPrivacyAndInitSdk(this); result.success(null) }
                    "showSplashAd"       -> { adManager.showSplashAd(this, posId(AdConfig.SPLASH_POS_ID)); result.success(null) }
                    "dismissSplashAd"    -> { adManager.dismissSplashAd(); result.success(null) }
                    "loadRewardedAd"     -> { adManager.loadRewardedAd(this, posId(AdConfig.REWARDED_POS_ID)); result.success(null) }
                    "showRewardedAd"     -> { adManager.showRewardedAd(this); result.success(null) }
                    "showInterstitialAd"           -> { adManager.showInterstitialAd(this, posId(AdConfig.INTERSTITIAL_POS_ID)); result.success(null) }
                    "showFullScreenInterstitialAd" -> { adManager.showInterstitialAd(this, posId(AdConfig.INTERSTITIAL_POS_ID)); result.success(null) }
                    else                           -> result.notImplemented()
                }
            }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "com.billtrack/ad_event")
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) { adManager.eventSink = events }
                override fun onCancel(arguments: Any?) { adManager.eventSink = null }
            })

        flutterEngine.plugins.add(object : FlutterPlugin {
            override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
                binding.platformViewRegistry.registerViewFactory(
                    "com.billtrack/banner_ad",
                    BannerAdViewFactory(this@MainActivity, binding.binaryMessenger)
                )
                binding.platformViewRegistry.registerViewFactory(
                    "com.billtrack/native_express_ad",
                    NativeExpressAdViewFactory(this@MainActivity, binding.binaryMessenger)
                )
            }
            override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {}
        })
    }
}
