package com.jileduo.finance

import android.app.Application
import android.content.Context
import android.util.Log
import com.qq.e.comm.managers.GDTAdSdk
import com.qq.e.comm.managers.GDTAdSdk.OnStartListener

class MyApplication : Application() {

    companion object {
        private const val PREFS_NAME = "AdSdkPrefs"
        private const val KEY_PRIVACY_ACCEPTED = "privacy_accepted"

        @Volatile var sdkReady = false
        private val pendingActions = mutableListOf<() -> Unit>()

        fun runWhenReady(action: () -> Unit) {
            if (sdkReady) {
                action()
            } else {
                synchronized(pendingActions) { pendingActions.add(action) }
            }
        }

        private fun onReady() {
            sdkReady = true
            val actions = synchronized(pendingActions) { pendingActions.toList().also { pendingActions.clear() } }
            actions.forEach { it() }
        }

        fun isPrivacyAccepted(context: Context): Boolean =
            context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
                .getBoolean(KEY_PRIVACY_ACCEPTED, false)

        /** Flutter 侧用户同意隐私政策后调用：持久化同意状态并初始化 GDT SDK */
        fun acceptPrivacyAndInitSdk(context: Context) {
            context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
                .edit().putBoolean(KEY_PRIVACY_ACCEPTED, true).apply()
            initGdtSdk(context)
        }

        private fun initGdtSdk(context: Context) {
            if (sdkReady) return
            GDTAdSdk.initWithoutStart(context, AdConfig.APP_ID)
            GDTAdSdk.start(object : OnStartListener {
                override fun onStartSuccess() {
                    Log.d("GDT_AD", "SDK 初始化成功")
                    onReady()
                }
                override fun onStartFailed(e: Exception) {
                    Log.e("GDT_AD", "SDK 初始化失败: $e")
                }
            })
        }
    }

    override fun onCreate() {
        super.onCreate()

        // GDT 广告 SDK 仅在用户已同意隐私政策后才初始化，避免提前采集个人信息
        if (isPrivacyAccepted(this)) {
            initGdtSdk(this)
        }
    }
}
