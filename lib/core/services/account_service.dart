import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/account_record.dart';
import 'storage_service.dart';

/// 纯余额计算（可单测，无副作用）
class AccountBalance {
  static double applied(double balance, double amount, {required bool isExpense}) =>
      isExpense ? balance - amount : balance + amount;

  static double reversed(double balance, double amount, {required bool isExpense}) =>
      isExpense ? balance + amount : balance - amount;
}

class AccountService extends GetxService {
  static AccountService get to => Get.find();

  final RxList<AccountRecord> accounts = <AccountRecord>[].obs;
  final RxDouble totalAssets = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadAccounts();
  }

  void loadAccounts() {
    accounts.value = StorageService.allAccounts;
    _recalc();
  }

  void _recalc() {
    totalAssets.value = accounts.fold(0.0, (s, a) => s + a.balance);
  }

  Future<AccountRecord> addAccount({
    required String name, required String emoji, required double balance}) async {
    final a = AccountRecord()
      ..id = const Uuid().v4()
      ..name = name
      ..emoji = emoji
      ..balance = balance
      ..createdAt = DateTime.now()
      ..sortOrder = accounts.length;
    await StorageService.saveAccount(a);
    loadAccounts();
    return a;
  }

  Future<void> updateAccount(AccountRecord a, {
    String? name, String? emoji, double? balance}) async {
    if (name != null) a.name = name;
    if (emoji != null) a.emoji = emoji;
    if (balance != null) a.balance = balance;
    await StorageService.saveAccount(a);
    loadAccounts();
  }

  Future<void> deleteAccount(String id) async {
    await StorageService.deleteAccount(id);
    loadAccounts();
  }

  /// 记账联动：新增账单时调整余额
  Future<void> applyBill(String accountId, double amount, bool isExpense) async {
    final a = StorageService.accountById(accountId);
    if (a == null) return;
    a.balance = AccountBalance.applied(a.balance, amount, isExpense: isExpense);
    await StorageService.saveAccount(a);
    loadAccounts();
  }

  /// 记账联动：删除账单时冲回余额
  Future<void> reverseBill(String accountId, double amount, bool isExpense) async {
    final a = StorageService.accountById(accountId);
    if (a == null) return;
    a.balance = AccountBalance.reversed(a.balance, amount, isExpense: isExpense);
    await StorageService.saveAccount(a);
    loadAccounts();
  }

  /// 转账（划账）：from 减、to 加
  Future<void> transfer(String fromId, String toId, double amount) async {
    final from = StorageService.accountById(fromId);
    final to   = StorageService.accountById(toId);
    if (from == null || to == null || fromId == toId) return;
    from.balance = AccountBalance.applied(from.balance, amount, isExpense: true);
    to.balance   = AccountBalance.applied(to.balance, amount, isExpense: false);
    await StorageService.saveAccount(from);
    await StorageService.saveAccount(to);
    loadAccounts();
  }
}
