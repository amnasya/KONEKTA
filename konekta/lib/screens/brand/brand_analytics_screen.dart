import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class BrandAnalyticsScreen extends StatelessWidget {
  const BrandAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Campaign Analytics',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkText)),
              const SizedBox(height: 4),
              const Text('Track your campaign performance',
                  style: TextStyle(fontSize: 13, color: AppColors.grayText)),
              const SizedBox(height: 24),

              // ROI card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppColors.headerGradient,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 6))
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Overall ROI',
                        style: TextStyle(color: Colors.white70, fontSize: 13)),
                    SizedBox(height: 6),
                    Text('3.2x',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w800)),
                    Text('Return on investment across all campaigns',
                        style: TextStyle(color: Colors.white60, fontSize: 11)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Reach chart
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Reach (Monthly)',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkText)),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _Bar(height: 60, label: 'Jan'),
                        _Bar(height: 90, label: 'Feb'),
                        _Bar(height: 75, label: 'Mar'),
                        _Bar(height: 110, label: 'Apr', highlighted: true),
                        _Bar(height: 95, label: 'May'),
                        _Bar(height: 130, label: 'Jun'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.6,
                children: const [
                  _MetricCard(label: 'Total Reach', value: '148K', delta: '+22%', positive: true),
                  _MetricCard(label: 'Conversions', value: '1.2K', delta: '+15%', positive: true),
                  _MetricCard(label: 'Cost/Click', value: 'Rp 420', delta: '-8%', positive: true),
                  _MetricCard(label: 'Avg. Engagement', value: '4.8%', delta: '+3%', positive: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final double height;
  final String label;
  final bool highlighted;
  const _Bar({required this.height, required this.label, this.highlighted = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 28,
          height: height,
          decoration: BoxDecoration(
            gradient: highlighted ? AppColors.headerGradient : null,
            color: highlighted ? null : AppColors.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: const TextStyle(fontSize: 10, color: AppColors.grayText)),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String delta;
  final bool positive;
  const _MetricCard(
      {required this.label,
      required this.value,
      required this.delta,
      required this.positive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 11, color: AppColors.grayText)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkText)),
              Text(delta,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: positive ? Colors.green : Colors.red)),
            ],
          ),
        ],
      ),
    );
  }
}
