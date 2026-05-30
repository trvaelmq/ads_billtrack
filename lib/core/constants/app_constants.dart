import 'package:flutter/material.dart';

class BillCategory {
  final String id;
  final String label;
  final String emoji;
  final Color color;
  final bool isExpense;

  const BillCategory({
    required this.id,
    required this.label,
    required this.emoji,
    required this.color,
    required this.isExpense,
  });
}

class AppConstants {
  static const List<BillCategory> expenseCategories = [
    BillCategory(id: 'food',          label: '餐饮',   emoji: '🍜', color: Color(0xFFEF5350), isExpense: true),
    BillCategory(id: 'transport',     label: '交通',   emoji: '🚗', color: Color(0xFF42A5F5), isExpense: true),
    BillCategory(id: 'shopping',      label: '购物',   emoji: '🛍️', color: Color(0xFFAB47BC), isExpense: true),
    BillCategory(id: 'entertainment', label: '娱乐',   emoji: '🎮', color: Color(0xFFFF7043), isExpense: true),
    BillCategory(id: 'home',          label: '居家',   emoji: '🏠', color: Color(0xFF26A69A), isExpense: true),
    BillCategory(id: 'health',        label: '医疗',   emoji: '💊', color: Color(0xFFEC407A), isExpense: true),
    BillCategory(id: 'education',     label: '教育',   emoji: '📚', color: Color(0xFF5C6BC0), isExpense: true),
    BillCategory(id: 'other_exp',     label: '其他',   emoji: '💡', color: Color(0xFF8D6E63), isExpense: true),
  ];

  static const List<BillCategory> incomeCategories = [
    BillCategory(id: 'salary',        label: '工资',   emoji: '💼', color: Color(0xFF43A047), isExpense: false),
    BillCategory(id: 'sideline',      label: '兼职',   emoji: '🔧', color: Color(0xFF00ACC1), isExpense: false),
    BillCategory(id: 'invest',        label: '投资',   emoji: '📈', color: Color(0xFFFFB300), isExpense: false),
    BillCategory(id: 'other_inc',     label: '其他',   emoji: '💰', color: Color(0xFF66BB6A), isExpense: false),
  ];

  static List<BillCategory> get allCategories => [...expenseCategories, ...incomeCategories];

  static BillCategory categoryById(String id) =>
      allCategories.firstWhere((c) => c.id == id,
          orElse: () => expenseCategories.last);

  // 快捷金额
  static const List<double> quickAmounts = [50, 100, 200, 500];
}
