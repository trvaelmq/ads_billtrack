import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.asset('assets/app_icon_source.png', width: 100, height: 100),
            ),
            const SizedBox(height: 20),
            const Text('记乐多', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
            const Text('MoneyLog', style: TextStyle(color: Colors.white70, fontSize: 16, letterSpacing: 2)),
            const SizedBox(height: 60),
            const CircularProgressIndicator(color: Colors.white60, strokeWidth: 2),
          ],
        ),
      ),
    );
  }
}
