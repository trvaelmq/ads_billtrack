package com.jileduo.finance

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.View
import android.widget.FrameLayout
import com.qq.e.ads.nativ.ADSize
import com.qq.e.ads.nativ.NativeExpressAD
import com.qq.e.ads.nativ.NativeExpressADView
import com.qq.e.comm.util.AdError
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class NativeExpressAdViewFactory(private val activity: Activity) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val params = args as? Map<*, *>
        val posId  = params?.get("posId")  as? String ?: AdConfig.BANNER_POS_ID
        val width  = params?.get("width")  as? Int    ?: ADSize.FULL_WIDTH
        val height = params?.get("height") as? Int    ?: ADSize.AUTO_HEIGHT
        return NativeExpressAdPlatformView(activity, posId, width, height)
    }
}

class NativeExpressAdPlatformView(
    private val activity: Activity,
    posId: String,
    width: Int,
    height: Int
) : PlatformView {

    private val container = FrameLayout(activity)

    init {
        val adSize = ADSize(ADSize.FULL_WIDTH, ADSize.AUTO_HEIGHT)
        val ad = NativeExpressAD(
            activity, adSize, posId,
            object : NativeExpressAD.NativeExpressADListener {
                override fun onNoAD(error: AdError?) {
                    Log.e("NativeExpress", "加载失败: ${error?.errorMsg}")
                }
                override fun onADLoaded(views: List<NativeExpressADView>) {
                    val adView = views.firstOrNull() ?: return
                    adView.render()
                    Log.d("NativeExpress", "加载成功，开始 render")
                }
                override fun onRenderSuccess(adView: NativeExpressADView) {
                    activity.runOnUiThread { container.addView(adView) }
                    Log.d("NativeExpress", "render 成功")
                }
                override fun onRenderFail(adView: NativeExpressADView) {
                    Log.e("NativeExpress", "render 失败")
                }
                override fun onADExposure(adView: NativeExpressADView)        {}
                override fun onADClicked(adView: NativeExpressADView)         {}
                override fun onADClosed(adView: NativeExpressADView)          {}
                override fun onADLeftApplication(adView: NativeExpressADView) {}
            }
        )
        ad.loadAD(1)
        Log.d("NativeExpress", "开始加载 posId=$posId size=${width}x${height}")
    }

    override fun getView(): View = container
    override fun dispose()      {}
}
