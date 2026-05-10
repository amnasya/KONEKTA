import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class BrandProfileScreen extends StatelessWidget {
  const BrandProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(gradient: AppColors.headerGradient),
            padding: const EdgeInsets.only(top: 60, bottom: 32),
            child: Column(
              children: [
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Icon(Icons.business_center_outlined,
                      color: Colors.white, size: 44),
                ),
                const SizedBox(height: 12),
                const Text('Your Brand',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                const Text('yourbrand.com',
                    style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('🏢 Brand',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
          ),

          // Stats
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _StatItem(value: '3', label: 'Campaigns'),
                _StatItem(value: '12', label: 'Influencers'),
                _StatItem(value: '148K', label: 'Total Reach'),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _ProfileTile(icon: Icons.edit_outlined, label: 'Edit Brand Profile'),
                  _ProfileTile(icon: Icons.campaign_outlined, label: 'My Campaigns'),
                  _ProfileTile(icon: Icons.receipt_long_outlined, label: 'Billing & Payments'),
                  _ProfileTile(icon: Icons.notifications_outlined, label: 'Notifications'),
                  _ProfileTile(icon: Icons.lock_outline, label: 'Privacy & Security'),
                  _ProfileTile(icon: Icons.help_outline, label: 'Help & Support'),
                  _ProfileTile(
                      icon: Icons.logout,
                      label: 'Sign Out',
                      color: Colors.redAccent),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.darkText)),
        Text(label,
            style: const TextStyle(fontSize: 12, color: AppColors.grayText)),
      ],
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  const _ProfileTile({required this.icon, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.darkText;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: c, size: 22),
        title: Text(label,
            style: TextStyle(
                color: c, fontWeight: FontWeight.w500, fontSize: 14)),
        trailing: color == null
            ? const Icon(Icons.chevron_right,
                color: AppColors.lightGray, size: 20)
            : null,
        onTap: () {},
      ),
    );
  }
}
