import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../screens/influencer/profile/edit_profile_page.dart';
import '../../screens/influencer/profile/security_page.dart';
import '../../screens/influencer/profile/notification_page.dart';
import '../../screens/influencer/profile/help_center_page.dart';

// ─── Profile Header ───────────────────────────────────────────────────────────

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 20, offset: const Offset(0, 8))],
          ),
          child: CircleAvatar(
            radius: 52,
            backgroundColor: AppColors.primary.withValues(alpha: 0.08),
            child: const Icon(Icons.person_rounded, size: 52, color: AppColors.primary),
          ),
        ),
        Positioned(
          bottom: 2, right: 2,
          child: Container(
            width: 30, height: 30,
            decoration: BoxDecoration(
              gradient: AppColors.headerGradient,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 6, offset: const Offset(0, 2))],
            ),
            child: const Icon(Icons.edit, color: Colors.white, size: 14),
          ),
        ),
      ]),
      const SizedBox(height: 14),
      const Text('Amna Zahra', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.darkText, letterSpacing: -0.3)),
      const SizedBox(height: 4),
      const Text('Lifestyle & Beauty Creator · Jakarta', style: TextStyle(fontSize: 13, color: AppColors.grayText)),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(20)),
        child: const Text('✨ Influencer', style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
      ),
    ]);
  }
}

// ─── Stats Section ────────────────────────────────────────────────────────────

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(children: [
      Expanded(child: _StatCard(icon: Icons.people_outline_rounded, value: '12.5K', label: 'Followers', iconColor: AppColors.primary)),
      SizedBox(width: 12),
      Expanded(child: _StatCard(icon: Icons.bar_chart_rounded, value: '4.2%', label: 'Engagement', iconColor: AppColors.secondary)),
      SizedBox(width: 12),
      Expanded(child: _StatCard(icon: Icons.campaign_outlined, value: '28', label: 'Campaigns', iconColor: AppColors.accent)),
    ]);
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value, label;
  final Color iconColor;
  const _StatCard({required this.icon, required this.value, required this.label, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.darkText)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.grayText), textAlign: TextAlign.center),
      ]),
    );
  }
}

// ─── Payout Card ──────────────────────────────────────────────────────────────

class PayoutCard extends StatelessWidget {
  const PayoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(Icons.account_balance_outlined, color: AppColors.success, size: 22),
        ),
        const SizedBox(width: 14),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Bank Account Details', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.darkText)),
          SizedBox(height: 2),
          Text('BCA •••• 8829', style: TextStyle(fontSize: 12, color: AppColors.grayText)),
        ])),
        const Icon(Icons.chevron_right_rounded, color: AppColors.lightGray, size: 22),
      ]),
    );
  }
}

// ─── Settings Menu ────────────────────────────────────────────────────────────

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 14, offset: const Offset(0, 4))],
      ),
      child: Column(children: [
        _MenuItem(icon: Icons.person_outline, label: 'Edit Profile', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfilePage()))),
        const _MenuDivider(),
        _MenuItem(icon: Icons.lock_outline, label: 'Security', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SecurityPage()))),
        const _MenuDivider(),
        _MenuItem(icon: Icons.notifications_none, label: 'Notifications', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationPage()))),
        const _MenuDivider(),
        _MenuItem(icon: Icons.help_outline, label: 'Help Center', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpCenterPage()))),
        const _MenuDivider(),
        const _LogoutButton(),
      ]),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MenuItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.07), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: AppColors.primary, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.darkText))),
            const Icon(Icons.chevron_right_rounded, color: AppColors.lightGray, size: 20),
          ]),
        ),
      ),
    );
  }
}

class _MenuDivider extends StatelessWidget {
  const _MenuDivider();
  @override
  Widget build(BuildContext context) => Divider(height: 1, indent: 56, endIndent: 16, color: AppColors.accent.withValues(alpha: 0.2));
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.logout_rounded, color: AppColors.error, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(child: Text('Log Out', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.error))),
          ]),
        ),
      ),
    );
  }
}
