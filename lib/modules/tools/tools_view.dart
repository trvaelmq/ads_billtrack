import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/calc/mortgage.dart';

// ── Main Page ──────────────────────────────────────────────────────────────────

class ToolsView extends StatelessWidget {
  const ToolsView({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarH = MediaQuery.of(context).padding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('工具箱',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17)),
      ),
      body: Column(children: [
        Container(
          height: statusBarH + 56,
          decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
            children: [
              const Text('财务计算工具',
                  style: TextStyle(fontSize: 13, color: AppTheme.textSecondary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.28,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _ToolCard(
                    emoji: '🏦', title: '房贷计算', subtitle: '月供·提前还款',
                    color: const Color(0xFF5C6BC0),
                    onTap: () => Get.to(() => const LoanPage()),
                  ),
                  _ToolCard(
                    emoji: '📈', title: '投资收益', subtitle: '复利增长估算',
                    color: const Color(0xFF26A69A),
                    onTap: () => Get.to(() => const InvestmentPage()),
                  ),
                  _ToolCard(
                    emoji: '💱', title: '汇率换算', subtitle: '离线多币种',
                    color: const Color(0xFFEF6C00),
                    onTap: () => Get.to(() => const CurrencyPage()),
                  ),
                  _ToolCard(
                    emoji: '🧾', title: '个税速算', subtitle: '月薪税后到手',
                    color: const Color(0xFF8D6E63),
                    onTap: () => Get.to(() => const TaxPage()),
                  ),
                  _ToolCard(
                    emoji: '🎯', title: '存钱规划', subtitle: '目标完成预测',
                    color: const Color(0xFF7B1FA2),
                    onTap: () => Get.to(() => const SavingsPage()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

// ── Tool Card ──────────────────────────────────────────────────────────────────

class _ToolCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  const _ToolCard({
    required this.emoji, required this.title, required this.subtitle,
    required this.color, required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 3))
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text(emoji, style: const TextStyle(fontSize: 22))),
              ),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
            ],
          ),
        ),
      );
}

// ── Page Scaffold Base ─────────────────────────────────────────────────────────

class _ToolPageBase extends StatelessWidget {
  final String title;
  final Widget body;
  const _ToolPageBase({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        elevation: 0,
        title: Text(title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: body,
    );
  }
}

// ── Shared Helpers ─────────────────────────────────────────────────────────────

InputDecoration _dec(String label, {String? suffix, String? hint}) => InputDecoration(
      labelText: label,
      hintText: hint,
      suffixText: suffix,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    );

class _ResultBox extends StatelessWidget {
  final List<(String, String)> rows;
  const _ResultBox(this.rows);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [AppTheme.primaryStart, AppTheme.primaryEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: rows
              .map((r) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(r.$1, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                          Text(r.$2,
                              style: const TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        ]),
                  ))
              .toList(),
        ),
      );
}

class _CalcButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CalcButton({required this.onTap});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.accent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 0,
          ),
          child: const Text('计  算',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 4)),
        ),
      );
}

// ── 贷款计算页 ─────────────────────────────────────────────────────────────────

class LoanPage extends StatefulWidget {
  const LoanPage({super.key});

  @override
  State<LoanPage> createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() { _tab.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        elevation: 0,
        title: const Text('🏦 房贷计算',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
        bottom: TabBar(
          controller: _tab,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [Tab(text: '房贷计算'), Tab(text: '提前还款')],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: const [_MortgageTab(), _PrepayTab()],
      ),
    );
  }
}

// ── 房贷计算 Tab ────────────────────────────────────────────────
class _MortgageTab extends StatefulWidget {
  const _MortgageTab();
  @override
  State<_MortgageTab> createState() => _MortgageTabState();
}

