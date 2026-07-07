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
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import org.mgy.april.MgFlowManager
import org.mgy.april.interfaces.MgNativeInfo
import org.mgy.april.interfaces.MgNativePrepareInfo
import org.mgy.april.interfaces.OnNativeLoadAdListener
import java.lang.ref.WeakReference
import java.net.URL
import java.util.concurrent.Executors

class NativeExpressAdViewFactory(private val activity: Activity) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val params = args as? Map<*, *>
        val posId  = params?.get("posId") as? String ?: AdConfig.DETAIL_BANNER_POS_ID
        return NativeExpressAdPlatformView(activity, posId)
    }
}

// 芒果信息流为自渲染：SDK 返回 MgNativeInfo 数据，绑定到自建布局后 prepare 注册点击
class NativeExpressAdPlatformView(
    private val activity: Activity,
    posId: String
) : PlatformView {

    private val container = FrameLayout(activity)
    private var nativeInfo: MgNativeInfo? = null

    companion object {
        private val imageExecutor = Executors.newCachedThreadPool()
    }

    init {
        MyApplication.runWhenReady {
            val adView = View.inflate(activity, R.layout.mg_native_ad, null)
            MgFlowManager.getInstance().loadFlow(activity, posId, adView, object : OnNativeLoadAdListener {
                override fun onNativeLoaded(adInfo: MgNativeInfo?) {
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
        val adRoot = adInfo.adMediaView ?: return
        (adRoot.parent as? ViewGroup)?.removeView(adRoot)
        container.removeAllViews()
        container.addView(
            adRoot,
            FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT)
        )

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
        if (pic != null && !imgUrl.isNullOrEmpty()) loadImage(imgUrl, pic)

        if (logo != null) {
            when {
                adInfo.adLogo != null -> logo.setImageBitmap(adInfo.adLogo)
                !adInfo.adLogoUrl.isNullOrEmpty() -> loadImage(adInfo.adLogoUrl!!, logo)
            }
        }
        close?.setOnClickListener { container.visibility = View.GONE }

        val prepareInfo = MgNativePrepareInfo().apply {
            setActivityRef(WeakReference(activity))
            close?.let { setCloseView(it) }
            action?.let { setCtaViewList(it) }
            pic?.let { setImageViewList(it) }
            setClickViewList(adRoot)
        }
        adInfo.prepare(prepareInfo)
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
