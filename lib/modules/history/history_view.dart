import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/risk/risk_models.dart';
import '../../core/services/storage_service.dart';
import '../../core/theme/app_theme.dart';
import 'history_controller.dart';
import '../../widgets/staggered_list_item.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () {
            debugPrint('[HistoryView] back pressed: 直接返回，不再弹插屏');
            Get.back();
          },
        ),
        title: const Text(
          '统计历史',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Obx(() {
        final records = controller.records;
        return Column(
          children: [
            Container(
              height: MediaQuery.of(context).padding.top + 56,
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
              ),
            ),
            _UserCard(recordCount: records.length),
            const Divider(height: 1),
            Expanded(
              child: controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.hasError.value
                      ? _ErrorState(onRetry: controller.loadRecords)
                      : RefreshIndicator(
                          onRefresh: controller.loadRecords,
                          child: records.isEmpty
                              ? ListView(
                                  children: const [
                                    SizedBox(height: 120),
                                    Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('📺', style: TextStyle(fontSize: 60)),
                                          SizedBox(height: 12),
                                          Text(
                                            '还没有广告记录',
                                            style: TextStyle(color: AppTheme.textSecondary),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                                  itemCount: records.length,
                                  itemBuilder: (_, i) => StaggeredListItem(
                                    index: i,
                                    child: _RecordItem(record: records[i]),
                                  ),
                                ),
                        ),
            ),
          ],
        );
      }),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final Future<void> Function() onRetry;
  const _ErrorState({required this.onRetry});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('⚠️', style: TextStyle(fontSize: 60)),
            const SizedBox(height: 12),
            const Text('加载失败，请重试', style: TextStyle(color: AppTheme.textSecondary)),
            const SizedBox(height: 12),
            TextButton(onPressed: onRetry, child: const Text('重新加载')),
          ],
        ),
      );
}

// ── 用户信息卡 ─────────────────────────────────────────────────────
class _UserCard extends StatelessWidget {
  final int recordCount;
  const _UserCard({required this.recordCount});

  // 卡片 ID：优先用后端下发的 accountId，未登录/未下发时回退本地生成的 userId
  String get _accountId {
    final accountId = AuthService.to.userInfo.value?.accountId;
    if (accountId != null && accountId.isNotEmpty) return accountId;
    return StorageService.userId;
  }

  // 邀请码；没有邀请码时回退昵称/用户名/「用户」（不再展示手机号）
  String get _displayName {
    final user = AuthService.to.userInfo.value;
    if (user == null) return '用户';
    if (user.invitationCode != null && user.invitationCode!.isNotEmpty) {
      return '邀请码 ${user.invitationCode}';
    }
    if (user.nickname.isNotEmpty) return user.nickname;
    if (user.username.isNotEmpty) return user.username;
    return '用户';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primary, AppTheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // 左侧：图标 + 应用名
          Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/app_icon.png',
                    width: 56,
                    height: 56,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  '智探眼',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          const Spacer(),
          // 右侧：ID + 昵称 + 记录数
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'ID: $_accountId',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _displayName,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '记录: $recordCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecordItem extends StatelessWidget {
  final AdViewRecord record;
  const _RecordItem({required this.record});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            const Text('🎬', style: TextStyle(fontSize: 28)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.watchTime,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${record.ip}  ${record.deviceId}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
