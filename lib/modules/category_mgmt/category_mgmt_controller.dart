import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../core/services/storage_service.dart';
import '../../core/services/bill_service.dart';

class CategoryMgmtController extends GetxController {
  final RxList<Map<String, dynamic>> customCategories =
      <Map<String, dynamic>>[].obs;

  static const List<String> emojiOptions = [
    '🐱','🐶','🐰','🌈','⭐','🎵','🏋️','🎨','🧘','🚀',
    '🌿','🍕','☕','🛒','💻','📱','✈️','🏖️','🎯','🎁',
    '🐾','💐','🧸','🎸','🚴','🏊','🎓','💼','🏠','🌙',
  ];

  @override
  void onInit() {
    super.onInit();
    customCategories.value = StorageService.customCategories;
  }

  Future<void> addCategory({
    required String name,
    required String emoji,
    required bool isExpense,
  }) async {
    if (name.trim().isEmpty) return;
    final id = 'custom_${const Uuid().v4().replaceAll('-', '').substring(0, 8)}';
    final updated = [
      ...customCategories,
      {'id': id, 'name': name.trim(), 'emoji': emoji, 'isExpense': isExpense},
    ];
    await StorageService.saveCustomCategories(updated);
    customCategories.value = updated;
    BillService.to.reloadCustomCategories();
  }

  Future<void> deleteCategory(String id) async {
    final updated =
        customCategories.where((c) => c['id'] != id).toList();
    await StorageService.saveCustomCategories(updated);
    customCategories.value = updated;
    BillService.to.reloadCustomCategories();
  }
}
