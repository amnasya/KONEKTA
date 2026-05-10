import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class BrandExploreScreen extends StatelessWidget {
  const BrandExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Find Influencers',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkText)),
              const SizedBox(height: 4),
              const Text('Discover creators for your campaigns',
                  style: TextStyle(fontSize: 13, color: AppColors.grayText)),
              const SizedBox(height: 16),

              // Filter chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['All', 'Lifestyle', 'Tech', 'Fashion', 'Food', 'Travel']
                      .map((cat) => _FilterChip(label: cat, selected: cat == 'All'))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                decoration: InputDecoration(
                  hintText: 'Search influencers…',
                  hintStyle: const TextStyle(
                      color: AppColors.lightGray, fontSize: 14),
                  prefixIcon: const Icon(Icons.search,
                      color: AppColors.grayText),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              const SizedBox(height: 20),

              const Text('Top Influencers',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkText)),
              const SizedBox(height: 12),

              Expanded(
                child: ListView.separated(
                  itemCount: 6,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => _InfluencerCard(index: i),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _FilterChip({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: selected ? Colors.white : AppColors.grayText)),
    );
  }
}

class _InfluencerCard extends StatelessWidget {
  final int index;
  const _InfluencerCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final names = ['Alex Rivera', 'Mia Chen', 'Jordan Lee', 'Sam Park', 'Taylor Kim', 'Casey Wu'];
    final cats = ['Lifestyle', 'Tech', 'Fashion', 'Food', 'Travel', 'Fitness'];
    final followers = ['24.5K', '18.2K', '52.1K', '9.8K', '31.4K', '15.7K'];
    final rates = ['Rp 2–4M', 'Rp 1–3M', 'Rp 5–8M', 'Rp 1–2M', 'Rp 3–5M', 'Rp 2–3M'];

    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary.withValues(alpha: 0.15),
            child: Text(names[index][0],
                style: const TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(names[index],
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkText)),
                Text('${cats[index]} · ${followers[index]} followers',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.grayText)),
                Text('Rate: ${rates[index]}',
                    style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              gradient: AppColors.headerGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('Invite',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
