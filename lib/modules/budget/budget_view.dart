import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/bill_service.dart';
import '../../core/theme/app_theme.dart';
import 'budget_controller.dart';

class BudgetView extends GetView<BudgetController> {
  const BudgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final bill = BillService.to;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        elevation: 0,
        title: const Text('预算管理', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final expenses  = bill.expenseByCategory;
        final budgets   = controller.budgets;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('点击任意类别设置月度预算', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
            const SizedBox(height: 12),
            ...AppConstants.expenseCategories.map((cat) {
              final spent  = expenses[cat.id] ?? 0;
              final budget = budgets[cat.id] ?? 0;
              final over   = budget > 0 && spent > budget;
              final ratio  = budget > 0 ? (spent / budget).clamp(0.0, 1.0) : 0.0;
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () => _showSetDialog(context, cat, budget),
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(cat.emoji, style: const TextStyle(fontSize: 24)),
                            const SizedBox(width: 10),
                            Text(cat.label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            const Spacer(),
                            if (over)
                              const Icon(Icons.warning_amber_rounded, color: AppTheme.expenseRed, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              budget > 0 ? '¥${spent.toStringAsFixed(0)} / ¥${budget.toStringAsFixed(0)}' : '未设预算',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: over ? AppTheme.expenseRed : AppTheme.textSecondary,
                                  fontWeight: over ? FontWeight.bold : FontWeight.normal),
                            ),
                          ],
                        ),
                        if (budget > 0) ...[
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: ratio,
                              minHeight: 8,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation<Color>(over ? AppTheme.expenseRed : cat.color),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      }),
    );
  }

  void _showSetDialog(BuildContext context, BillCategory cat, double current) {
    final tc = TextEditingController(text: current > 0 ? current.toStringAsFixed(0) : '');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('${cat.emoji} ${cat.label} 月度预算'),
        content: TextField(
          controller: tc,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(prefixText: '¥ ', hintText: '0 = 不限制'),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('取消')),
          TextButton(
            onPressed: () async {
              if (!await AuthService.to.ensureLoggedIn(message: '设置预算需要登录，是否前往登录？')) return;
              final v = double.tryParse(tc.text.trim()) ?? 0;
              controller.setBudget(cat.id, v);
              Get.back();
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }
}
