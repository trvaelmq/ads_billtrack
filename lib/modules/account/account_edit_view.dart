import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/account_service.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/account_record.dart';

class AccountEditView extends StatefulWidget {
  final AccountRecord? account;
  const AccountEditView({super.key, this.account});

  @override
  State<AccountEditView> createState() => _AccountEditViewState();
}

class _AccountEditViewState extends State<AccountEditView> {
  static const _emojis = ['🏦','💳','💰','📱','💵','🪙','🏧','💴','🐷','🧧'];
  late final TextEditingController _name;
  late final TextEditingController _balance;
  late String _emoji;

  bool get _isEdit => widget.account != null;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.account?.name ?? '');
    _balance = TextEditingController(
        text: widget.account != null ? widget.account!.balance.toStringAsFixed(2) : '');
    _emoji = widget.account?.emoji ?? _emojis.first;
  }

  @override
  void dispose() { _name.dispose(); _balance.dispose(); super.dispose(); }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) { Get.snackbar('提示', '请输入账户名'); return; }
    final bal = double.tryParse(_balance.text.trim()) ?? 0;
    final s = AccountService.to;
    if (_isEdit) {
      await s.updateAccount(widget.account!, name: name, emoji: _emoji, balance: bal);
    } else {
      await s.addAccount(name: name, emoji: _emoji, balance: bal);
    }
    Get.back();
  }

  Future<void> _delete() async {
    final ok = await Get.dialog<bool>(AlertDialog(
      title: const Text('删除账户'),
      content: const Text('确定删除该账户？不会删除已记的账单。'),
      actions: [
        TextButton(onPressed: () => Get.back(result: false), child: const Text('取消')),
        TextButton(onPressed: () => Get.back(result: true), child: const Text('删除')),
      ],
    ));
    if (ok == true) {
      await AccountService.to.deleteAccount(widget.account!.id);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        elevation: 0,
        title: Text(_isEdit ? '编辑账户' : '新增账户',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Get.back()),
        actions: [
          if (_isEdit)
            IconButton(icon: const Icon(Icons.delete_outline, color: Colors.white),
                onPressed: _delete),
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text('图标', style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
        const SizedBox(height: 8),
        Wrap(spacing: 10, runSpacing: 10, children: [
          for (final e in _emojis)
            GestureDetector(
              onTap: () => setState(() => _emoji = e),
              child: Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: _emoji == e ? AppTheme.primary.withValues(alpha: 0.18) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _emoji == e ? AppTheme.primary : AppTheme.divider, width: 1),
                ),
                child: Center(child: Text(e, style: const TextStyle(fontSize: 22))),
              ),
            ),
        ]),
        const SizedBox(height: 20),
        TextField(controller: _name,
            decoration: InputDecoration(labelText: '账户名',
                hintText: '如：招商银行 / 支付宝 / 现金',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
        const SizedBox(height: 16),
        TextField(controller: _balance,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: _isEdit ? '当前余额' : '初始余额',
                suffixText: '元',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
        const SizedBox(height: 28),
        SizedBox(height: 52, child: ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary, foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
          child: const Text('保存', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        )),
      ]),
    );
  }
}
