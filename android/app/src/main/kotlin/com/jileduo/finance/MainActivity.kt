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
                    "initAdSdk"          -> { MyApplication.acceptPrivacyAndInitSdk(this); result.success(null) }
                    "showSplashAd"       -> { adManager.showSplashAd(this, posId(AdConfig.SPLASH_POS_ID)); result.success(null) }
                    "dismissSplashAd"    -> { adManager.dismissSplashAd(); result.success(null) }
                    "loadRewardedAd"     -> { adManager.loadRewardedAd(this, posId(AdConfig.REWARDED_POS_ID)); result.success(null) }
                    "showRewardedAd"     -> { adManager.showRewardedAd(this); result.success(null) }
                    "showInterstitialAd"           -> { adManager.showInterstitialAd(this, posId(AdConfig.INTERSTITIAL_POS_ID)); result.success(null) }
                    "showFullScreenInterstitialAd" -> { adManager.showFullScreenInterstitialAd(this, posId(AdConfig.INTERSTITIAL_POS_ID)); result.success(null) }
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
                    BannerAdViewFactory(this@MainActivity)
                )
                binding.platformViewRegistry.registerViewFactory(
                    "com.billtrack/native_express_ad",
                    NativeExpressAdViewFactory(this@MainActivity)
                )
            }
            override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {}
        })
    }
}