class _MortgageTabState extends State<_MortgageTab>
    with AutomaticKeepAliveClientMixin {
  int _loanType = 0; // 0商业 1公积金 2组合
  RepayMethod _method = RepayMethod.equalInstallment;

  final _amt  = TextEditingController();
  final _rate = TextEditingController(text: '4.1');
  final _year = TextEditingController(text: '30');
  final _fundAmt  = TextEditingController();
  final _fundRate = TextEditingController(text: '3.1');
  final _commAmt  = TextEditingController();
  final _commRate = TextEditingController(text: '4.1');
  List<(String, String)>? _res;

  @override
  bool get wantKeepAlive => true;

  void _calc() {
    final years = double.tryParse(_year.text) ?? 0;
    if (years <= 0) return;
    if (_loanType == 2) {
      final fp = double.tryParse(_fundAmt.text) ?? 0;
      final fr = double.tryParse(_fundRate.text) ?? 0;
      final cp = double.tryParse(_commAmt.text) ?? 0;
      final cr = double.tryParse(_commRate.text) ?? 0;
      if (fp + cp <= 0) return;
      final r = Mortgage.combined(
        fundPrincipal: fp, fundRatePct: fr,
        commercialPrincipal: cp, commercialRatePct: cr,
        years: years, method: _method);
      setState(() => _res = [
        (_method == RepayMethod.equalInstallment ? '月供' : '首月供',
            '¥${r.monthlyPayment.toStringAsFixed(2)}'),
        ('还款总额', '¥${r.totalPayment.toStringAsFixed(2)}'),
        ('支付利息', '¥${r.totalInterest.toStringAsFixed(2)}'),
      ]);
    } else {
      final p = double.tryParse(_amt.text) ?? 0;
      final rate = double.tryParse(_rate.text) ?? 0;
      if (p <= 0) return;
      if (_method == RepayMethod.equalInstallment) {
        final r = Mortgage.equalInstallment(principal: p, annualRatePct: rate, years: years);
        setState(() => _res = [
          ('月供', '¥${r.monthlyPayment.toStringAsFixed(2)}'),
          ('还款总额', '¥${r.totalPayment.toStringAsFixed(2)}'),
          ('支付利息', '¥${r.totalInterest.toStringAsFixed(2)}'),
        ]);
      } else {
        final r = Mortgage.equalPrincipal(principal: p, annualRatePct: rate, years: years);
        setState(() => _res = [
          ('首月供', '¥${r.firstMonthPayment.toStringAsFixed(2)}'),
          ('末月供', '¥${r.lastMonthPayment.toStringAsFixed(2)}'),
          ('每月递减', '¥${r.monthlyDecrease.toStringAsFixed(2)}'),
          ('还款总额', '¥${r.totalPayment.toStringAsFixed(2)}'),
          ('支付利息', '¥${r.totalInterest.toStringAsFixed(2)}'),
        ]);
      }
    }
  }

  @override
  void dispose() {
    for (final c in [_amt,_rate,_year,_fundAmt,_fundRate,_commAmt,_commRate]) { c.dispose(); }
    super.dispose();
  }

  Widget _seg(List<String> labels, int val, ValueChanged<int> onChange) => Row(
    children: List.generate(labels.length, (i) {
      final sel = i == val;
      return Expanded(child: GestureDetector(
        onTap: () => setState(() { onChange(i); _res = null; }),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: sel ? AppTheme.primary : AppTheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(labels[i], textAlign: TextAlign.center,
            style: TextStyle(color: sel ? Colors.white : AppTheme.primary,
              fontSize: 13, fontWeight: FontWeight.w600)),
        ),
      ));
    }),
  );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('贷款类型', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
        const SizedBox(height: 8),
        _seg(const ['商业贷','公积金贷','组合贷'], _loanType, (v) => _loanType = v),
        const SizedBox(height: 16),
        const Text('还款方式', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
        const SizedBox(height: 8),
        _seg(const ['等额本息','等额本金'], _method.index, (v) => _method = RepayMethod.values[v]),
        const SizedBox(height: 16),
        if (_loanType == 2) ...[
          TextField(controller: _fundAmt,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: _dec('公积金贷款额', suffix: '元')),
          const SizedBox(height: 12),
          TextField(controller: _fundRate,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: _dec('公积金年利率', suffix: '%', hint: '3.1')),
          const SizedBox(height: 12),
          TextField(controller: _commAmt,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: _dec('商业贷款额', suffix: '元')),
          const SizedBox(height: 12),
          TextField(controller: _commRate,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: _dec('商业年利率', suffix: '%', hint: '4.1')),
        ] else ...[
          TextField(controller: _amt,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: _dec('贷款金额', suffix: '元', hint: '如：1000000')),
          const SizedBox(height: 12),
          TextField(controller: _rate,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: _dec('年利率', suffix: '%',
                  hint: _loanType == 1 ? '公积金约3.1' : '商业约4.1')),
        ],
        const SizedBox(height: 12),
        TextField(controller: _year,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: _dec('贷款年限', suffix: '年', hint: '30')),
        const SizedBox(height: 24),
        _CalcButton(onTap: _calc),
        if (_res != null) ...[const SizedBox(height: 20), _ResultBox(_res!)],
      ]),
    );
  }
}

