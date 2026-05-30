import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // ── New palette ─────────────────────────────────────────────────────
  static const Color primaryStart   = Color(0xFF6C5CE7);
  static const Color primaryEnd     = Color(0xFFa29bfe);
  static const Color background     = Color(0xFFF8F9FA);
  static const Color cardColor      = Color(0xFFFFFFFF);
  static const Color accent         = Color(0xFF6C5CE7);
  static const Color expenseRed     = Color(0xFFFF6B6B);
  static const Color incomeGreen    = Color(0xFF00B894);
  static const Color warnOrange     = Color(0xFFFDCB6E);
  static const Color textPrimary    = Color(0xFF2D3436);
  static const Color textSecondary  = Color(0xFF636E72);
  static const Color divider        = Color(0xFFEEEEEE);

  // ── Backward-compat aliases (existing code keeps compiling) ─────────
  static const Color primary    = primaryStart;
  static const Color secondary  = primaryEnd;
  static const Color surface    = cardColor;
  static const Color coinGold   = Color(0xFFFFC107);

  // ── Gradient ────────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryStart, primaryEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Decoration helpers ───────────────────────────────────────────────
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.06),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration get gradientDecoration => BoxDecoration(
    gradient: primaryGradient,
    borderRadius: BorderRadius.circular(16),
  );

  // ── Text styles ──────────────────────────────────────────────────────
  static const TextStyle display = TextStyle(
      fontSize: 28, fontWeight: FontWeight.bold, color: textPrimary);
  static const TextStyle titleStyle = TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, color: textPrimary);
  static const TextStyle headline = TextStyle(
      fontSize: 17, fontWeight: FontWeight.w600, color: textPrimary);
  static const TextStyle body = TextStyle(
      fontSize: 15, fontWeight: FontWeight.normal, color: textPrimary);
  static const TextStyle caption = TextStyle(
      fontSize: 13, fontWeight: FontWeight.normal, color: textSecondary);

  // ── ThemeData ────────────────────────────────────────────────────────
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryStart,
      brightness: Brightness.light,
    ).copyWith(primary: primaryStart, surface: cardColor),
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: cardColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryStart,
      unselectedItemColor: textSecondary,
      backgroundColor: cardColor,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryStart,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: divider)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: divider)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryStart, width: 1.5)),
      filled: true,
      fillColor: cardColor,
    ),
  );
}
