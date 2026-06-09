import 'dart:math';

enum RepayMethod { equalInstallment, equalPrincipal }
enum PrepayStrategy { shortenTerm, reducePayment }

class EqualInstallmentResult {
  final double monthlyPayment;
  final double totalPayment;
  final double totalInterest;
  const EqualInstallmentResult(this.monthlyPayment, this.totalPayment, this.totalInterest);
}

class EqualPrincipalResult {
  final double firstMonthPayment;
  final double lastMonthPayment;
  final double monthlyDecrease;
  final double totalPayment;
  final double totalInterest;
  const EqualPrincipalResult(this.firstMonthPayment, this.lastMonthPayment,
      this.monthlyDecrease, this.totalPayment, this.totalInterest);
}

class CombinedResult {
  final double monthlyPayment;   // 等额本息：月供；等额本金：首月供
  final double totalPayment;
  final double totalInterest;
  const CombinedResult(this.monthlyPayment, this.totalPayment, this.totalInterest);
}

class PrepayResult {
  final double originalMonthlyPayment;
  final double newMonthlyPayment;
  final int newRemainingMonths;
  final double savedInterest;
  const PrepayResult(this.originalMonthlyPayment, this.newMonthlyPayment,
      this.newRemainingMonths, this.savedInterest);
}

class Mortgage {
  /// 等额本息
  static EqualInstallmentResult equalInstallment({
    required double principal, required double annualRatePct, required double years}) {
    final n = (years * 12).round();
    final r = annualRatePct / 100 / 12;
    if (n <= 0) return const EqualInstallmentResult(0, 0, 0);
    final double monthly;
    if (r == 0) {
      monthly = principal / n;
    } else {
      monthly = principal * r * pow(1 + r, n) / (pow(1 + r, n) - 1);
    }
    final total = monthly * n;
    return EqualInstallmentResult(monthly, total, total - principal);
  }

  /// 等额本金
  static EqualPrincipalResult equalPrincipal({
    required double principal, required double annualRatePct, required double years}) {
    final n = (years * 12).round();
    final r = annualRatePct / 100 / 12;
    if (n <= 0) return const EqualPrincipalResult(0, 0, 0, 0, 0);
    final monthlyPrincipal = principal / n;
    final first = monthlyPrincipal + principal * r;
    final last  = monthlyPrincipal + monthlyPrincipal * r;
    final decrease = monthlyPrincipal * r;
    // 总利息 = 各月剩余本金*r 之和 = r * 本金 * (n+1)/2
    final totalInterest = r * principal * (n + 1) / 2;
    final totalPayment = principal + totalInterest;
    return EqualPrincipalResult(first, last, decrease, totalPayment, totalInterest);
  }

  /// 组合贷：公积金段 + 商业段，相同年限，相同还款方式
  static CombinedResult combined({
    required double fundPrincipal, required double fundRatePct,
    required double commercialPrincipal, required double commercialRatePct,
    required double years, required RepayMethod method}) {
    if (method == RepayMethod.equalInstallment) {
      final f = equalInstallment(principal: fundPrincipal, annualRatePct: fundRatePct, years: years);
      final c = equalInstallment(principal: commercialPrincipal, annualRatePct: commercialRatePct, years: years);
      return CombinedResult(f.monthlyPayment + c.monthlyPayment,
          f.totalPayment + c.totalPayment, f.totalInterest + c.totalInterest);
    } else {
      final f = equalPrincipal(principal: fundPrincipal, annualRatePct: fundRatePct, years: years);
      final c = equalPrincipal(principal: commercialPrincipal, annualRatePct: commercialRatePct, years: years);
      return CombinedResult(f.firstMonthPayment + c.firstMonthPayment,
          f.totalPayment + c.totalPayment, f.totalInterest + c.totalInterest);
    }
  }

  /// 剩余本金（等额本息，已还 paidMonths 期后）
  static double _remainingPrincipalEI(double principal, double r, int n, int paidMonths) {
    if (r == 0) return principal * (n - paidMonths) / n;
    final monthly = principal * r * pow(1 + r, n) / (pow(1 + r, n) - 1);
    // 剩余本金 = 月供 * (1 - (1+r)^-(n-paid)) / r
    final k = n - paidMonths;
    return monthly * (1 - pow(1 + r, -k)) / r;
  }

  /// 提前还款（基于等额本息）
  static PrepayResult prepay({
    required double principal, required double annualRatePct, required double years,
    required int paidMonths, required double prepayAmount, required PrepayStrategy strategy}) {
    final n = (years * 12).round();
    if (n <= 0) return const PrepayResult(0, 0, 0, 0);
    final paid = paidMonths.clamp(0, n - 1).toInt();
    final pre = prepayAmount < 0 ? 0.0 : prepayAmount;
    final r = annualRatePct / 100 / 12;
    final origMonthly = (r == 0)
        ? principal / n
        : principal * r * pow(1 + r, n) / (pow(1 + r, n) - 1);
    final remainBefore = _remainingPrincipalEI(principal, r, n, paid);
    // 原方案：剩余期间还要付的利息
    final remainMonths = n - paid;
    final origRemainInterest = origMonthly * remainMonths - remainBefore;

    final remainAfter = (remainBefore - pre).clamp(0, double.infinity).toDouble();

    double newMonthly;
    int newMonths;
    if (strategy == PrepayStrategy.shortenTerm) {
      newMonthly = origMonthly;
      if (r == 0) {
        newMonths = (remainAfter / newMonthly).ceil();
      } else {
        // n' = -ln(1 - remainAfter*r/monthly) / ln(1+r)
        final v = 1 - remainAfter * r / newMonthly;
        newMonths = v <= 0 ? 0 : (-log(v) / log(1 + r)).ceil();
      }
    } else {
      newMonths = remainMonths;
      if (r == 0) {
        newMonthly = remainAfter / newMonths;
      } else {
        newMonthly = remainAfter * r * pow(1 + r, newMonths) / (pow(1 + r, newMonths) - 1);
      }
    }
    final newRemainInterest = newMonthly * newMonths - remainAfter;
    final saved = origRemainInterest - newRemainInterest;
    return PrepayResult(origMonthly, newMonthly, newMonths, saved);
  }
}
