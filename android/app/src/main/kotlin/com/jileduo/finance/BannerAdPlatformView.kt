package com.jileduo.finance

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.View
import android.widget.FrameLayout
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import org.mgy.april.MgBannerManager
import org.mgy.april.interfaces.OnBannerAdListener

class BannerAdViewFactory(private val activity: Activity) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val params = args as? Map<*, *>
        val posId  = params?.get("posId") as? String ?: AdConfig.BANNER_POS_ID
        return BannerAdPlatformView(activity, posId)
    }
}

// 注意: MgBannerManager 为单例，同屏最多展示一个 Banner（当前 App 单屏仅一个 Banner，满足）
class BannerAdPlatformView(activity: Activity, posId: String) : PlatformView {

    private val container = FrameLayout(activity)

    init {
        MyApplication.runWhenReady {
            MgBannerManager.getInstance().loadBanner(activity, posId, object : OnBannerAdListener {
                override fun onReceived(view: View?) {
                    Log.d("MG_AD", "banner onReceived")
                    view ?: return
                    container.removeAllViews()
                    container.addView(view)
                }
                override fun onShow(ecpm: Int)   {}
                override fun onClick()           {}
                override fun onLeftApplication() {}
                override fun onClose()           { container.removeAllViews() }
                override fun onError(message: String?) {
                    Log.e("MG_AD", "banner onError: $message")
                }
            })
        }
    }

    override fun getView(): View = container
    override fun dispose() {
        MgBannerManager.getInstance().onMgBannerDestroy()
    }
}