// ── 提前还款 Tab ────────────────────────────────────────────────
class _PrepayTab extends StatefulWidget {
  const _PrepayTab();
  @override
  State<_PrepayTab> createState() => _PrepayTabState();
}

class _PrepayTabState extends State<_PrepayTab>
    with AutomaticKeepAliveClientMixin {
  final _amt   = TextEditingController(text: '1000000');
  final _rate  = TextEditingController(text: '4.1');
  final _year  = TextEditingController(text: '30');
  final _paid  = TextEditingController(text: '36');
  final _prepay= TextEditingController(text: '200000');
  PrepayStrategy _strategy = PrepayStrategy.shortenTerm;
  List<(String, String)>? _res;

  @override
  bool get wantKeepAlive => true;

  void _calc() {
    final p = double.tryParse(_amt.text) ?? 0;
    final rate = double.tryParse(_rate.text) ?? 0;
    final years = double.tryParse(_year.text) ?? 0;
    final paid = int.tryParse(_paid.text) ?? 0;
    final pre  = double.tryParse(_prepay.text) ?? 0;
    if (p <= 0 || years <= 0 || pre <= 0) return;
    final r = Mortgage.prepay(
      principal: p, annualRatePct: rate, years: years,
      paidMonths: paid, prepayAmount: pre, strategy: _strategy);
    final yrs = r.newRemainingMonths ~/ 12;
    final mos = r.newRemainingMonths % 12;
    setState(() => _res = [
      ('节省利息', '¥${r.savedInterest.toStringAsFixed(2)}'),
      ('原月供', '¥${r.originalMonthlyPayment.toStringAsFixed(2)}'),
      ('新月供', '¥${r.newMonthlyPayment.toStringAsFixed(2)}'),
      ('剩余期限', yrs > 0 ? '$yrs 年 $mos 个月' : '${r.newRemainingMonths} 个月'),
    ]);
  }

  @override
  void dispose() {
    for (final c in [_amt,_rate,_year,_paid,_prepay]) { c.dispose(); }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('基于等额本息估算', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
        const SizedBox(height: 16),
        TextField(controller: _amt,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: _dec('原贷款金额', suffix: '元')),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: TextField(controller: _rate,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: _dec('年利率', suffix: '%'))),
          const SizedBox(width: 12),
          Expanded(child: TextField(controller: _year,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: _dec('贷款年限', suffix: '年'))),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: TextField(controller: _paid,
              keyboardType: TextInputType.number,
              decoration: _dec('已还月数', suffix: '月'))),
          const SizedBox(width: 12),
          Expanded(child: TextField(controller: _prepay,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: _dec('提前还款额', suffix: '元'))),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: GestureDetector(
            onTap: () => setState(() { _strategy = PrepayStrategy.shortenTerm; _res = null; }),
            child: _strategyChip('缩短年限', _strategy == PrepayStrategy.shortenTerm))),
          const SizedBox(width: 8),
          Expanded(child: GestureDetector(
            onTap: () => setState(() { _strategy = PrepayStrategy.reducePayment; _res = null; }),
            child: _strategyChip('减少月供', _strategy == PrepayStrategy.reducePayment))),
        ]),
        const SizedBox(height: 24),
        _CalcButton(onTap: _calc),
        if (_res != null) ...[const SizedBox(height: 20), _ResultBox(_res!)],
      ]),
    );
  }

  Widget _strategyChip(String label, bool sel) => Container(
    padding: const EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(
      color: sel ? AppTheme.primary : AppTheme.primary.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(label, textAlign: TextAlign.center,
      style: TextStyle(color: sel ? Colors.white : AppTheme.primary,
        fontSize: 13, fontWeight: FontWeight.w600)),
  );
}

