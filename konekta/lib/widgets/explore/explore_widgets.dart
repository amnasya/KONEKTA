import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

// ─── Platform Badge ───────────────────────────────────────────────────────────

enum ExplPlatform { tiktok, instagram }

class PlatformBadge extends StatelessWidget {
  final ExplPlatform platform;
  const PlatformBadge({super.key, required this.platform});

  @override
  Widget build(BuildContext context) {
    final isTT = platform == ExplPlatform.tiktok;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isTT ? const Color(0xFF1A1A2E) : AppColors.secondary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isTT ? 'TikTok' : 'Instagram',
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// ─── Section Title ────────────────────────────────────────────────────────────

class ExploreSectionTitle extends StatelessWidget {
  final String title;
  final String emoji;
  const ExploreSectionTitle({super.key, required this.title, required this.emoji});

  @override
  Widget build(BuildContext context) {
    const icons = {
      'fire': Icons.local_fire_department_rounded,
      'star': Icons.star_rounded,
      'building': Icons.business_rounded,
      'box': Icons.inventory_2_outlined,
    };
    return Row(children: [
      Icon(icons[emoji] ?? Icons.circle, color: AppColors.primary, size: 18),
      const SizedBox(width: 6),
      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.darkText)),
    ]);
  }
}

// ─── Search Bar ───────────────────────────────────────────────────────────────

class ExploreSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const ExploreSearchBar({super.key, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.4)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 14, color: AppColors.darkText),
        decoration: const InputDecoration(
          hintText: 'Search campaigns or brands...',
          hintStyle: TextStyle(color: AppColors.lightGray, fontSize: 14),
          prefixIcon: Icon(Icons.search_rounded, color: AppColors.grayText, size: 20),
          suffixIcon: Icon(Icons.tune_rounded, color: AppColors.grayText, size: 20),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14)), borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

// ─── Filter Chip ──────────────────────────────────────────────────────────────

class ExploreFilterChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const ExploreFilterChip({super.key, required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: active ? AppColors.primary : AppColors.accent.withValues(alpha: 0.4)),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: active ? Colors.white : AppColors.grayText)),
      ),
    );
  }
}

// ─── Category Pill ────────────────────────────────────────────────────────────

class ExploreCategoryPill extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const ExploreCategoryPill({super.key, required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: active ? AppColors.primary.withValues(alpha: 0.25) : Colors.black.withValues(alpha: 0.04),
              blurRadius: active ? 10 : 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: active ? Colors.white : AppColors.grayText)),
      ),
    );
  }
}

// ─── Private Access Card ──────────────────────────────────────────────────────

class PrivateAccessCard extends StatelessWidget {
  final TextEditingController controller;
  final String? error;
  final bool success;
  final VoidCallback onUnlock;
  const PrivateAccessCard({super.key, required this.controller, required this.error, required this.success, required this.onUnlock});

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
        Row(children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.lock_outline_rounded, color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: 10),
          const Expanded(child: Text('Have a private access code?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.darkText))),
        ]),
        const SizedBox(height: 6),
        const Text('Enter a code provided by a brand to access exclusive campaigns.', style: TextStyle(fontSize: 11, color: AppColors.grayText, height: 1.4)),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(fontSize: 13, color: AppColors.darkText),
              decoration: InputDecoration(
                hintText: 'Enter access code...',
                hintStyle: const TextStyle(color: AppColors.lightGray, fontSize: 13),
                filled: true,
                fillColor: AppColors.background,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: error != null ? AppColors.error : success ? AppColors.success : AppColors.accent.withValues(alpha: 0.5))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: error != null ? AppColors.error : success ? AppColors.success : AppColors.accent.withValues(alpha: 0.5))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.secondary, width: 1.5)),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onUnlock,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              decoration: BoxDecoration(gradient: AppColors.headerGradient, borderRadius: BorderRadius.circular(10)),
              child: const Text('Unlock', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          ),
        ]),
        if (error != null) ...[
          const SizedBox(height: 6),
          Row(children: [Icon(Icons.error_outline, color: AppColors.error, size: 13), const SizedBox(width: 4), Text(error!, style: TextStyle(fontSize: 11, color: AppColors.error))]),
        ],
        if (success) ...[
          const SizedBox(height: 6),
          Row(children: [Icon(Icons.check_circle_outline, color: AppColors.success, size: 13), const SizedBox(width: 4), Text('Campaign unlocked!', style: TextStyle(fontSize: 11, color: AppColors.success))]),
        ],
      ]),
    );
  }
}

// ─── Info Chip ────────────────────────────────────────────────────────────────

class ExploreInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const ExploreInfoChip({super.key, required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 11, color: color),
        const SizedBox(width: 3),
        Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500)),
      ]),
    );
  }
}

// ─── Empty State ──────────────────────────────────────────────────────────────

class ExploreEmptyState extends StatelessWidget {
  const ExploreEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(40),
      child: Column(children: [
        Icon(Icons.search_off_rounded, size: 52, color: Color(0xFFCCCCCC)),
        SizedBox(height: 12),
        Text('No campaigns found', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.grayText)),
        SizedBox(height: 4),
        Text('Try adjusting your filters', style: TextStyle(fontSize: 12, color: AppColors.lightGray)),
      ]),
    );
  }
}
