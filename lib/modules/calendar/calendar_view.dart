import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'calendar_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../router/app_pages.dart';

class CalendarView extends GetView<CalendarController> {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Obx(() => _buildHeader()),
          const SizedBox(height: 8),
          _buildWeekHeader(),
          const Divider(height: 1, color: AppTheme.divider),
          Expanded(child: Obx(() => _buildGrid(context))),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
        onPressed: Get.back,
      ),
      title: Obx(() => Text(controller.monthLabel,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17))),
      actions: [
        IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () => controller.changeMonth(-1),
        ),
        Obx(() => IconButton(
              icon: Icon(Icons.chevron_right,
                  color: controller.canGoForward
                      ? Colors.white
                      : Colors.white30),
              onPressed:
                  controller.canGoForward ? () => controller.changeMonth(1) : null,
            )),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
      decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _headerStat('支出', controller.totalExpense, AppTheme.expenseRed),
          Container(width: 1, height: 28, color: Colors.white24),
          _headerStat('收入', controller.totalIncome, Colors.white),
          Container(width: 1, height: 28, color: Colors.white24),
          _headerStat(
            '结余',
            controller.totalIncome - controller.totalExpense,
            (controller.totalIncome - controller.totalExpense) >= 0
                ? AppTheme.incomeGreen
                : AppTheme.expenseRed,
          ),
        ],
      ),
    );
  }

  Widget _headerStat(String label, double amount, Color color) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          '¥${amount.abs().toStringAsFixed(0)}',
          style: TextStyle(
              color: color, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildWeekHeader() {
    const days = ['日', '一', '二', '三', '四', '五', '六'];
    return Container(
      color: AppTheme.cardColor,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: days
            .map((d) => Expanded(
                  child: Center(
                    child: Text(d,
                        style: AppTheme.caption
                            .copyWith(fontWeight: FontWeight.w600)),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    final m = controller.displayMonth.value;
    final daysInMonth = DateTime(m.year, m.month + 1, 0).day;
    final startWeekday = DateTime(m.year, m.month, 1).weekday % 7;
    final rows = ((startWeekday + daysInMonth) / 7).ceil();
    final dailyNet = controller.dailyNetAmounts;
    final now = DateTime.now();

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.9,
        crossAxisSpacing: 2,
        mainAxisSpacing: 4,
      ),
      itemCount: rows * 7,
      itemBuilder: (context, index) {
        final dayNumber = index - startWeekday + 1;
        if (dayNumber < 1 || dayNumber > daysInMonth) {
          return const SizedBox.shrink();
        }
        final date = DateTime(m.year, m.month, dayNumber);
        final isToday = date.year == now.year &&
            date.month == now.month &&
            date.day == now.day;
        final net = dailyNet[dayNumber];

        return GestureDetector(
          onTap: () => Get.toNamed(Routes.dayDetail, arguments: date),
          child: Container(
            decoration: isToday
                ? BoxDecoration(
                    color: AppTheme.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  )
                : null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$dayNumber',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:
                        isToday ? FontWeight.bold : FontWeight.normal,
                    color: isToday ? AppTheme.accent : AppTheme.textPrimary,
                  ),
                ),
                if (net != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    net >= 0
                        ? '+${net.toStringAsFixed(0)}'
                        : net.toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 9,
                      color: net >= 0
                          ? AppTheme.incomeGreen
                          : AppTheme.expenseRed,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
