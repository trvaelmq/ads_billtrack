import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'calendar_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/bill_service.dart';
import '../../widgets/staggered_list_item.dart';

class DayDetailView extends StatelessWidget {
  final DateTime date;
  const DayDetailView({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CalendarController>();
    final bills = controller.billsForDay(date);
    final dateStr = DateFormat('M月d日').format(date);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Colors.white, size: 20),
          onPressed: Get.back,
        ),
        title: Text(dateStr,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 17)),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).padding.top + 60,
            decoration:
                const BoxDecoration(gradient: AppTheme.primaryGradient),
          ),
          Expanded(
            child: bills.isEmpty
                ? Center(
                    child: Text('当天暂无账单',
                        style: AppTheme.body
                            .copyWith(color: AppTheme.textSecondary)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    itemCount: bills.length,
                    itemBuilder: (context, index) {
                      final b = bills[index];
                      return StaggeredListItem(
                        index: index,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: AppTheme.cardDecoration,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            leading: Text(
                              BillService.categoryEmoji(b.category),
                              style: const TextStyle(fontSize: 24),
                            ),
                            title: Text(
                              BillService.categoryLabel(b.category),
                              style: AppTheme.body
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            subtitle: b.note.isNotEmpty
                                ? Text(b.note, style: AppTheme.caption)
                                : null,
                            trailing: Text(
                              '${b.isExpense ? '-' : '+'}¥${b.amount.toStringAsFixed(2)}',
                              style: AppTheme.headline.copyWith(
                                color: b.isExpense
                                    ? AppTheme.expenseRed
                                    : AppTheme.incomeGreen,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
