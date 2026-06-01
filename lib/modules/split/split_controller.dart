// lib/modules/split/split_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplitMember {
  final String name;
  final double amount;
  bool paid;
  SplitMember({required this.name, required this.amount, this.paid = false});
}

class SplitController extends GetxController {
  final totalAmount = 0.0.obs;
  final description = ''.obs;
  final memberCount = 2.obs;
  final isCustom    = false.obs;
  final members     = <SplitMember>[].obs;

  void init(double amount, String desc) {
    totalAmount.value  = amount;
    description.value  = desc;
    memberCount.value  = 2;
    isCustom.value     = false;
    _rebuildMembers();
  }

  void setMemberCount(int count) {
    memberCount.value = count.clamp(2, 10);
    _rebuildMembers();
  }

  void toggleCustom(bool val) {
    isCustom.value = val;
    _rebuildMembers();
  }

  void setCustomAmount(int index, double amount) {
    if (index >= 0 && index < members.length) {
      members[index] = SplitMember(name: members[index].name, amount: amount, paid: members[index].paid);
      members.refresh();
    }
  }

  void setMemberName(int index, String name) {
    if (index >= 0 && index < members.length) {
      members[index] = SplitMember(name: name, amount: members[index].amount, paid: members[index].paid);
      members.refresh();
    }
  }

  void togglePaid(int index) {
    if (index >= 0 && index < members.length) {
      members[index] = SplitMember(
        name: members[index].name,
        amount: members[index].amount,
        paid: !members[index].paid,
      );
      members.refresh();
      _persist();
    }
  }

  void _rebuildMembers() {
    final count  = memberCount.value;
    final each   = isCustom.value ? 0.0 : (totalAmount.value / count);
    members.assignAll(List.generate(count, (i) =>
        SplitMember(name: '成员${i + 1}', amount: each)));
  }

  String get shareText {
    final buf = StringBuffer();
    buf.writeln('📋 账单分摊：${description.value}');
    buf.writeln('💰 总金额：¥${totalAmount.value.toStringAsFixed(2)}');
    buf.writeln('👥 共 ${members.length} 人');
    buf.writeln('---');
    for (final m in members) {
      buf.writeln('${m.name}：¥${m.amount.toStringAsFixed(2)}');
    }
    return buf.toString();
  }

  void _persist() async {
    final prefs = await SharedPreferences.getInstance();
    final raw   = prefs.getString('split_history');
    final list  = raw != null ? (jsonDecode(raw) as List) : [];
    list.insert(0, {
      'desc': description.value,
      'total': totalAmount.value,
      'members': members.map((m) => {'name': m.name, 'amount': m.amount, 'paid': m.paid}).toList(),
      'time': DateTime.now().toIso8601String(),
    });
    if (list.length > 20) list.removeLast();
    await prefs.setString('split_history', jsonEncode(list));
  }
}