// ── 投资收益页 ─────────────────────────────────────────────────────────────────

class InvestmentPage extends StatefulWidget {
  const InvestmentPage({super.key});

  @override
  State<InvestmentPage> createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<InvestmentPage> {
  final _pv   = TextEditingController();
  final _rate = TextEditingController(text: '7');
  final _year = TextEditingController(text: '10');
  final _pmt  = TextEditingController(text: '0');
  List<(String, String)>? _res;

  void _calc() {
    final pv  = double.tryParse(_pv.text) ?? 0;
    final r   = (double.tryParse(_rate.text) ?? 0) / 100;
    final n   = double.tryParse(_year.text) ?? 0;
    final pmt = double.tryParse(_pmt.text) ?? 0;
    if (r <= 0 || n <= 0) return;
    final mr = r / 12;
    final mn = n * 12;
    final fv = pv * pow(1 + r, n) +
        (pmt > 0 ? pmt * (pow(1 + mr, mn) - 1) / mr : 0);
    final invested = pv + pmt * mn;
    setState(() => _res = [
      ('最终资产', '¥${fv.toStringAsFixed(2)}'),
      ('总投入', '¥${invested.toStringAsFixed(2)}'),
      ('收益', '¥${(fv - invested).toStringAsFixed(2)}'),
      ('收益率', '${((fv / (invested > 0 ? invested : 1) - 1) * 100).toStringAsFixed(1)}%'),
    ]);
  }

  @override
  void dispose() { _pv.dispose(); _rate.dispose(); _year.dispose(); _pmt.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => _ToolPageBase(
        title: '📈 投资收益',
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Text('复利计算，含每月定投', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
            const SizedBox(height: 16),
            TextField(controller: _pv,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: _dec('初始本金', suffix: '元', hint: '如：100000')),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(child: TextField(controller: _rate,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: _dec('年化收益率', suffix: '%'))),
              const SizedBox(width: 14),
              Expanded(child: TextField(controller: _year,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: _dec('投资年限', suffix: '年'))),
            ]),
            const SizedBox(height: 14),
            TextField(controller: _pmt,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: _dec('每月定投', suffix: '元', hint: '不定投填 0')),
            const SizedBox(height: 24),
            _CalcButton(onTap: _calc),
            if (_res != null) ...[const SizedBox(height: 20), _ResultBox(_res!)],
          ]),
        ),
      );
}

