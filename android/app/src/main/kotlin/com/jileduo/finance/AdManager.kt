package com.jileduo.finance

import android.app.Activity
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.ViewGroup
import android.view.ViewGroup.LayoutParams.MATCH_PARENT
import android.widget.FrameLayout
import io.flutter.plugin.common.EventChannel
import org.mgy.april.MgInterstitialManager
import org.mgy.april.MgRewardVideoManager
import org.mgy.april.MgSplashManager
import org.mgy.april.interfaces.OnInterstitialAdListener
import org.mgy.april.interfaces.OnRewardVideoListener
import org.mgy.april.interfaces.OnSplashAdListener

class AdManager {

    var eventSink: EventChannel.EventSink? = null
    private val handler = Handler(Looper.getMainLooper())

    private var splashContainer: FrameLayout? = null
    private var splashShowing = false
    private var rewardedReady = false

    // ── Splash ───────────────────────────────────────────────────
    fun showSplashAd(activity: Activity, posId: String = AdConfig.SPLASH_POS_ID) {
        Log.d("MG_AD", "showSplashAd called, sdkReady=${MyApplication.sdkReady}")
        if (splashShowing) return
        splashShowing = true
        MyApplication.runWhenReady { doShowSplashAd(activity, posId) }
    }

    fun dismissSplashAd() {
        handler.post {
            removeSplashOverlay()
            MgSplashManager.getInstance().onMgSplashDestroy()
            splashShowing = false
        }
    }

    private fun doShowSplashAd(activity: Activity, posId: String) {
        Log.d("MG_AD", "doShowSplashAd posId=$posId")

        // 用独立 overlay 容器承载开屏，便于强制移除，避免 Flutter 跳路由后仍被盖住
        val root = activity.findViewById<ViewGroup>(android.R.id.content) ?: return
        val container = FrameLayout(activity).apply {
            layoutParams = ViewGroup.LayoutParams(MATCH_PARENT, MATCH_PARENT)
        }
        removeSplashOverlay()
        splashContainer = container
        root.addView(container)

        MgSplashManager.getInstance().loadSplash(activity, posId, object : OnSplashAdListener {
            override fun onLoad(splash: OnSplashAdListener.MgSplash?) {
                Log.d("MG_AD", "splash onLoad")
                val c = splashContainer
                if (splash == null || c == null) return
                splash.show(c)
            }
            override fun onShow()  { sendEvent("splash", "shown") }
            override fun onClick() { sendEvent("splash", "clicked") }
            override fun onClose() {
                sendEvent("splash", "dismissed")
                handler.post { removeSplashOverlay() }
                splashShowing = false
            }
            override fun onError(message: String?) {
                Log.e("MG_AD", "splash onError: $message")
                sendEvent("splash", "failed", message ?: "")
                handler.post { removeSplashOverlay() }
                splashShowing = false
            }
        })
    }

    private fun removeSplashOverlay() {
        val container = splashContainer ?: return
        try {
            (container.parent as? ViewGroup)?.removeView(container)
        } catch (_: Throwable) {}
        splashContainer = null
    }

    // ── Rewarded Video ───────────────────────────────────────────
    fun loadRewardedAd(activity: Activity, posId: String = AdConfig.REWARDED_POS_ID) {
        Log.d("MG_AD", "loadRewardedAd called, sdkReady=${MyApplication.sdkReady}")
        rewardedReady = false
        MyApplication.runWhenReady { doLoadRewardedAd(activity, posId) }
    }

    private fun doLoadRewardedAd(activity: Activity, posId: String) {
        Log.d("MG_AD", "doLoadRewardedAd posId=$posId")
        MgRewardVideoManager.getInstance().loadRewardVideo(activity, posId, object : OnRewardVideoListener {
            override fun onLoad(video: OnRewardVideoListener.MgRewardVideo?) {
                rewardedReady = true
                sendEvent("rewarded", "loaded")
            }
            override fun onShow()                        { sendEvent("rewarded", "shown") }
            override fun onClick()                       { sendEvent("rewarded", "clicked") }
            override fun onPlayFinished()                {}
            override fun onVideoCheckReward(p0: String?) {}
            override fun onReward(ecpm: Int)             { sendEvent("rewarded", "rewarded") }
            override fun onClose() {
                rewardedReady = false
                sendEvent("rewarded", "closed")
            }
            override fun onError(message: String?) {
                rewardedReady = false
                Log.e("MG_AD", "rewarded onError: $message")
                sendEvent("rewarded", "failed", message ?: "")
            }
        })
        sendEvent("rewarded", "loading")
    }

    fun showRewardedAd(activity: Activity) {
        if (!rewardedReady) {
            sendEvent("rewarded", "not_ready"); return
        }
        MgRewardVideoManager.getInstance().mgRewardVideoShow()
    }

    // ── Interstitial ─────────────────────────────────────────────
    // 芒果聚合无「弹框/全屏」之分，两个入口走同一实现
    fun showInterstitialAd(activity: Activity, posId: String = AdConfig.INTERSTITIAL_POS_ID) {
        Log.d("MG_AD", "showInterstitialAd called, sdkReady=${MyApplication.sdkReady}")
        MyApplication.runWhenReady { doShowInterstitialAd(activity, posId) }
    }

    private fun doShowInterstitialAd(activity: Activity, posId: String) {
        Log.d("MG_AD", "doShowInterstitialAd posId=$posId")
        MgInterstitialManager.getInstance().loadInterstitial(activity, posId, object : OnInterstitialAdListener {
            override fun onLoad(ad: OnInterstitialAdListener.MgInterstitialAd?) {
                sendEvent("interstitial", "loaded")
                handler.post { MgInterstitialManager.getInstance().mgInterstitialShow() }
            }
            override fun onShow()            { sendEvent("interstitial", "shown") }
            override fun onClick()           { sendEvent("interstitial", "clicked") }
            override fun onPlayFinished()    {}
            override fun onLeftApplication() {}
            override fun onClose()           { sendEvent("interstitial", "dismissed") }
            override fun onError(message: String?) {
                Log.e("MG_AD", "interstitial onError: $message")
                sendEvent("interstitial", "failed", message ?: "")
            }
        })
        sendEvent("interstitial", "loading")
    }

    // ── Helper ───────────────────────────────────────────────────
    private fun sendEvent(type: String, event: String, msg: String = "") {
        val data = mutableMapOf<String, Any>("type" to type, "event" to event)
        if (msg.isNotEmpty()) data["msg"] = msg
        handler.post { eventSink?.success(data) }
    }
}
