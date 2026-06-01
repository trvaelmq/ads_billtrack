class HealthScoreHistory {
  final int year;
  final int month;
  final int total;
  final int savings;
  final int diversity;
  final int consistency;
  final int budget;
  final int cashFlow;
  final int goalProgress;

  const HealthScoreHistory({
    required this.year,
    required this.month,
    required this.total,
    required this.savings,
    required this.diversity,
    required this.consistency,
    required this.budget,
    required this.cashFlow,
    required this.goalProgress,
  });

  Map<String, dynamic> toJson() => {
    'year': year, 'month': month, 'total': total,
    'savings': savings, 'diversity': diversity,
    'consistency': consistency, 'budget': budget,
    'cashFlow': cashFlow, 'goalProgress': goalProgress,
  };

  factory HealthScoreHistory.fromJson(Map<String, dynamic> j) =>
      HealthScoreHistory(
        year: j['year'] as int, month: j['month'] as int,
        total: j['total'] as int, savings: j['savings'] as int,
        diversity: j['diversity'] as int, consistency: j['consistency'] as int,
        budget: j['budget'] as int, cashFlow: j['cashFlow'] as int,
        goalProgress: j['goalProgress'] as int,
      );
}
