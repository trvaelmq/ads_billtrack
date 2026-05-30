package com.example.ads_billtrack

import android.app.Activity
import android.content.Context
import android.view.View
import com.qq.e.ads.banner2.UnifiedBannerADListener
import com.qq.e.ads.banner2.UnifiedBannerView
import com.qq.e.comm.util.AdError
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class BannerAdViewFactory(private val activity: Activity) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val params = args as? Map<*, *>
        val posId  = params?.get("posId") as? String ?: AdConfig.BANNER_POS_ID
        return BannerAdPlatformView(activity, posId)
    }
}

class BannerAdPlatformView(activity: Activity, posId: String) : PlatformView {

    private val bannerView = UnifiedBannerView(activity, posId, object : UnifiedBannerADListener {
        override fun onADReceive()              {}
        override fun onADExposure()             {}
        override fun onADClosed()               {}
        override fun onADClicked()              {}
        override fun onADLeftApplication()      {}
        override fun onNoAD(e: AdError?)        {}
    })

    init {
        bannerView.setRefresh(30)
        bannerView.loadAD()
    }

    override fun getView(): View = bannerView
    override fun dispose()      { bannerView.destroy() }
}
