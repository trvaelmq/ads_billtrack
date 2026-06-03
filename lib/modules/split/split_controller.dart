// lib/modules/split/split_controller.dart
import 'package:get/get.dart';
import 'split_history_store.dart';

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

  void setTotal(double amount) {
    totalAmount.value = amount < 0 ? 0 : amount;
    if (!isCustom.value) _rebuildMembers();
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
    }
  }

  void _rebuildMembers() {
    final count = memberCount.value;
    final each  = isCustom.value ? 0.0 : (totalAmount.value / count);
    final prev  = members.toList(); // 保留已有成员的名字与已付状态
    members.assignAll(List.generate(count, (i) => SplitMember(
          name: i < prev.length ? prev[i].name : '成员${i + 1}',
          amount: each,
          paid: i < prev.length ? prev[i].paid : false,
        )));
  }

  String get shareText =>
      buildSplitShareText(description.value, totalAmount.value, members);

  Future<void> saveToHistory() async {
    await SplitHistoryStore.add(SplitHistoryEntry(
      desc: description.value,
      total: totalAmount.value,
      members: members.toList(),
      time: DateTime.now(),
    ));
  }
}
