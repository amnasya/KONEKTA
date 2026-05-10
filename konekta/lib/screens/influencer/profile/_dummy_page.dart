import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class DummyPage extends StatelessWidget {
  final String title;
  final IconData icon;
  const DummyPage({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 64, color: AppColors.primary.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.darkText)),
          const SizedBox(height: 8),
          const Text('Coming soon', style: TextStyle(color: AppColors.grayText)),
        ]),
      ),
    );
  }
}
