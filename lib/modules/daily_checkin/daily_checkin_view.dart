import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import 'daily_checkin_controller.dart';

class DailyCheckinView extends GetView<DailyCheckinController> {
  const DailyCheckinView({super.key});

  static const _weekLabels = ['一', '二', '三', '四', '五', '六', '日'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        elevation: 0,
        title: const Text('每日签到', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GetBuilder<DailyCheckinController>(
        builder: (_) => Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // 连签卡片
                _StreakCard(streak: controller.streak),
                const SizedBox(height: 20),
                // 7天日历
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('本周签到', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(7, (i) {
                            final status = controller.weekStatus[i];
                            final isToday = i == 6;
                            return Column(
                              children: [
                                Text(_weekLabels[i],
                                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                const SizedBox(height: 6),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 36, height: 36,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: status
                                        ? AppTheme.primary
                                        : isToday
                                            ? AppTheme.primary.withValues(alpha: 0.15)
                                            : Colors.grey.shade100,
                                    border: isToday && !status
                                        ? Border.all(color: AppTheme.primary, width: 2)
                                        : null,
                                  ),
                                  child: Center(
                                    child: status
                                        ? const Icon(Icons.check, color: Colors.white, size: 18)
                                        : Text('${i + 1}',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: isToday ? AppTheme.primary : Colors.grey)),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // 奖励说明
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('签到奖励', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        _RewardRow(day: '第1-6天', coins: '+5🪙'),
                        _RewardRow(day: '第7天（连签满7天）', coins: '+20🪙'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // 签到按钮
                SizedBox(
                  width: double.infinity, height: 56,
                  child: ElevatedButton(
                    onPressed: controller.hasChecked ? null : controller.checkIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.hasChecked ? Colors.grey.shade300 : AppTheme.coinGold,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(
                      controller.hasChecked ? '今日已签到，明天再来 ✅' : '立即签到 +🪙',
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            // 奖励弹出
            Obx(() => controller.showReward.value
                ? _RewardOverlay(coins: controller.earnedCoins.value)
                : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  final int streak;
  const _StreakCard({required this.streak});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFFFF8C00), Color(0xFFFFB347)],
              begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(streak >= 6 ? '🏆' : '🔥', style: const TextStyle(fontSize: 48)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('连续签到 $streak 天',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                Text(streak > 0 ? '还差 ${7 - streak % 7} 天拿翻倍奖励！' : '今天开始签到吧',
                    style: const TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ],
        ),
      );
}

class _RewardRow extends StatelessWidget {
  final String day;
  final String coins;
  const _RewardRow({required this.day, required this.coins});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            const Icon(Icons.circle, size: 6, color: AppTheme.primary),
            const SizedBox(width: 8),
            Expanded(child: Text(day, style: const TextStyle(fontSize: 14))),
            Text(coins, style: const TextStyle(color: AppTheme.coinGold, fontWeight: FontWeight.bold, fontSize: 15)),
          ],
        ),
      );
}

class _RewardOverlay extends StatefulWidget {
  final int coins;
  const _RewardOverlay({required this.coins});

  @override
  State<_RewardOverlay> createState() => _RewardOverlayState();
}

class _RewardOverlayState extends State<_RewardOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl  = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _ctrl.forward();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.black26,
        child: Center(
          child: ScaleTransition(
            scale: _scale,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🎉', style: TextStyle(fontSize: 52)),
                  const SizedBox(height: 12),
                  const Text('签到成功！', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('+${widget.coins}🪙',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.coinGold)),
                ],
              ),
            ),
          ),
        ),
      );
}