// ── 汇率换算页 ─────────────────────────────────────────────────────────────────

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  // 离线参考汇率：1单位外币 = ? 人民币（2025年参考价）
  static const _rates = <String, double>{
    'CNY 人民币': 1.0,
    'USD 美元': 7.25,
    'EUR 欧元': 7.90,
    'GBP 英镑': 9.15,
    'JPY 日元': 0.048,
    'HKD 港元': 0.93,
    'KRW 韩元': 0.0053,
    'SGD 新元': 5.40,
    'AUD 澳元': 4.65,
    'CAD 加元': 5.25,
    'CHF 瑞郎': 8.20,
    'THB 泰铢': 0.21,
  };

  String _from = 'USD 美元';
  String _to   = 'CNY 人民币';
  final _amt   = TextEditingController();
  String? _res;

  void _calc() {
    final a   = double.tryParse(_amt.text) ?? 0;
    if (a <= 0) return;
    final cny = a * _rates[_from]!;
    final res = cny / _rates[_to]!;
    setState(() => _res = res.toStringAsFixed(4));
  }

  void _swap() => setState(() { final t = _from; _from = _to; _to = t; _res = null; });

  Widget _picker(String val, ValueChanged<String> onChange) =>
      DropdownButtonFormField<String>(
        value: val,
        isExpanded: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
        items: _rates.keys
            .map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 14))))
            .toList(),
        onChanged: (v) { if (v != null) { onChange(v); setState(() => _res = null); } },
      );

  @override
  void dispose() { _amt.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => _ToolPageBase(
        title: '💱 汇率换算',
        body: Column(children: [
          // ── 固定输入区 ──────────────────────────────────
          Container(
            color: AppTheme.background,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.accent.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('汇率为2025年参考价，离线可用，仅供估算',
                    style: TextStyle(fontSize: 12, color: AppTheme.accent)),
              ),
              const SizedBox(height: 12),
              TextField(controller: _amt,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: _dec('金额')),
              const SizedBox(height: 10),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(child: _picker(_from, (v) => setState(() { _from = v; _res = null; }))),
                GestureDetector(
                  onTap: _swap,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.swap_horiz, color: AppTheme.primary, size: 20),
                  ),
                ),
                Expanded(child: _picker(_to, (v) => setState(() { _to = v; _res = null; }))),
              ]),
              const SizedBox(height: 12),
              _CalcButton(onTap: _calc),
              if (_res != null) ...[
                const SizedBox(height: 12),
                _ResultBox([('换算结果', '$_res  ${_to.split(' ').first}')]),
              ],
            ]),
          ),
          const Divider(height: 1),
          // ── 滚动汇率表 ──────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                const Text('参考汇率表',
                    style: TextStyle(fontSize: 13, color: AppTheme.textSecondary, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                ..._rates.entries.where((e) => e.key != 'CNY 人民币').map((e) => Container(
                  margin: const EdgeInsets.only(bottom: 1),
                  color: Colors.white,
                  child: ListTile(
                    dense: true,
                    title: Text(e.key, style: const TextStyle(fontSize: 14)),
                    trailing: Text(
                      '1 ${e.key.split(' ').first} = ${e.value.toStringAsFixed(e.value < 1 ? 4 : 2)} CNY',
                      style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ]),
      );
}

// ── 个税速算页 ─────────────────────────────────────────────────────────────────

class TaxPage extends StatefulWidget {
  const TaxPage({super.key});

  @override
  State<TaxPage> createState() => _TaxPageState();
}

class _TaxPageState extends State<TaxPage> {
  final _salary = TextEditingController();
  final _insur  = TextEditingController(text: '0');
  List<(String, String)>? _res;

  void _calc() {
    final s = double.tryParse(_salary.text) ?? 0;
    final i = double.tryParse(_insur.text) ?? 0;
    if (s <= 0) return;
    final taxable = (s - 5000 - i).clamp(0, double.infinity).toDouble();
    final double tax;
    if (taxable <= 3000) {
      tax = taxable * 0.03;
    } else if (taxable <= 12000) {
      tax = taxable * 0.10 - 210;
    } else if (taxable <= 25000) {
      tax = taxable * 0.20 - 1410;
    } else if (taxable <= 35000) {
      tax = taxable * 0.25 - 2660;
    } else if (taxable <= 55000) {
      tax = taxable * 0.30 - 4410;
    } else if (taxable <= 80000) {
      tax = taxable * 0.35 - 7160;
    } else {
      tax = taxable * 0.45 - 15160;
    }
    final take = s - i - tax;
    setState(() => _res = [
      ('应缴个税', '¥${tax.toStringAsFixed(2)}'),
      ('税后到手', '¥${take.toStringAsFixed(2)}'),
      ('实际税率', '${(s > 0 ? tax / s * 100 : 0).toStringAsFixed(1)}%'),
    ]);
  }

  @override
  void dispose() { _salary.dispose(); _insur.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => _ToolPageBase(
        title: '🧾 个税速算',
        body: Column(children: [
          // ── 固定输入区 ──────────────────────────────────
          Container(
            color: AppTheme.background,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              const Text('起征点 5000 元，适用月度预扣法',
                  style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
              const SizedBox(height: 12),
              TextField(controller: _salary,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: _dec('税前月薪', suffix: '元', hint: '如：15000')),
              const SizedBox(height: 12),
              TextField(controller: _insur,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: _dec('五险一金（个人部分）', suffix: '元', hint: '不扣填 0')),
              const SizedBox(height: 12),
              _CalcButton(onTap: _calc),
              if (_res != null) ...[const SizedBox(height: 12), _ResultBox(_res!)],
            ]),
          ),
          const Divider(height: 1),
          // ── 滚动税率表 ──────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [_TaxBracketTable()],
            ),
          ),
        ]),
      );
}

