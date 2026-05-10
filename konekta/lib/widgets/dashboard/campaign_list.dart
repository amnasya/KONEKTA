import 'package:flutter/material.dart';
import '../../models/dashboard_model.dart';
import '../../theme/app_colors.dart';

class CampaignList extends StatelessWidget {
  final List<Campaign> campaigns;
  const CampaignList({super.key, required this.campaigns});

  @override
  Widget build(BuildContext context) {
    if (campaigns.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: const Column(children: [
              Icon(Icons.inbox_outlined, size: 44, color: Color(0xFFCCCCCC)),
              SizedBox(height: 12),
              Text('No active campaigns yet', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.grayText)),
              SizedBox(height: 4),
              Text('Your campaigns will appear here once assigned.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: AppColors.lightGray)),
            ]),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: CampaignCard(campaign: campaigns[index]),
          ),
          childCount: campaigns.length,
        ),
      ),
    );
  }
}

class CampaignCard extends StatelessWidget {
  final Campaign campaign;
  const CampaignCard({super.key, required this.campaign});

  Color get _statusColor {
    switch (campaign.status) {
      case 'IN PROGRESS':  return AppColors.primary;
      case 'PENDING':      return AppColors.warning;
      case 'COMPLETED':    return AppColors.statusCompleted;
      default:             return AppColors.grayText;
    }
  }

  Color get _statusBg => _statusColor.withValues(alpha: 0.1);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(child: Text(campaign.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.darkText))),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: _statusBg, borderRadius: BorderRadius.circular(20)),
            child: Text(campaign.status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _statusColor, letterSpacing: 0.4)),
          ),
        ]),
        const SizedBox(height: 4),
        Row(children: [
          const Icon(Icons.schedule_rounded, size: 13, color: AppColors.lightGray),
          const SizedBox(width: 4),
          Text('${campaign.daysLeft} days left', style: const TextStyle(fontSize: 12, color: AppColors.grayText)),
        ]),
        const SizedBox(height: 14),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Progress', style: TextStyle(fontSize: 12, color: AppColors.grayText)),
          Text('${campaign.progress}%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.secondary)),
        ]),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: campaign.progress / 100,
            minHeight: 7,
            backgroundColor: AppColors.accent.withValues(alpha: 0.25),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.secondary),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(spacing: 8, children: [
          _GoalChip(icon: Icons.visibility_outlined, label: '${_compact(campaign.targetViews)} views'),
          _GoalChip(icon: Icons.favorite_outline_rounded, label: '${_compact(campaign.targetEngagement)} engagement'),
        ]),
      ]),
    );
  }

  String _compact(int v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}K';
    return v.toString();
  }
}

class _GoalChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _GoalChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 12, color: AppColors.grayText),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.grayText)),
      ]),
    );
  }
}
