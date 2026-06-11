import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/services/bill_service.dart';
import '../../core/services/storage_service.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/health_score_history.dart';

class HealthScoreView extends StatelessWidget {
  const HealthScoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: Get.back,
        ),
        title: const Text('财务健康评分',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: Builder(builder: (_) {
        final bill = BillService.to;
        return Obx(() {
          final result = _calcScore(bill);
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
            children: [
              _GaugeCard(score: result.total, level: result.level, color: result.color),
              const SizedBox(height: 16),
              _DimensionCard(dimensions: result.dimensions),
              const SizedBox(height: 16),
              _SuggestionCard(suggestions: result.suggestions),
              const SizedBox(height: 16),
              _MonthNote(),
              const SizedBox(height: 16),
              _HistoryChart(),
            ],
          );
        });
      }),
    );
  }

  /// 总分计算入口，供首页评分卡复用，保证与本页分数一致
  static int calcTotal(BillService bill) => _calcScore(bill).total;

  static _ScoreResult _calcScore(BillService bill) {
    final now        = DateTime.now();
    final bills      = StorageService.billsForMonth(now.year, now.month);
    final expense    = bill.monthlyExpense.value;
    final income     = bill.monthlyIncome.value;
    final budgets    = StorageService.budgets;
    final recurring  = StorageService.allRecurringRules;

    // 1. 储蓄能力（35分）
    int savings = 0;
    if (income > 0) {
      final rate = (income - expense) / income;
      if (rate >= 0.5) {
        savings = 35;
      } else if (rate >= 0.3) {
        savings = 28;
      } else if (rate >= 0.1) {
        savings = 18;
      } else if (rate >= 0) {
        savings = 8;
      } else {
        savings = 0;
      }
    } else if (expense == 0) {
      savings = 20;
    }

    // 2. 消费均衡（20分）
    int diversity = 0;
    if (expense > 0) {
      final catMap = bill.expenseByCategory;
      final values = catMap.values.where((v) => v > 0).toList();
      final maxShare = values.isEmpty ? 1.0 : values.reduce((a, b) => a > b ? a : b) / expense;
      if (maxShare <= 0.35) {
        diversity = 20;
      } else if (maxShare <= 0.5) {
        diversity = 14;
      } else if (maxShare <= 0.7) {
        diversity = 7;
      } else {
        diversity = 2;
      }
    } else {
      diversity = 20;
    }

    // 3. 记账坚持（15分）
    final daysPassed  = now.day;
    final activeDays  = bills.map((b) => b.date.day).toSet().length;
    final ratio       = daysPassed > 0 ? activeDays / daysPassed : 0.0;
    int consistency   = 0;
    if (ratio >= 0.8) {
      consistency = 15;
    } else if (ratio >= 0.5) {
      consistency = 10;
    } else if (ratio >= 0.3) {
      consistency = 5;
    }

    // 4. 预算执行（15分）
    int budgetScore = 0;
    if (budgets.isEmpty) {
      budgetScore = 8;
    } else {
      final catMap  = bill.expenseByCategory;
      final over    = budgets.entries.where((e) => (catMap[e.key] ?? 0) > e.value).length;
      final total   = budgets.length;
      if (over == 0) {
        budgetScore = 15;
      } else if (over <= total * 0.2) {
        budgetScore = 10;
      } else if (over <= total * 0.5) {
        budgetScore = 5;
      }
    }

    // 5. 现金流稳定（10分）
    final hasIncome = bills.any((b) => !b.isExpense);
    int cashFlow = hasIncome ? 10 : (income == 0 ? 5 : 0);

    // 6. 目标进度（5分）
    final hasSavingGoal = recurring.any((r) => r.isActive && !r.isExpense);
    int goalProgress = hasSavingGoal ? 5 : 0;

    final total = savings + diversity + consistency + budgetScore + cashFlow + goalProgress;

    String level;
    Color color;
    if (total >= 85) {
      level = '优秀';
      color = AppTheme.incomeGreen;
    } else if (total >= 70) {
      level = '良好';
      color = const Color(0xFF00B4D8);
    } else if (total >= 50) {
      level = '一般';
      color = AppTheme.warnOrange;
    } else {
      level = '待改善';
      color = AppTheme.expenseRed;
    }

    final suggestions = <String>[];
    if (savings < 18)      suggestions.add('本月支出偏高，建议减少非必要消费以提升储蓄率');
    if (diversity < 14)    suggestions.add('消费过于集中在单一类别，建议均衡分配');
    if (consistency < 10)  suggestions.add('记账频率较低，坚持每日记账有助于更好地掌握财务状况');
    if (budgetScore < 10)  suggestions.add('多个类别已超出预算，建议调整消费计划');
    if (cashFlow == 0)     suggestions.add('本月暂无收入记录，建议及时补录收入');
    if (goalProgress == 0) suggestions.add('设置定期储蓄目标有助于积累财富');

    final dims = [
      _Dim('储蓄能力', savings,     35, AppTheme.incomeGreen),
      _Dim('消费均衡', diversity,   20, const Color(0xFF00B4D8)),
      _Dim('记账坚持', consistency, 15, AppTheme.primary),
      _Dim('预算执行', budgetScore, 15, AppTheme.warnOrange),
      _Dim('现金流',   cashFlow,    10, const Color(0xFF6C3483)),
      _Dim('目标进度', goalProgress, 5, AppTheme.expenseRed),
    ];

    return _ScoreResult(total: total, level: level, color: color,
        dimensions: dims, suggestions: suggestions.take(3).toList());
  }
}

