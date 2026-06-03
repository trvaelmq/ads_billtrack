// lib/modules/split/split_history_view.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import 'share_helper.dart';
import 'split_history_store.dart';

class SplitHistoryView extends StatefulWidget {
  const SplitHistoryView({super.key});

  @override
  State<SplitHistoryView> createState() => _SplitHistoryViewState();
}

class _SplitHistoryViewState extends State<SplitHistoryView> {
  List<SplitHistoryEntry> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final l = await SplitHistoryStore.list();
    if (!mounted) return;
    setState(() {
      _items = l;
      _loading = false;
    });
  }

  Future<void> _delete(SplitHistoryEntry e) async {
    await SplitHistoryStore.removeByTime(e.time);
    await _load();
  }

  Future<void> _clearAll() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('清空分摊历史'),
        content: const Text('确定删除全部分摊记录吗？此操作不可恢复。'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('取消')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('清空', style: TextStyle(color: AppTheme.expenseRed)),
          ),
        ],
      ),
    );
    if (ok == true) {
      await SplitHistoryStore.clear();
      await _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('分摊历史',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        actions: [
          if (_items.isNotEmpty)
            IconButton(
              tooltip: '清空',
              icon: const Icon(Icons.delete_sweep_outlined, color: Colors.white),
              onPressed: _clearAll,
            ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _items.isEmpty
              ? const Center(
                  child: Text('暂无分摊记录',
                      style: TextStyle(color: AppTheme.textSecondary)))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) =>
                      _HistoryCard(entry: _items[i], onDelete: () => _delete(_items[i])),
                ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final SplitHistoryEntry entry;
  final VoidCallback onDelete;
  const _HistoryCard({required this.entry, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final timeStr = DateFormat('yyyy-MM-dd HH:mm').format(entry.time);
    return Dismissible(
      key: ValueKey(entry.time.toIso8601String()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: AppTheme.expenseRed, borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(),
      child: Container(
        decoration: AppTheme.cardDecoration,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            title: Text(entry.desc,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '$timeStr · ${entry.members.length} 人 · 已付 ${entry.paidCount}/${entry.members.length}',
                style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
              ),
            ),
            trailing: Text('¥${entry.total.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.expenseRed)),
            children: [
              ...entry.members.map((m) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(children: [
                      Icon(
                        m.paid ? Icons.check_circle : Icons.radio_button_unchecked,
                        size: 18,
                        color: m.paid ? AppTheme.incomeGreen : Colors.grey.shade400,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(m.name, style: const TextStyle(fontSize: 14))),
                      Text('¥${m.amount.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    ]),
                  )),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => shareWithOrigin(
                      context.findRenderObject() as RenderBox?,
                      buildSplitShareText(entry.desc, entry.total, entry.members)),
                  icon: const Icon(Icons.share_outlined, size: 18),
                  label: const Text('重新分享'),
                  style: OutlinedButton.styleFrom(foregroundColor: AppTheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
