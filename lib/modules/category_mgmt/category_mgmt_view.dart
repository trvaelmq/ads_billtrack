import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'category_mgmt_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';

class CategoryMgmtView extends GetView<CategoryMgmtController> {
  const CategoryMgmtView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Colors.white, size: 20),
          onPressed: Get.back,
        ),
        title: const Text('分类管理',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 17)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => _showAddSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).padding.top + 60,
            decoration:
                const BoxDecoration(gradient: AppTheme.primaryGradient),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('系统分类'),
                  const SizedBox(height: 8),
                  _builtinSection(),
                  const SizedBox(height: 20),
                  _sectionTitle('我的分类'),
                  const SizedBox(height: 8),
                  Obx(() => _customSection()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String t) => Text(t,
      style: AppTheme.caption.copyWith(fontWeight: FontWeight.w600));

  Widget _builtinSection() {
    final all = AppConstants.allCategories;
    return Container(
      decoration: AppTheme.cardDecoration,
      child: Column(
        children: all.asMap().entries.map((entry) {
          final cat = entry.value;
          return Column(children: [
            ListTile(
              leading: Text(cat.emoji,
                  style: const TextStyle(fontSize: 22)),
              title: Text(cat.label, style: AppTheme.body),
              trailing: Text(
                  cat.isExpense ? '支出' : '收入', style: AppTheme.caption),
            ),
            if (entry.key < all.length - 1)
              const Divider(height: 1, indent: 56),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _customSection() {
    if (controller.customCategories.isEmpty) {
      return Container(
        decoration: AppTheme.cardDecoration,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text('点击右上角 + 添加自定义分类',
              style: AppTheme.caption),
        ),
      );
    }
    final cats = controller.customCategories;
    return Container(
      decoration: AppTheme.cardDecoration,
      child: Column(
        children: cats.asMap().entries.map((entry) {
          final cat = entry.value;
          return Column(children: [
            ListTile(
              leading: Text(cat['emoji'] as String,
                  style: const TextStyle(fontSize: 22)),
              title: Text(cat['name'] as String, style: AppTheme.body),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  (cat['isExpense'] as bool? ?? true) ? '支出' : '收入',
                  style: AppTheme.caption,
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () =>
                      controller.deleteCategory(cat['id'] as String),
                  child: const Icon(Icons.remove_circle_outline,
                      color: AppTheme.expenseRed, size: 20),
                ),
              ]),
            ),
            if (entry.key < cats.length - 1)
              const Divider(height: 1, indent: 56),
          ]);
        }).toList(),
      ),
    );
  }

  void _showAddSheet(BuildContext context) {
    final nameCtrl = TextEditingController();
    final selectedEmoji =
        CategoryMgmtController.emojiOptions.first.obs;
    final isExpense = true.obs;

    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.fromLTRB(
            20, 12, 20, MediaQuery.of(context).viewInsets.bottom + 32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36, height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('新增分类', style: AppTheme.headline),
              const SizedBox(height: 16),
              Row(children: [
                    _typeChip('支出', true, isExpense),
                    const SizedBox(width: 8),
                    _typeChip('收入', false, isExpense),
                  ]),
              const SizedBox(height: 12),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  hintText: '分类名称（如：宠物）',
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                ),
                style: AppTheme.body,
              ),
              const SizedBox(height: 12),
              Text('选择图标', style: AppTheme.caption),
              const SizedBox(height: 8),
              Obx(() => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: CategoryMgmtController.emojiOptions
                        .map((e) {
                      final sel = selectedEmoji.value == e;
                      return GestureDetector(
                        onTap: () => selectedEmoji.value = e,
                        child: Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(
                            color: sel
                                ? AppTheme.accent.withValues(alpha: 0.15)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: sel
                                ? Border.all(color: AppTheme.accent)
                                : null,
                          ),
                          child: Center(
                              child: Text(e,
                                  style: const TextStyle(fontSize: 20))),
                        ),
                      );
                    }).toList(),
                  )),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: AppTheme.accent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  onPressed: () async {
                    await Get.find<CategoryMgmtController>().addCategory(
                      name: nameCtrl.text,
                      emoji: selectedEmoji.value,
                      isExpense: isExpense.value,
                    );
                    Get.back();
                  },
                  child: const Text('保存',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _typeChip(String label, bool value, RxBool state) {
    return Obx(() => GestureDetector(
          onTap: () => state.value = value,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: state.value == value
                  ? AppTheme.accent
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: state.value == value
                    ? Colors.white
                    : AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ));
  }
}
