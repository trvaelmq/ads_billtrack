import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/recurring_service.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/recurring_rule.dart';

class RecurringEditView extends StatefulWidget {
  const RecurringEditView({super.key});
  @override
  State<RecurringEditView> createState() => _RecurringEditViewState();
}

class _RecurringEditViewState extends State<RecurringEditView> {
  final _titleCtrl   = TextEditingController();
  final _amountCtrl  = TextEditingController();
  final _noteCtrl    = TextEditingController();

  bool        _isExpense  = true;
  String      _frequency  = 'monthly';
  String      _category   = 'food';
  DateTime    _startDate  = DateTime.now();
  RecurringRule? _editing;

  @override
  void initState() {
    super.initState();
    _editing = Get.arguments as RecurringRule?;
    if (_editing != null) {
      _titleCtrl.text  = _editing!.title;
      _amountCtrl.text = _editing!.amount.toStringAsFixed(0);
      _noteCtrl.text   = _editing!.note;
      _isExpense       = _editing!.isExpense;
      _frequency       = _editing!.frequency;
      _category        = _editing!.category;
      _startDate       = _editing!.nextDueDate;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose(); _amountCtrl.dispose(); _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_titleCtrl.text.trim().isEmpty) {
      Get.snackbar('提示', '请输入标题', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final amount = double.tryParse(_amountCtrl.text.trim());
    if (amount == null || amount <= 0) {
      Get.snackbar('提示', '请输入有效金额', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (_editing != null) {
      _editing!
        ..title      = _titleCtrl.text.trim()
        ..amount     = amount
        ..category   = _category
        ..isExpense  = _isExpense
        ..frequency  = _frequency
        ..nextDueDate = _startDate
        ..note       = _noteCtrl.text.trim();
      await RecurringService.to.updateRule(_editing!);
    } else {
      await RecurringService.to.addRule(
        title:     _titleCtrl.text.trim(),
        amount:    amount,
        category:  _category,
        isExpense: _isExpense,
        frequency: _frequency,
        startDate: _startDate,
        note:      _noteCtrl.text.trim(),
      );
    }
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final cats = _isExpense ? AppConstants.expenseCategories : AppConstants.incomeCategories;
    if (!cats.any((c) => c.id == _category)) _category = cats.first.id;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        title: Text(_editing == null ? '添加定期账单' : '编辑定期账单',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text('保存', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        // 收/支 切换
        Container(
          decoration: AppTheme.cardDecoration,
          padding: const EdgeInsets.all(4),
          child: Row(children: [
            Expanded(child: GestureDetector(
              onTap: () => setState(() { _isExpense = true; _category = AppConstants.expenseCategories.first.id; }),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _isExpense ? AppTheme.expenseRed : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('支出', textAlign: TextAlign.center,
                    style: TextStyle(color: _isExpense ? Colors.white : AppTheme.textSecondary, fontWeight: FontWeight.w600)),
              ),
            )),
            Expanded(child: GestureDetector(
              onTap: () => setState(() { _isExpense = false; _category = AppConstants.incomeCategories.first.id; }),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: !_isExpense ? AppTheme.incomeGreen : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('收入', textAlign: TextAlign.center,
                    style: TextStyle(color: !_isExpense ? Colors.white : AppTheme.textSecondary, fontWeight: FontWeight.w600)),
              ),
            )),
          ]),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _titleCtrl,
          decoration: const InputDecoration(labelText: '标题（如：房租、工资）'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _amountCtrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: '金额', prefixText: '¥'),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: _frequency,
          decoration: const InputDecoration(labelText: '频率'),
          items: const [
            DropdownMenuItem(value: 'daily',   child: Text('每天')),
            DropdownMenuItem(value: 'weekly',  child: Text('每周')),
            DropdownMenuItem(value: 'monthly', child: Text('每月')),
            DropdownMenuItem(value: 'yearly',  child: Text('每年')),
          ],
          onChanged: (v) => setState(() => _frequency = v!),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: _category,
          decoration: const InputDecoration(labelText: '分类'),
          items: cats.map((c) => DropdownMenuItem(
            value: c.id,
            child: Text('${c.emoji} ${c.label}'),
          )).toList(),
          onChanged: (v) => setState(() => _category = v!),
        ),
        const SizedBox(height: 12),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('首次到期日'),
          subtitle: Text(DateFormat('yyyy年MM月dd日').format(_startDate)),
          trailing: const Icon(Icons.calendar_today_outlined, color: AppTheme.primary),
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: _startDate,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );
            if (picked != null) setState(() => _startDate = picked);
          },
        ),
        const Divider(),
        const SizedBox(height: 8),
        TextField(
          controller: _noteCtrl,
          decoration: const InputDecoration(labelText: '备注（可选）'),
        ),
      ]),
    );
  }
}
