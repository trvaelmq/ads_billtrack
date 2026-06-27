package com.jileduo.finance

import android.app.Activity
import android.content.Context
import android.util.Log
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
        val floor  = params?.get("floor") as? Int ?: 0
        return BannerAdPlatformView(activity, posId, floor)
    }
}

class BannerAdPlatformView(activity: Activity, posId: String, private val floor: Int) : PlatformView {

    private lateinit var bannerView: UnifiedBannerView

    init {
        bannerView = UnifiedBannerView(activity, posId, object : UnifiedBannerADListener {
            override fun onADReceive() {
                val e = bannerView.getECPM()
                when (Bidding.evaluate(e, floor, bannerView)) {
                    BidResult.LOST -> { bannerView.visibility = View.GONE; Log.d("Banner", "竞败 ecpm=$e floor=$floor，隐藏") }
                    else -> bannerView.visibility = View.VISIBLE
                }
            }
            override fun onADExposure()             {}
            override fun onADClosed()               {}
            override fun onADClicked()              {}
            override fun onADLeftApplication()      {}
            override fun onNoAD(e: AdError?)        {}
        })
        bannerView.setRefresh(30)
        bannerView.loadAD()
    }

    override fun getView(): View = bannerView
    override fun dispose()      { bannerView.destroy() }
}
