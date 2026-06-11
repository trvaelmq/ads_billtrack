package com.jileduo.finance

import android.app.Activity
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.ViewGroup.LayoutParams.MATCH_PARENT
import android.widget.FrameLayout
import android.view.ViewGroup
import com.qq.e.ads.interstitial2.UnifiedInterstitialAD
import com.qq.e.ads.interstitial2.UnifiedInterstitialADListener
import com.qq.e.ads.rewardvideo.RewardVideoAD
import com.qq.e.ads.rewardvideo.RewardVideoADListener
import com.qq.e.ads.splash.SplashAD
import com.qq.e.ads.splash.SplashADListener
import com.qq.e.comm.util.AdError
import io.flutter.plugin.common.EventChannel

class AdManager {

    var eventSink: EventChannel.EventSink? = null
    private val handler = Handler(Looper.getMainLooper())

    private var rewardedAd: RewardVideoAD? = null
    private var interstitialAd: UnifiedInterstitialAD? = null
    private var splashAd: SplashAD? = null
    private var splashContainer: FrameLayout? = null

    // ── Splash ───────────────────────────────────────────────────
    fun showSplashAd(activity: Activity, posId: String = AdConfig.SPLASH_POS_ID) {
        Log.d("GDT_AD", "showSplashAd called, sdkReady=${MyApplication.sdkReady}")
        if (splashAd != null) return
        MyApplication.runWhenReady { doShowSplashAd(activity, posId) }
    }

    fun dismissSplashAd() {
        handler.post {
            removeSplashOverlay()
            splashAd = null
        }
    }

    private fun doShowSplashAd(activity: Activity, posId: String = AdConfig.SPLASH_POS_ID) {
        Log.d("GDT_AD", "doShowSplashAd posId=$posId")
        if (splashAd != null) return

        // 用独立 overlay 容器承载开屏，便于强制移除，避免 Flutter 跳路由后仍被盖住
        val root = activity.findViewById<ViewGroup>(android.R.id.content) ?: return
        val container = FrameLayout(activity).apply {
            layoutParams = ViewGroup.LayoutParams(MATCH_PARENT, MATCH_PARENT)
        }
        removeSplashOverlay()
        splashContainer = container
        root.addView(container)

        splashAd = SplashAD(activity, posId, object : SplashADListener {
            override fun onADLoaded(skipTime: Long) {
                Log.d("GDT_AD", "splash onADLoaded")
                splashAd?.showAd(container)
            }
            override fun onADPresent()              { sendEvent("splash", "shown") }
            override fun onADDismissed()            {
                sendEvent("splash", "dismissed")
                handler.post { removeSplashOverlay() }
                splashAd = null
            }
            override fun onADClicked()              { sendEvent("splash", "clicked") }
            override fun onADTick(p0: Long)         {}
            override fun onADExposure()             {}
            override fun onNoAD(e: AdError?)        {
                sendEvent("splash", "failed", e?.errorMsg ?: "")
                Log.e("GDT_AD", "splash onNoAD code=${e?.errorCode} msg=${e?.errorMsg}")
                handler.post { removeSplashOverlay() }
                splashAd = null
            }
        }, 3000)
        splashAd!!.fetchAdOnly()
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
        Log.d("GDT_AD", "loadRewardedAd called, sdkReady=${MyApplication.sdkReady}")
        MyApplication.runWhenReady { doLoadRewardedAd(activity, posId) }
    }

    private fun doLoadRewardedAd(activity: Activity, posId: String = AdConfig.REWARDED_POS_ID) {
        Log.d("GDT_AD", "doLoadRewardedAd posId=$posId")
        rewardedAd = RewardVideoAD(activity, posId, object : RewardVideoADListener {
            override fun onADLoad()                                          { sendEvent("rewarded", "loaded") }
            override fun onVideoCached()                                     { sendEvent("rewarded", "video_loaded") }
            override fun onADShow()                                          { sendEvent("rewarded", "shown") }
            override fun onADExpose()                                        {}
            override fun onADClick()                                         { sendEvent("rewarded", "clicked") }
            override fun onReward(info: MutableMap<String, Any>?)            { sendEvent("rewarded", "rewarded") }
            override fun onVideoComplete()                                   {}
            override fun onADClose()                                         { sendEvent("rewarded", "closed") }
            override fun onError(e: AdError?)                                { sendEvent("rewarded", "failed", e?.errorMsg ?: ""); Log.e("GDT_AD", "rewarded onError code=${e?.errorCode} msg=${e?.errorMsg}") }
        })
        rewardedAd?.loadAD()
        sendEvent("rewarded", "loading")
    }