class _ScoreResult {
  final int total;
  final String level;
  final Color color;
  final List<_Dim> dimensions;
  final List<String> suggestions;
  const _ScoreResult({required this.total, required this.level, required this.color, required this.dimensions, required this.suggestions});
}

class _Dim {
  final String name;
  final int score;
  final int maxScore;
  final Color color;
  const _Dim(this.name, this.score, this.maxScore, this.color);
}

// ── Gauge Card ──────────────────────────────────────────────────────────────

class _GaugeCard extends StatelessWidget {
  final int score;
  final String level;
  final Color color;
  const _GaugeCard({required this.score, required this.level, required this.color});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Container(
      decoration: AppTheme.cardDecoration,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Column(children: [
        Text('${DateFormat('yyyy年MM月').format(now)}  财务健康报告',
            style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
        const SizedBox(height: 20),
        SizedBox(
          width: 220, height: 130,
          child: CustomPaint(
            painter: _GaugePainter(score: score, color: color),
            child: Align(
              alignment: const Alignment(0, 0.8),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text('$score',
                    style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: color)),
                Text(level,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: color)),
              ]),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _LevelChip(label: '待改善', range: '0-49', active: score < 50, color: AppTheme.expenseRed),
            _LevelChip(label: '一般', range: '50-69', active: score >= 50 && score < 70, color: AppTheme.warnOrange),
            _LevelChip(label: '良好', range: '70-84', active: score >= 70 && score < 85, color: const Color(0xFF00B4D8)),
            _LevelChip(label: '优秀', range: '85+', active: score >= 85, color: AppTheme.incomeGreen),
          ],
        ),
      ]),
    );
  }
}

class _LevelChip extends StatelessWidget {
  final String label, range;
  final bool active;
  final Color color;
  const _LevelChip({required this.label, required this.range, required this.active, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: active ? color.withValues(alpha: 0.15) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: active ? color : Colors.transparent),
        ),
        child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: active ? color : AppTheme.textSecondary)),
      ),
      const SizedBox(height: 2),
      Text(range, style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
    ]);
  }
}

class _GaugePainter extends CustomPainter {
  final int score;
  final Color color;
  const _GaugePainter({required this.score, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height * 0.88;
    final radius = size.width * 0.46;
    const strokeW = 14.0;
    const startAngle = pi;
    const sweepAngle = pi;

    // Background arc
    final bgPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: radius),
      startAngle, sweepAngle, false, bgPaint,
    );

    // Score arc
    final fgPaint = Paint()
      ..shader = LinearGradient(
        colors: [color.withValues(alpha: 0.6), color],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: radius))
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: radius),
      startAngle, sweepAngle * score / 100, false, fgPaint,
    );

    // Tick dots at 0, 50, 100
    final dotPaint = Paint()..color = Colors.grey.shade400..style = PaintingStyle.fill;
    for (final frac in [0.0, 0.5, 1.0]) {
      final angle = pi + pi * frac;
      final tx = cx + (radius + 14) * cos(angle);
      final ty = cy + (radius + 14) * sin(angle);
      canvas.drawCircle(Offset(tx, ty), 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_GaugePainter old) => old.score != score;
}

// ── Dimension Card ──────────────────────────────────────────────────────────

class _DimensionCard extends StatelessWidget {
  final List<_Dim> dimensions;
  const _DimensionCard({required this.dimensions});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('各维度得分', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ...dimensions.map((d) => _DimRow(dim: d)),
        ],
      ),
    );
  }
}

