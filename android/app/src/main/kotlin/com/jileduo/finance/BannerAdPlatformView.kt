package com.jileduo.finance

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import org.mgy.april.MgBannerManager
import org.mgy.april.interfaces.OnBannerAdListener

class BannerAdViewFactory(
    private val activity: Activity,
    private val messenger: BinaryMessenger,
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val params = args as? Map<*, *>
        val posId  = params?.get("posId") as? String ?: AdConfig.BANNER_POS_ID
        val channel = MethodChannel(messenger, "com.billtrack/ad_view_$viewId")
        return BannerAdPlatformView(activity, posId, channel)
    }
}

// 注意: MgBannerManager 为单例，同屏最多展示一个 Banner（当前 App 单屏仅一个 Banner，满足）
class BannerAdPlatformView(
    private val activity: Activity,
    private val posId: String,
    private val channel: MethodChannel,
) : PlatformView {

    private val container = FrameLayout(activity)

    init {
        // reload 供 Flutter 侧在上次加载失败、Tab 切回可见时主动触发一次重试
        // （常驻 Tab 页面不会自然重新创建 view）。
        channel.setMethodCallHandler { call, result ->
            if (call.method == "reload") { loadAd(); result.success(null) }
            else result.notImplemented()
        }
        loadAd()
    }

    private fun loadAd() {
        container.removeAllViews()
        MyApplication.runWhenReady {
            MgBannerManager.getInstance().loadBanner(activity, posId, object : OnBannerAdListener {
                override fun onReceived(view: View?) {
                    Log.d("MG_AD", "banner onReceived")
                    if (view == null) {
                        channel.invokeMethod("loadFailed", "onReceived: view=null")
                        return
                    }
                    container.removeAllViews()
                    // WRAP_CONTENT 让 banner 保持自身模板高度，再把真实高度回传 Flutter 自适应
                    container.addView(
                        view,
                        FrameLayout.LayoutParams(
                            ViewGroup.LayoutParams.MATCH_PARENT,
                            ViewGroup.LayoutParams.WRAP_CONTENT,
                        )
                    )
                    reportHeight(view)
                }
                override fun onShow(ecpm: Int)   {}
                override fun onClick()           {}
                override fun onLeftApplication() {}
                override fun onClose()           {
                    container.removeAllViews()
                    channel.invokeMethod("resize", 0.0) // 关闭后 Flutter 收起占位
                }
                override fun onError(message: String?) {
                    Log.e("MG_AD", "banner onError: $message")
                    channel.invokeMethod("loadFailed", message ?: "onError")
                }
            })
        }
    }

    // 按容器实际宽度、不限高地测量 banner 真实高度，转 dp 回传给 Flutter
    private fun reportHeight(view: View) {
        container.post {
            val metrics = activity.resources.displayMetrics
            val widthPx = if (container.width > 0) container.width else metrics.widthPixels
            view.measure(
                View.MeasureSpec.makeMeasureSpec(widthPx, View.MeasureSpec.EXACTLY),
                View.MeasureSpec.makeMeasureSpec(0, View.MeasureSpec.UNSPECIFIED),
            )
            val hPx = maxOf(view.measuredHeight, view.height)
            if (hPx > 0) {
                val hDp = hPx / metrics.density
                Log.d("MG_AD", "banner reportHeight ${hDp}dp (px=$hPx w=$widthPx)")
                channel.invokeMethod("resize", hDp.toDouble())
            }
        }
    }

    override fun getView(): View = container
    override fun dispose() {
        MgBannerManager.getInstance().onMgBannerDestroy()
    }
}
