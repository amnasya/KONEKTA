import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/app_colors.dart';

class StatsRow extends StatelessWidget {
  final int totalViews;
  final int engagement;

  const StatsRow({super.key, required this.totalViews, required this.engagement});

  String _compact(int value) {
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    return NumberFormat.compact().format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: _StatCard(
        value: _compact(totalViews),
        label: 'TOTAL VIEWS',
        sublabel: '7D',
        icon: Icons.visibility_outlined,
        iconColor: AppColors.primary,
        iconBg: AppColors.primary.withValues(alpha: 0.08),
      )),
      const SizedBox(width: 14),
      Expanded(child: _StatCard(
        value: _compact(engagement),
        label: 'ENGAGEMENT',
        sublabel: '7D',
        icon: Icons.favorite_outline_rounded,
        iconColor: AppColors.secondary,
        iconBg: AppColors.secondary.withValues(alpha: 0.1),
      )),
    ]);
  }
}

class _StatCard extends StatelessWidget {
  final String value, label, sublabel;
  final IconData icon;
  final Color iconColor, iconBg;

  const _StatCard({
    required this.value, required this.label, required this.sublabel,
    required this.icon, required this.iconColor, required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Row(children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.darkText)),
          Text('$label ($sublabel)',
              style: const TextStyle(fontSize: 10, color: AppColors.grayText, fontWeight: FontWeight.w500, letterSpacing: 0.3),
              overflow: TextOverflow.ellipsis),
        ])),
      ]),
    );
  }
}