class _TaxBracketTable extends StatelessWidget {
  static const _brackets = [
    ('0 – 3,000', '3%', '0'),
    ('3,001 – 12,000', '10%', '210'),
    ('12,001 – 25,000', '20%', '1,410'),
    ('25,001 – 35,000', '25%', '2,660'),
    ('35,001 – 55,000', '30%', '4,410'),
    ('55,001 – 80,000', '35%', '7,160'),
    ('80,000 以上', '45%', '15,160'),
  ];

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('月度税率档位（元）', style: TextStyle(fontSize: 13, color: AppTheme.textSecondary, fontWeight: FontWeight.w600)),
      const SizedBox(height: 8),
      Container(
        decoration: AppTheme.cardDecoration,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.06),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: const Row(children: [
                Expanded(flex: 3, child: Text('应纳税额', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textSecondary))),
                Expanded(child: Text('税率', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textSecondary))),
                Expanded(child: Text('速扣', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textSecondary))),
              ]),
            ),
            ..._brackets.asMap().entries.map((e) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                border: e.key < _brackets.length - 1
                    ? const Border(bottom: BorderSide(color: AppTheme.divider, width: 0.5))
                    : null,
              ),
              child: Row(children: [
                Expanded(flex: 3, child: Text(e.value.$1, style: const TextStyle(fontSize: 12))),
                Expanded(child: Text(e.value.$2, style: const TextStyle(fontSize: 12, color: AppTheme.expenseRed, fontWeight: FontWeight.w600))),
                Expanded(child: Text(e.value.$3, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary))),
              ]),
            )),
          ],
        ),
      ),
    ],
  );
}

// ── 存钱规划页 ─────────────────────────────────────────────────────────────────

class SavingsPage extends StatefulWidget {
  const SavingsPage({super.key});

  @override
  State<SavingsPage> createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  final _goal  = TextEditingController();
  final _saved = TextEditingController(text: '0');
  final _month = TextEditingController();
  final _rate  = TextEditingController(text: '2');
  List<(String, String)>? _res;

  void _calc() {
    final goal  = double.tryParse(_goal.text) ?? 0;
    final saved = double.tryParse(_saved.text) ?? 0;
    final pmt   = double.tryParse(_month.text) ?? 0;
    final r     = (double.tryParse(_rate.text) ?? 0) / 100 / 12;
    if (goal <= 0 || pmt <= 0) return;
    final remain = goal - saved;
    if (remain <= 0) {
      setState(() => _res = [('恭喜', '目标已达成！'), ('目标金额', '¥${goal.toStringAsFixed(0)}')]);
      return;
    }
    int months;
    if (r <= 0) {
      months = (remain / pmt).ceil();
    } else {
      months = (log(1 + remain * r / pmt) / log(1 + r)).ceil();
    }
    if (months <= 0) months = 1;
    final years  = months ~/ 12;
    final mos    = months % 12;
    final timeStr = years > 0 ? '$years 年 $mos 个月' : '$months 个月';
    setState(() => _res = [
      ('预计完成时间', timeStr),
      ('总存入', '¥${(pmt * months).toStringAsFixed(0)}'),
      ('目标金额', '¥${goal.toStringAsFixed(0)}'),
    ]);
  }

  @override
  void dispose() { _goal.dispose(); _saved.dispose(); _month.dispose(); _rate.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => _ToolPageBase(
        title: '🎯 存钱规划',
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TextField(controller: _goal,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: _dec('目标金额', suffix: '元', hint: '如：100000')),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(child: TextField(controller: _saved,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: _dec('已存金额', suffix: '元'))),
              const SizedBox(width: 14),
              Expanded(child: TextField(controller: _month,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: _dec('每月存入', suffix: '元'))),
            ]),
            const SizedBox(height: 14),
            TextField(controller: _rate,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: _dec('年化利率', suffix: '%', hint: '银行存款约 2%')),
            const SizedBox(height: 24),
            _CalcButton(onTap: _calc),
            if (_res != null) ...[const SizedBox(height: 20), _ResultBox(_res!)],
          ]),
        ),
      );
}
