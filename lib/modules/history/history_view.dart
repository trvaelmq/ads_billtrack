import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/services/storage_service.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/ad_record.dart';
import 'history_controller.dart';
import '../../widgets/staggered_list_item.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  static const _encouragements = [
    '太棒了！坚持就是胜利🏆',
    '记账达人，继续加油💪',
    '金币越来越多了🪙',
    '积少成多，财富积累中📈',
    '又多看了一个广告，不错👍',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('签到记录',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: Obx(() {
        final records = controller.records;
        return Column(children: [
          Container(
            height: MediaQuery.of(context).padding.top + 56,
            decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
          ),
          _UserCard(recordCount: records.length),
          const Divider(height: 1),
          Expanded(
            child: records.isEmpty
                ? const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text('📺', style: TextStyle(fontSize: 60)),
                    SizedBox(height: 12),
                    Text('还没有广告记录', style: TextStyle(color: AppTheme.textSecondary)),
                  ]))
                : ListView.builder(
                    itemCount: records.length,
                    itemBuilder: (_, i) => StaggeredListItem(
                      index: i,
                      child: _RecordItem(
                        record: records[i],
                        onTap: () => _showDetail(context, records[i]),
                      ),
                    ),
                  ),
          ),
        ]);
      }),
    );
  }

  void _showDetail(BuildContext context, AdRecord r) {
    final msg = _encouragements[r.watchedAt.millisecond % _encouragements.length];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Container(
        width: context.width,
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4,
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 24),
            Text(r.adTypeEmoji, style: const TextStyle(fontSize: 60)),
            const SizedBox(height: 12),
            Text(r.adTypeLabel,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(r.watchedAt),
                style: const TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.coinGold.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text('+${r.coinsEarned}🪙',
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.coinGold)),
            ),
            const SizedBox(height: 16),
            Text(msg, style: const TextStyle(color: AppTheme.textSecondary)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ── 用户信息卡 ─────────────────────────────────────────────────────
class _UserCard extends StatelessWidget {
  final int recordCount;
  const _UserCard({required this.recordCount});

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
                width: 56, height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(child: Image.asset('assets/app_icon.png', width: 56, height: 56)),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('智探眼', style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
          const Spacer(),
          // 右侧：ID + 昵称 + 记录数
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('ID: ${StorageService.userId}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 4),
              Text(StorageService.nickname,
                  style: const TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('记录: $recordCount',
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecordItem extends StatelessWidget {
  final AdRecord record;
  final VoidCallback onTap;
  const _RecordItem({required this.record, required this.onTap});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Text(record.adTypeEmoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(record.adTypeLabel,
                    //     style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(record.watchedAt),
                        style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Text('+${record.coinsEarned}🪙',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.coinGold, fontSize: 15)),
            ],
          ),
        ),
      );
}
