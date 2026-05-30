import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import 'add_bill_controller.dart';

class AddBillView extends GetView<AddBillController> {
  const AddBillView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('记一笔')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 收支切换
            Obx(() => Row(children: [
              Expanded(child: _TypeBtn(label: '支出', selected: controller.selectedType.value == 'expense',
                  color: AppTheme.expenseRed, onTap: () => controller.setType('expense'))),
              const SizedBox(width: 12),
              Expanded(child: _TypeBtn(label: '收入', selected: controller.selectedType.value == 'income',
                  color: AppTheme.incomeGreen, onTap: () => controller.setType('income'))),
            ])),
            const SizedBox(height: 20),
            // 金额输入
            TextField(
              controller: controller.amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                prefixText: '¥ ',
                prefixStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                hintText: '0.00',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            // 快捷金额
            Row(
              children: AppConstants.quickAmounts.map((a) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ActionChip(
                  label: Text('¥${a.toInt()}'),
                  onPressed: () => controller.amountController.text = a.toStringAsFixed(2),
                ),
              )).toList(),
            ),
            const SizedBox(height: 20),
            // 分类选择
            const Text('分类', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textSecondary)),
            const SizedBox(height: 10),
            Obx(() => Wrap(
              spacing: 8, runSpacing: 8,
              children: controller.currentCategories.map((cat) {
                final selected = controller.selectedCategory.value == cat.id;
                return GestureDetector(
                  onTap: () => controller.selectedCategory.value = cat.id,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? cat.color : cat.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: selected ? cat.color : Colors.transparent),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(cat.emoji, style: const TextStyle(fontSize: 16)),
                        const SizedBox(width: 4),
                        Text(cat.label,
                            style: TextStyle(
                                color: selected ? Colors.white : cat.color,
                                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                                fontSize: 13)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )),
            const SizedBox(height: 20),
            // 日期选择
            Obx(() => InkWell(
              onTap: () => controller.pickDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 18, color: AppTheme.textSecondary),
                    const SizedBox(width: 10),
                    Text(DateFormat('yyyy年MM月dd日').format(controller.selectedDate.value),
                        style: const TextStyle(fontSize: 15)),
                    const Spacer(),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            )),
            const SizedBox(height: 16),
            // 备注
            TextField(
              controller: controller.noteController,
              decoration: InputDecoration(
                hintText: '添加备注（选填）',
                prefixIcon: const Icon(Icons.notes_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity, height: 52,
              child: ElevatedButton(
                onPressed: controller.save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('保存', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeBtn extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;
  const _TypeBtn({required this.label, required this.selected, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? color : color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: selected ? Colors.white : color)),
        ),
      ),
    );
  }
}
