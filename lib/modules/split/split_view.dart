import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SplitView extends StatefulWidget {
  const SplitView({super.key});

  @override
  State<SplitView> createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  final _totalCtrl = TextEditingController();
  int _people = 2;
  bool _advancedMode = false;
  final List<TextEditingController> _ratioCtrl = List.generate(10, (_) => TextEditingController(text: '1'));

  double get _total => double.tryParse(_totalCtrl.text) ?? 0;

  @override
  void dispose() {
    _totalCtrl.dispose();
    for (final c in _ratioCtrl) { c.dispose(); }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        elevation: 0,
        title: const Text('AA 分摊计算器', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 总金额
            TextField(
              controller: _totalCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: '总金额',
                prefixText: '¥ ',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 24),
            // 人数
            Row(
              children: [
                const Text('人数', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(
                  onPressed: _people > 2 ? () => setState(() => _people--) : null,
                  icon: const Icon(Icons.remove_circle_outline),
                  color: AppTheme.primary,
                ),
                Text('$_people', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: _people < 20 ? () => setState(() => _people++) : null,
                  icon: const Icon(Icons.add_circle_outline),
                  color: AppTheme.primary,
                ),
              ],
            ),
            Slider(
              value: _people.toDouble(),
              min: 2, max: 20, divisions: 18,
              label: '$_people 人',
              onChanged: (v) => setState(() => _people = v.toInt()),
            ),
            const SizedBox(height: 8),
            // 高级模式切换
            Row(
              children: [
                const Text('自定义比例', style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
                const Spacer(),
                Switch(
                  value: _advancedMode,
                  onChanged: (v) => setState(() => _advancedMode = v),
                  activeColor: AppTheme.primary,
                ),
              ],
            ),
            if (_advancedMode) ...[
              const SizedBox(height: 8),
              ...List.generate(_people, (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Text('第 ${i + 1} 人', style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _ratioCtrl[i],
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              suffixText: '份',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
            const SizedBox(height: 24),
            // 结果
            _ResultCard(
              total: _total,
              people: _people,
              advancedMode: _advancedMode,
              ratios: _ratioCtrl.take(_people).map((c) => double.tryParse(c.text) ?? 1).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final double total;
  final int people;
  final bool advancedMode;
  final List<double> ratios;
  const _ResultCard({required this.total, required this.people, required this.advancedMode, required this.ratios});

  @override
  Widget build(BuildContext context) {
    if (total <= 0) return const SizedBox.shrink();

    final ratioSum = ratios.fold(0.0, (s, r) => s + r);

    return Card(
      color: AppTheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('分摊结果', style: TextStyle(color: Colors.white70, fontSize: 13)),
            const SizedBox(height: 12),
            if (!advancedMode)
              Center(
                child: Text(
                  '每人 ¥${(total / people).toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                ),
              )
            else
              ...List.generate(people, (i) {
                final share = ratioSum > 0 ? total * ratios[i] / ratioSum : 0;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Text('第 ${i + 1} 人 (${ratios[i]}份)',
                          style: const TextStyle(color: Colors.white70, fontSize: 13)),
                      const Spacer(),
                      Text('¥${share.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                );
              }),
            const SizedBox(height: 8),
            Text('总金额 ¥${total.toStringAsFixed(2)}，共 $people 人',
                style: const TextStyle(color: Colors.white60, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
