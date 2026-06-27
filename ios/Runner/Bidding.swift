import Foundation

/// 竞价判定结果
enum BidResult {
    case won      // eCPM >= 底价，已上报竞胜，应展示
    case lost     // eCPM < 底价，已上报竞败，应放弃展示
    case skipped  // eCPM<=0（非竞价位/取不到价），未上报，按现状展示
}

/// 统一竞价判定：仅做出价上报与决策，不发 Flutter 事件、不展示。
/// 调用方据返回值处理展示与事件兜底。
/// - ad: 任意遵循 GDTAdProtocol 的广告对象（开屏/激励/插屏/Banner/原生）。
func gdtEvaluateBid(eCPM: Int, floor: Int, ad: GDTAdProtocol) -> BidResult {
    if eCPM <= 0 { return .skipped }
    if eCPM >= floor {
        ad.sendWinNotification?(withInfo: [
            "expectCostPrice": NSNumber(value: eCPM),
            "highestLossPrice": NSNumber(value: floor),
        ])
        return .won
    }
    ad.sendLossNotification?(withInfo: [
        "winPrice": NSNumber(value: floor),
        "lossReason": NSNumber(value: 1),       // GDTAdBiddingLossReasonLowPrice
        "adnId": AdConfig.kSelfAdnId,
    ])
    return .lost
}
