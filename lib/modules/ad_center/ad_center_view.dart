import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/ad_config.dart';
import '../../core/services/ad_service.dart';
import '../../core/theme/app_theme.dart';
import '../../router/app_pages.dart';
import '../../widgets/coin_float_animation.dart';
import 'ad_center_controller.dart';

class AdCenterView extends GetView<AdCenterController> {
  const AdCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    final ad = AdService.to;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('签到'),
            actions: [
              Obx(() => Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🪙', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 4),
                        Text('${ad.totalCoins.value}',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      ],
                    ),
                  )),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 签到卡片
              _CheckinCard(),
              const SizedBox(height: 16),
              // 激励视频
              // _AdCard(
              //   emoji: '🎬',
              //   title: '看激励视频',
              //   subtitle: '完整观看即可获得金币奖励',
              //   reward: '+${AdConfig.rewardCoins}🪙',
              //   buttonLabel: '立即观看',
              //   color: AppTheme.primary,
              //   onTap: controller.watchRewarded,
              //   isReady: ad.isRewardedReady,
              //   todayWatched: ad.todayWatchCount,
              //   dailyLimit: AdConfig.dailyRewardedLimit,
              // ),
              // const SizedBox(height: 12),
              // // 插屏广告
              // _AdCard(
              //   emoji: '📱',
              //   title: '插屏广告',
              //   subtitle: '浏览广告内容获得金币',
              //   reward: '+${AdConfig.interstitialCoins}🪙',
              //   buttonLabel: '查看广告',
              //   color: const Color(0xFF7B1FA2),
              //   onTap: controller.watchInterstitial,
              // ),
              // const SizedBox(height: 20),
              // // 广告记录入口
              // _HistoryEntry(),
            ],
          ),
        ),
        Obx(() => ad.showCoinAnimation.value
            ? CoinFloatAnimation(coins: ad.lastEarnedCoins.value)
            : const SizedBox.shrink()),
      ],
    );
  }
}

// ── 签到卡片 ──────────────────────────────────────────────────────
class _CheckinCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = Get.find<AdCenterController>();
    return Obx(() {
      final checked = c.checkedInToday.value;
      final streak  = c.checkinStreak.value;
      return GestureDetector(
        onTap: c.goToCheckin,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: checked
                  ? [Colors.grey.shade400, Colors.grey.shade500]
                  : [const Color(0xFFFF8C00), const Color(0xFFFFB347)],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Text(checked ? '✅' : (streak >= 6 ? '🏆' : '🔥'),
                  style: const TextStyle(fontSize: 36)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(checked ? '今日已签到' : '每日签到',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(
                      checked
                          ? '连续签到 $streak 天，明天继续！'
                          : streak > 0
                              ? '已连续 $streak 天，今天签到得 +${(streak + 1) % 7 == 0 ? 20 : 5}🪙'
                              : '签到得 +${AdConfig.checkinCoins}🪙，7天连签奖励翻倍',
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white70),
            ],
          ),
        ),
      );
    });
  }
}

// ── 广告卡片 ──────────────────────────────────────────────────────
class _AdCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final String reward;
  final String buttonLabel;
  final Color  color;
  final VoidCallback onTap;
  final RxBool? isReady;
  final RxInt?  todayWatched;
  final int?    dailyLimit;

  const _AdCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.reward,
    required this.buttonLabel,
    required this.color,
    required this.onTap,
    this.isReady,
    this.todayWatched,
    this.dailyLimit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(child: Text(emoji, style: const TextStyle(fontSize: 28))),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  if (todayWatched != null && dailyLimit != null)
                    Obx(() => Text('今日 ${todayWatched!.value}/$dailyLimit 次',
                        style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary))),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(reward, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 6),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    minimumSize: Size.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(buttonLabel, style: const TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── 广告记录入口 ──────────────────────────────────────────────────
class _HistoryEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.history),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          children: [
            Icon(Icons.history, color: AppTheme.textSecondary),
            SizedBox(width: 12),
            Text('查看广告记录', style: TextStyle(fontSize: 15, color: AppTheme.textPrimary)),
            Spacer(),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
