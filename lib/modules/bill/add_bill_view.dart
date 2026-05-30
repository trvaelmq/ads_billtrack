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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: Get.back,
        ),
        title: const Text('记一笔',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: Column(children: [
        Builder(builder: (context) => Container(
          height: MediaQuery.of(context).padding.top + 56,
          decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
        )),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 收支切换
                Obx(() => Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(children: [
                    _segmentTab('支出', 'expense', controller.selectedType),
                    _segmentTab('收入', 'income', controller.selectedType),
                  ]),
                )),
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
                _ScaleButton(
                  onTap: controller.save,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [AppTheme.primaryStart, AppTheme.primaryEnd]),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text('保存',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _segmentTab(String label, String value, RxString type) {
    return Obx(() {
      final selected = type.value == value;
      return Expanded(
        child: GestureDetector(
          onTap: () {
            if (type.value != value) controller.setType(value);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(
              color: selected ? AppTheme.accent : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(label,
                  style: TextStyle(
                    color: selected ? Colors.white : AppTheme.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  )),
            ),
          ),
        ),
      );
    });
  }
}

class _ScaleButton extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;
  const _ScaleButton({required this.onTap, required this.child});

  @override
  State<_ScaleButton> createState() => _ScaleButtonState();
}

class _ScaleButtonState extends State<_ScaleButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.96),
      onTapUp: (_) {
        setState(() => _scale = 1.0);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: widget.child,
      ),
    );
  }
}
