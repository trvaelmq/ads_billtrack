import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/bill_service.dart';

class AddBillController extends GetxController {
  final amountController = TextEditingController();
  final noteController   = TextEditingController();

  final selectedType     = 'expense'.obs;
  final selectedCategory = 'food'.obs;
  final selectedDate     = DateTime.now().obs;

  List<BillCategory> get currentCategories => selectedType.value == 'expense'
      ? AppConstants.expenseCategories
      : AppConstants.incomeCategories;

  void setType(String t) {
    selectedType.value = t;
    selectedCategory.value = currentCategories.first.id;
  }

  Future<void> pickDate(BuildContext context) async {
    final d = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (d != null) selectedDate.value = d;
  }

  Future<void> save() async {
    final amountStr = amountController.text.trim();
    if (amountStr.isEmpty) { Get.snackbar('提示', '请输入金额'); return; }
    final amount = double.tryParse(amountStr);
    if (amount == null || amount <= 0) { Get.snackbar('提示', '金额格式不正确'); return; }

    await BillService.to.addBill(
      amount:   amount,
      type:     selectedType.value,
      category: selectedCategory.value,
      date:     selectedDate.value,
      note:     noteController.text.trim(),
    );
    Get.back();
  }

  @override
  void onClose() {
    amountController.dispose();
    noteController.dispose();
    super.onClose();
  }
}