class _DimRow extends StatelessWidget {
  final _Dim dim;
  const _DimRow({required this.dim});

  @override
  Widget build(BuildContext context) {
    final ratio = dim.maxScore > 0 ? dim.score / dim.maxScore : 0.0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(children: [
        Row(children: [
          Expanded(child: Text(dim.name, style: const TextStyle(fontSize: 13))),
          Text('${dim.score}/${dim.maxScore}',
              style: TextStyle(fontSize: 12, color: dim.color, fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 4),
        LayoutBuilder(builder: (_, c) => Stack(children: [
          Container(height: 6, decoration: BoxDecoration(
              color: Colors.grey.shade200, borderRadius: BorderRadius.circular(3))),
          Container(height: 6, width: c.maxWidth * ratio,
              decoration: BoxDecoration(color: dim.color, borderRadius: BorderRadius.circular(3))),
        ])),
      ]),
    );
  }
}

// ── Suggestion Card ─────────────────────────────────────────────────────────

class _SuggestionCard extends StatelessWidget {
  final List<String> suggestions;
  const _SuggestionCard({required this.suggestions});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.cardDecoration,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.tips_and_updates_outlined, color: AppTheme.warnOrange, size: 18),
            const SizedBox(width: 6),
            const Text('改善建议', style: AppTheme.headline),
          ]),
          const SizedBox(height: 12),
          ...suggestions.asMap().entries.map((e) => Padding(
                padding: EdgeInsets.only(bottom: e.key < suggestions.length - 1 ? 10 : 0),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    width: 20, height: 20,
                    decoration: BoxDecoration(
                        color: AppTheme.primaryStart.withValues(alpha: 0.1),
                        shape: BoxShape.circle),
                    child: Center(
                      child: Text('${e.key + 1}',
                          style: const TextStyle(fontSize: 11, color: AppTheme.primaryStart, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(e.value, style: const TextStyle(fontSize: 14, height: 1.5))),
                ]),
              )),
        ],
      ),
    );
  }
}

class _MonthNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      '* 评分基于当月数据实时计算，每次记账后自动更新',
      style: TextStyle(fontSize: 11, color: AppTheme.textSecondary),
      textAlign: TextAlign.center,
    );
  }
}

// ── History Chart ────────────────────────────────────────────────────────────

class _HistoryChart extends StatefulWidget {
  const _HistoryChart();
  @override
  State<_HistoryChart> createState() => _HistoryChartState();
}

class _HistoryChartState extends State<_HistoryChart> {
  @override
  void initState() {
    super.initState();
    _saveCurrentMonth();
  }

  void _saveCurrentMonth() {
    final bill   = BillService.to;
    final result = HealthScoreView._calcScore(bill);
    final now    = DateTime.now();
    final h = HealthScoreHistory(
      year: now.year, month: now.month, total: result.total,
      savings: result.dimensions[0].score,
      diversity: result.dimensions[1].score,
      consistency: result.dimensions[2].score,
      budget: result.dimensions[3].score,
      cashFlow: result.dimensions[4].score,
      goalProgress: result.dimensions[5].score,
    );
    StorageService.saveScoreHistory(h);
  }

  @override
  Widget build(BuildContext context) {
    final history = StorageService.scoreHistory;
    if (history.length < 2) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: AppTheme.cardDecoration,
        child: Column(children: [
          const Text('评分历史', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Text('记录 2 个月后显示历史趋势曲线', style: AppTheme.caption),
        ]),
      );
    }
    final spots = history.asMap().entries.map((e) =>
        FlSpot(e.key.toDouble(), e.value.total.toDouble())).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('评分历史', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: LineChart(LineChartData(
            gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (_) => FlLine(color: Colors.grey.shade100, strokeWidth: 1),
              drawVerticalLine: false,
            ),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) {
                  final idx = v.toInt();
                  if (idx < 0 || idx >= history.length) return const SizedBox.shrink();
                  final h = history[idx];
                  return Text('${h.month}月', style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary));
                },
                interval: 1,
              )),
            ),
            borderData: FlBorderData(show: false),
            minY: 0, maxY: 100,
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: AppTheme.primaryStart,
                barWidth: 2.5,
                dotData: const FlDotData(show: true),
                belowBarData: BarAreaData(show: true, color: AppTheme.primaryStart.withValues(alpha: 0.08)),
              ),
            ],
          )),
        ),
      ]),
    );
  }
}
