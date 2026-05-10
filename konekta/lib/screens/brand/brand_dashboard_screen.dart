import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class BrandDashboardScreen extends StatelessWidget {
  const BrandDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hi, Brand 👋',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF222222))),
                            SizedBox(height: 2),
                            Text('Manage your campaigns',
                                style: TextStyle(
                                    fontSize: 13, color: AppColors.grayText)),
                          ],
                        ),
                        Row(children: [
                          _IconBtn(icon: Icons.notifications_outlined),
                          const SizedBox(width: 8),
                          _IconBtn(icon: Icons.menu_rounded),
                        ]),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Budget card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        gradient: AppColors.headerGradient,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.35),
                              blurRadius: 20,
                              offset: const Offset(0, 8))
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text('Total Campaign Budget',
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 13)),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text('Active',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 11)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text('Rp 24.500.000',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800)),
                          const SizedBox(height: 4),
                          const Text('Across 3 active campaigns',
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 11)),
                          const SizedBox(height: 16),
                          Divider(
                              color: Colors.white.withValues(alpha: 0.2),
                              thickness: 1),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Spent this month',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 13)),
                              Text('Rp 8.200.000',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Stats
                    Row(children: [
                      Expanded(
                          child: _StatCard(
                              value: '3',
                              label: 'Active\nCampaigns',
                              icon: Icons.campaign_outlined,
                              iconColor: AppColors.primary,
                              iconBg: AppColors.primary.withValues(alpha: 0.08))),
                      const SizedBox(width: 14),
                      Expanded(
                          child: _StatCard(
                              value: '12',
                              label: 'Influencers\nHired',
                              icon: Icons.people_outline,
                              iconColor: const Color(0xFFD94F7A),
                              iconBg: AppColors.secondary.withValues(alpha: 0.1))),
                    ]),
                    const SizedBox(height: 24),

                    const Text('Active Campaigns',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF333333))),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            // Campaign list
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, i) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _BrandCampaignCard(index: i),
                  ),
                  childCount: 3,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  const _IconBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Icon(icon, size: 20, color: const Color(0xFF333333)),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  const _StatCard(
      {required this.value,
      required this.label,
      required this.icon,
      required this.iconColor,
      required this.iconBg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: iconBg, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF222222))),
                Text(label,
                    style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.grayText,
                        height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandCampaignCard extends StatelessWidget {
  final int index;
  const _BrandCampaignCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final titles = ['Kopi Susu Campaign', 'Skincare Glow', 'Summer Sale'];
    final budgets = ['Rp 5.000.000', 'Rp 3.000.000', 'Rp 8.000.000'];
    final progress = [75, 40, 20];
    final influencers = [4, 2, 6];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(titles[index],
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF222222))),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('IN PROGRESS',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.people_outline,
                  size: 13, color: AppColors.grayText),
              const SizedBox(width: 4),
              Text('${influencers[index]} influencers',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.grayText)),
              const SizedBox(width: 12),
              const Icon(Icons.attach_money,
                  size: 13, color: AppColors.grayText),
              const SizedBox(width: 2),
              Text(budgets[index],
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.grayText)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Progress',
                  style: TextStyle(fontSize: 12, color: AppColors.grayText)),
              Text('${progress[index]}%',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress[index] / 100,
              minHeight: 7,
              backgroundColor: AppColors.primary.withValues(alpha: 0.08),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
