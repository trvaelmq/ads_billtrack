package com.jileduo.finance

import android.app.Activity
import android.content.Context
import android.graphics.BitmapFactory
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import android.widget.ImageView
import android.widget.TextView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import org.mgy.april.MgFlowManager
import org.mgy.april.interfaces.MgNativeEventListener
import org.mgy.april.interfaces.MgNativeInfo
import org.mgy.april.interfaces.MgNativePrepareInfo
import org.mgy.april.interfaces.OnNativeLoadAdListener
import java.lang.ref.WeakReference
import java.net.URL
import java.util.concurrent.Executors

class NativeExpressAdViewFactory(
    private val activity: Activity,
    private val messenger: BinaryMessenger,
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val params = args as? Map<*, *>
        val posId  = params?.get("posId") as? String ?: AdConfig.DETAIL_BANNER_POS_ID
        val channel = MethodChannel(messenger, "com.billtrack/ad_view_$viewId")
        return NativeExpressAdPlatformView(activity, posId, channel)
    }
}

// 芒果信息流为自渲染：SDK 返回 MgNativeInfo 数据，绑定到自建布局后 prepare 注册点击
class NativeExpressAdPlatformView(
    private val activity: Activity,
    posId: String,
    private val channel: MethodChannel,
) : PlatformView {

    private val container = FrameLayout(activity)
    private var nativeInfo: MgNativeInfo? = null

    companion object {
        private val imageExecutor = Executors.newCachedThreadPool()
    }

    init {
        Log.d("MG_AD", "flow PlatformView 创建 posId=$posId sdkReady=${MyApplication.sdkReady}")
        MyApplication.runWhenReady {
            Log.d("MG_AD", "flow 开始 loadFlow posId=$posId")
            val adView = View.inflate(activity, R.layout.mg_native_ad, null)
            MgFlowManager.getInstance().loadFlow(activity, posId, adView, object : OnNativeLoadAdListener {
                override fun onNativeLoaded(adInfo: MgNativeInfo?) {
                    Log.d(
                        "MG_AD",
                        "flow onNativeLoaded adInfo=${adInfo != null} express=${adInfo?.isNativeExpress} " +
                            "title=${adInfo?.title} mediaView=${adInfo?.adMediaView != null}"
                    )
                    adInfo ?: return
                    nativeInfo = adInfo
                    activity.runOnUiThread { bindAndShow(adInfo) }
                }
                override fun onNativeAdFail(errorInfo: String?) {
                    Log.e("MG_AD", "flow onNativeAdFail: $errorInfo")
                }
            })
        }
    }

    private fun bindAndShow(adInfo: MgNativeInfo) {
        val adRoot = adInfo.adMediaView
        if (adRoot == null) {
            Log.e("MG_AD", "flow bindAndShow adMediaView 为 null,无法展示")
            return
        }
        (adRoot.parent as? ViewGroup)?.removeView(adRoot)
        container.removeAllViews()
        container.visibility = View.VISIBLE
        container.addView(
            adRoot,
            FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT)
        )
        reportHeight(adRoot)

        // 模板/express 源:adMediaView 是 SDK 自渲染视图,不含我们的 mg_close,
        // 只能靠 SDK 模板自带关闭键回调 onAdClose 收起(与 iOS nativeAdDidClose 对齐)。
        // 自渲染源:adMediaView 内含 mg_close,走下方自建布局绑定。
        if (adInfo.isNativeExpress) {
            adInfo.setOnNativeExpressAdListener(object : MgNativeEventListener {
                override fun onAdClose() {
                    Log.d("MG_AD", "flow express onAdClose 收起占位")
                    activity.runOnUiThread { collapse() }
                }
                override fun onAdImpressed() {}
                override fun onAdClicked() {}
                override fun onAdVideoStart() {}
                override fun onAdVideoEnd() {}
                override fun onAdVideoProgress() {}
                override fun onAdFailed(errorInfo: String?) {
                    Log.e("MG_AD", "flow express onAdFailed: $errorInfo")
                }
            })
            // express 模板由 SDK 自渲染，必须调用 prepare() 才会触发渲染并注册曝光/点击，
            // 否则模板不渲染，adMediaView 停留在 0×0（自建控件对 express 无效，故只传点击区）。
            val prepareInfo = MgNativePrepareInfo().apply {
                setActivityRef(WeakReference(activity))
                setClickViewList(adRoot)
            }
            adInfo.prepare(prepareInfo)
            return
        }

        val title  = adRoot.findViewById<TextView>(R.id.mg_title)
        val desc   = adRoot.findViewById<TextView>(R.id.mg_desc)
        val action = adRoot.findViewById<TextView>(R.id.mg_action)
        val pic    = adRoot.findViewById<ImageView>(R.id.mg_image)
        val logo   = adRoot.findViewById<ImageView>(R.id.mg_ad_logo)
        val close  = adRoot.findViewById<View>(R.id.mg_close)

        title?.text = adInfo.title ?: ""
        desc?.text = adInfo.description ?: ""
        action?.text = adInfo.callToAction?.takeIf { it.isNotEmpty() } ?: "查看详情"

        val imgUrl = adInfo.mainImageUrl?.takeIf { it.isNotEmpty() }
            ?: MgFlowManager.findFirstNonNull(adInfo.imageUrlList)
        Log.d(
            "MG_AD",
            "flow bind 控件命中: title=${title != null} desc=${desc != null} action=${action != null} " +
                "image=${pic != null} imgUrl=$imgUrl"
        )
        if (pic != null && !imgUrl.isNullOrEmpty()) loadImage(imgUrl, pic)

        if (logo != null) {
            when {
                adInfo.adLogo != null -> logo.setImageBitmap(adInfo.adLogo)
                !adInfo.adLogoUrl.isNullOrEmpty() -> loadImage(adInfo.adLogoUrl!!, logo)
            }
        }
        close?.setOnClickListener { collapse() }

        val prepareInfo = MgNativePrepareInfo().apply {
            setActivityRef(WeakReference(activity))
            close?.let { setCloseView(it) }
            action?.let { setCtaViewList(it) }
            pic?.let { setImageViewList(it) }
            setClickViewList(adRoot)
        }
        adInfo.prepare(prepareInfo)
    }

    // 关闭：清空 SDK 视图并通知 Flutter 收起占位。express/自渲染两条关闭路径共用。
    private fun collapse() {
        container.removeAllViews()
        container.visibility = View.GONE
        channel.invokeMethod("resize", 0.0)
    }

    // 按容器实际宽度、不限高地测量信息流真实高度，转 dp 回传给 Flutter 自适应
    private fun reportHeight(adRoot: View) {
        container.post {
            val metrics = activity.resources.displayMetrics
            val widthPx = if (container.width > 0) container.width else metrics.widthPixels
            adRoot.measure(
                View.MeasureSpec.makeMeasureSpec(widthPx, View.MeasureSpec.EXACTLY),
                View.MeasureSpec.makeMeasureSpec(0, View.MeasureSpec.UNSPECIFIED),
            )
            val hPx = maxOf(adRoot.measuredHeight, adRoot.height)
            if (hPx > 0) {
                val hDp = hPx / metrics.density
                Log.d("MG_AD", "flow reportHeight ${hDp}dp (px=$hPx w=$widthPx)")
                channel.invokeMethod("resize", hDp.toDouble())
            }
        }
    }

    /** 轻量网络图片加载，避免为广告引入 Glide */
    private fun loadImage(url: String, target: ImageView) {
        imageExecutor.execute {
            try {
                val bmp = URL(url).openStream().use { BitmapFactory.decodeStream(it) }
                activity.runOnUiThread { target.setImageBitmap(bmp) }
            } catch (e: Throwable) {
                Log.e("MG_AD", "loadImage failed: $e")
            }
        }
    }

    override fun getView(): View = container
    override fun dispose() {
        nativeInfo?.release()
        nativeInfo = null
    }
}
