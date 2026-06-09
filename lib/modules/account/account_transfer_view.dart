import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/account_service.dart';
import '../../core/theme/app_theme.dart';

class AccountTransferView extends StatefulWidget {
  const AccountTransferView({super.key});

  @override
  State<AccountTransferView> createState() => _AccountTransferViewState();
}

class _AccountTransferViewState extends State<AccountTransferView> {
  String? _fromId;
  String? _toId;
  final _amt = TextEditingController();

  @override
  void initState() {
    super.initState();
    final accts = AccountService.to.accounts;
    if (accts.isNotEmpty) _fromId = accts.first.id;
    if (accts.length > 1) _toId = accts[1].id;
  }

  @override
  void dispose() { _amt.dispose(); super.dispose(); }

  Future<void> _submit() async {
    final amt = double.tryParse(_amt.text.trim()) ?? 0;
    if (_fromId == null || _toId == null) { Get.snackbar('提示', '请选择转出/转入账户'); return; }
    if (_fromId == _toId) { Get.snackbar('提示', '转出与转入账户不能相同'); return; }
    if (amt <= 0) { Get.snackbar('提示', '请输入有效金额'); return; }
    await AccountService.to.transfer(_fromId!, _toId!, amt);
    Get.back();
    Get.snackbar('成功', '转账完成', snackPosition: SnackPosition.BOTTOM);
  }

  Widget _picker(String label, String? val, ValueChanged<String?> onChange) {
    final accts = AccountService.to.accounts;
    return DropdownButtonFormField<String>(
      value: val,
      isExpanded: true,
      decoration: InputDecoration(labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      items: [
        for (final a in accts)
          DropdownMenuItem(value: a.id,
              child: Text('${a.emoji} ${a.name}（¥${a.balance.toStringAsFixed(2)}）',
                  overflow: TextOverflow.ellipsis)),
      ],
      onChanged: onChange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        elevation: 0,
        title: const Text('转账',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Get.back()),
      ),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        _picker('转出账户', _fromId, (v) => setState(() => _fromId = v)),
        const SizedBox(height: 16),
        _picker('转入账户', _toId, (v) => setState(() => _toId = v)),
        const SizedBox(height: 16),
        TextField(controller: _amt,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: '转账金额', suffixText: '元',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
        const SizedBox(height: 28),
        SizedBox(height: 52, child: ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary, foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
          child: const Text('确认转账', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        )),
      ]),
    );
  }
}
