package com.jileduo.finance

import android.app.Application
import android.content.Context
import android.util.Log
import org.mgy.april.MgInitManager

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

        /** Flutter 侧用户同意隐私政策后调用：持久化同意状态并初始化芒果聚合 SDK */
        fun acceptPrivacyAndInitSdk(context: Context) {
            context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
                .edit().putBoolean(KEY_PRIVACY_ACCEPTED, true).apply()
            initMangoSdk(context)
        }

        private fun initMangoSdk(context: Context) {
            if (sdkReady) return
            // 参数依次: personalizedState 个性化推荐 / appInstallStatus 安装列表 /
            // canUseAndroid androidId / canUseIMEI / canUseLocation
            MgInitManager.getInstance().initSDK(
                context, AdConfig.APP_ID, AdConfig.CHANNEL,
                true, false, true, false, false
            )
            Log.d("MG_AD", "芒果 SDK 初始化完成")
            onReady()
        }
    }

    override fun onCreate() {
        super.onCreate()

        // 广告 SDK 仅在用户已同意隐私政策后才初始化，避免提前采集个人信息
        if (isPrivacyAccepted(this)) {
            initMangoSdk(this)
        }
    }
}
