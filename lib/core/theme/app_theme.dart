import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary       = Color(0xFF3F51B5); // 靛蓝
  static const Color secondary     = Color(0xFF7986CB); // 浅靛蓝
  static const Color accent        = Color(0xFFFF9800); // 橙色（金币色）
  static const Color background    = Color(0xFFF3F4F8);
  static const Color surface       = Colors.white;
  static const Color textPrimary   = Color(0xFF1A237E);
  static const Color textSecondary = Color(0xFF5C6BC0);
  static const Color expenseRed    = Color(0xFFE53935);
  static const Color incomeGreen   = Color(0xFF43A047);
  static const Color coinGold      = Color(0xFFFFC107);

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: background,
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: surface,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: primary,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primary,
          foregroundColor: Colors.white,
        ),
      );
}
