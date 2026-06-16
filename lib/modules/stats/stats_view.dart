import 'package:ads_billtrack/widgets/banner_ad_widget.dart';
import 'package:ads_billtrack/widgets/native_express_ad_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/ad_config.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/ad_service.dart';
import '../../core/theme/app_theme.dart';
import 'stats_controller.dart';

class StatsView extends GetView<StatsController> {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bill = controller.bill;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        elevation: 0,
        title: Obx(
          () => Text(
            '统计 · ${bill.currentMonthLabel}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.white),
            onPressed: () => bill.changeMonth(-1),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: Colors.white),
            onPressed: () => bill.isCurrentMonth ? null : bill.changeMonth(1),
          ),
        ],
      ),
      body: Obx(() {
        final expByCat = bill.expenseByCategory;
        final last6 = bill.last6MonthsStats;
        return Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Get.toNamed('/history'),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    child: Text(
                      '统计记录',
                      style: TextStyle(
                        color: Color(0xFFD2911E),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: const BannerAdWidget(height: 60),
              ),
              const SizedBox(height: 4),
              _ExpensePieChart(expByCat: expByCat),
              const SizedBox(height: 4),
              _BarChartCard(last6: last6),
              const SizedBox(height: 4),
              Expanded(
                child:
                    defaultTargetPlatform == TargetPlatform.iOS
                        ? LayoutBuilder(
                          builder:
                              (context, constraints) => Center(
                                child: SizedBox(
                                  width: constraints.maxWidth + 32,
                                  child: NativeExpressAdWidget(
                                    height: constraints.maxHeight,
                                    posId: AdConfig.detailBannerPosId,
                                  ),
                                ),
                              ),
                        )
                        : Container(
                          margin: const EdgeInsets.only(top: 20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: BannerAdWidget(
                            height: 60,
                            posId: AdConfig.detailBannerPosId,
                          ),
                        ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      }),
    );
  }
}

// ── 支出饼图 ──────────────────────────────────────────────────────
class _ExpensePieChart extends StatefulWidget {
  final Map<String, double> expByCat;
  const _ExpensePieChart({required this.expByCat});

  @override
  State<_ExpensePieChart> createState() => _ExpensePieChartState();
}

class _ExpensePieChartState extends State<_ExpensePieChart> {
  double _scale = 1.0;

  // 点击「支出构成」触发：随机延迟弹插屏 → 激励 → 跳记录页 → 返回再插屏
  void _triggerAdFlow() {
    final ad = AdService.to;
    // 冷却中：提示剩余时间，不进入广告流程（看完一个需冷却才能看下一个）
    if (ad.cooldownRemaining.value > 0) {
      _showCooldownDialog(ad);
      return;
    }
    if (!ad.isRewardedReady.value) ad.loadRewardedAd(); // 兜底加载
    ad.startRewardedAdFlow();
  }

  void _showCooldownDialog(AdService ad) {
    Get.dialog(
      CupertinoAlertDialog(
        title: const Text('提示'),
        content: Padding(
          padding: const EdgeInsets.only(top: 6),
          // 实时绑定冷却秒数：每秒递减跳动，归零后自动关闭
          child: Obx(() {
            final seconds = ad.cooldownRemaining.value;
            if (seconds <= 0) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (Get.isDialogOpen ?? false) Get.back();
              });
              return const Text('冷却结束，可继续观看');
            }
            final m = seconds ~/ 60;
            final s = seconds % 60;
            final timeText =
                m > 0 ? '$m分${s.toString().padLeft(2, '0')}秒' : '$s秒';
            return Text('请等待 $timeText 后再试');
          }),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Get.back(),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.expByCat.values.fold(0.0, (s, v) => s + v);
    final entries =
        widget.expByCat.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.96),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTapUp: (_) {
        setState(() => _scale = 1.0);
        _triggerAdFlow();
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '支出构成',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                if (total == 0)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        '暂无支出数据',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                else
                  Row(
                    children: [
                      SizedBox(
                        height: 140,
                        width: 160,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 40,
                            sections:
                                entries.map((e) {
                                  final cat = AppConstants.categoryById(e.key);
                                  return PieChartSectionData(
                                    value: e.value,
                                    color: cat.color,
                                    radius: 40,
                                    title:
                                        total > 0
                                            ? '${(e.value / total * 100).toStringAsFixed(0)}%'
                                            : '',
                                    titleStyle: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              entries.take(6).map((e) {
                                final cat = AppConstants.categoryById(e.key);
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: cat.color,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        '${cat.emoji} ${cat.label}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '¥${e.value.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── 近6月收支柱状图 ────────────────────────────────────────────────
class _BarChartCard extends StatelessWidget {
  final List<Map<String, double>> last6;
  const _BarChartCard({required this.last6});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final maxVal = last6.fold(
      0.0,
      (m, e) =>
          [m, e['expense']!, e['income']!].reduce((a, b) => a > b ? a : b),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('近6月收支', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                _Legend(color: AppTheme.expenseRed, label: '支出'),
                const SizedBox(width: 12),
                _Legend(color: AppTheme.incomeGreen, label: '收入'),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: BarChart(
                BarChartData(
                  maxY: maxVal > 0 ? maxVal * 1.2 : 100,
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (v, _) {
                          final m = DateTime(
                            now.year,
                            now.month - 5 + v.toInt(),
                          );
                          return Text(
                            '${m.month}月',
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: List.generate(
                    6,
                    (i) => BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: last6[i]['expense']!,
                          color: AppTheme.expenseRed,
                          width: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        BarChartRodData(
                          toY: last6[i]['income']!,
                          color: AppTheme.incomeGreen,
                          width: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                      barsSpace: 4,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      const SizedBox(width: 4),
      Text(
        label,
        style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
      ),
    ],
  );
}