    fun showRewardedAd(activity: Activity) {
        val ad = rewardedAd
        if (ad == null || !ad.isValid) {
            sendEvent("rewarded", "not_ready"); return
        }
        ad.showAD(activity)
    }

    // ── Interstitial（弹框）──────────────────────────────────────
    fun showInterstitialAd(activity: Activity, posId: String = AdConfig.INTERSTITIAL_POS_ID) {
        Log.d("GDT_AD", "showInterstitialAd called, sdkReady=${MyApplication.sdkReady}")
        MyApplication.runWhenReady { doShowInterstitialAd(activity, posId) }
    }

    private fun doShowInterstitialAd(activity: Activity, posId: String = AdConfig.INTERSTITIAL_POS_ID) {
        Log.d("GDT_AD", "doShowInterstitialAd posId=$posId")
        interstitialAd = UnifiedInterstitialAD(activity, posId, object : UnifiedInterstitialADListener {
            override fun onADReceive()          { sendEvent("interstitial", "loaded"); handler.post { interstitialAd?.show(activity) } }
            override fun onVideoCached()        {}
            override fun onNoAD(e: AdError?)    { sendEvent("interstitial", "failed", e?.errorMsg ?: ""); Log.e("GDT_AD", "interstitial onNoAD code=${e?.errorCode} msg=${e?.errorMsg}") }
            override fun onADOpened()           {}
            override fun onADExposure()         { sendEvent("interstitial", "shown") }
            override fun onADClicked()          { sendEvent("interstitial", "clicked") }
            override fun onADLeftApplication()  {}
            override fun onADClosed()           { sendEvent("interstitial", "dismissed") }
            override fun onRenderSuccess()      {}
            override fun onRenderFail()         {}
        })
        interstitialAd?.loadAD()
        sendEvent("interstitial", "loading")
    }

    // ── Interstitial（全屏）──────────────────────────────────────
    fun showFullScreenInterstitialAd(activity: Activity, posId: String = AdConfig.INTERSTITIAL_POS_ID) {
        Log.d("GDT_AD", "showFullScreenInterstitialAd called, sdkReady=${MyApplication.sdkReady}")
        MyApplication.runWhenReady { doShowFullScreenInterstitialAd(activity, posId) }
    }

    private fun doShowFullScreenInterstitialAd(activity: Activity, posId: String = AdConfig.INTERSTITIAL_POS_ID) {
        Log.d("GDT_AD", "doShowFullScreenInterstitialAd posId=$posId")
        interstitialAd = UnifiedInterstitialAD(activity, posId, object : UnifiedInterstitialADListener {
            override fun onADReceive()          { sendEvent("interstitial", "loaded"); handler.post { interstitialAd?.showFullScreenAD(activity) } }
            override fun onVideoCached()        {}
            override fun onNoAD(e: AdError?)    { sendEvent("interstitial", "failed", e?.errorMsg ?: ""); Log.e("GDT_AD", "interstitial onNoAD code=${e?.errorCode} msg=${e?.errorMsg}") }
            override fun onADOpened()           {}
            override fun onADExposure()         { sendEvent("interstitial", "shown") }
            override fun onADClicked()          { sendEvent("interstitial", "clicked") }
            override fun onADLeftApplication()  {}
            override fun onADClosed()           { sendEvent("interstitial", "dismissed") }
            override fun onRenderSuccess()      {}
            override fun onRenderFail()         {}
        })
        interstitialAd?.loadFullScreenAD()
        sendEvent("interstitial", "loading")
    }

    // ── Helper ───────────────────────────────────────────────────
    private fun sendEvent(type: String, event: String, msg: String = "") {
        val data = mutableMapOf<String, Any>("type" to type, "event" to event)
        if (msg.isNotEmpty()) data["msg"] = msg
        handler.post { eventSink?.success(data) }
    }
}
