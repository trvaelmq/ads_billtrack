package com.jileduo.finance

import com.qq.e.comm.pi.IBidding

/** 竞价判定结果 */
enum class BidResult {
    WON,      // eCPM >= 底价，已上报竞胜，应展示
    LOST,     // eCPM < 底价，已上报竞败，应放弃展示
    SKIPPED   // eCPM<=0（非竞价位/取不到价），未上报，按现状展示
}

/** 统一竞价判定：仅做出价上报与决策，不发事件、不展示。调用方据返回值处理展示与兜底。 */
object Bidding {
    private const val LOSS_REASON_LOW_PRICE = 1 // BiddingLossReason.LOW_PRICE

    fun evaluate(ecpm: Int, floor: Int, ad: IBidding): BidResult {
        if (ecpm <= 0) return BidResult.SKIPPED
        return if (ecpm >= floor) {
            ad.sendWinNotification(mapOf<String, Any>(
                IBidding.EXPECT_COST_PRICE to ecpm,
                IBidding.HIGHEST_LOSS_PRICE to floor
            ))
            BidResult.WON
        } else {
            ad.sendLossNotification(mapOf<String, Any>(
                IBidding.WIN_PRICE to floor,
                IBidding.LOSS_REASON to LOSS_REASON_LOW_PRICE,
                IBidding.ADN_ID to AdConfig.SELF_ADN_ID
            ))
            BidResult.LOST
        }
    }
}
