import 'package:flutter/material.dart';
import '../../widgets/konekta_nav_bar.dart';
import '../brand/brand_dashboard_screen.dart';
import '../brand/brand_explore_screen.dart';
import '../brand/brand_analytics_screen.dart';
import '../brand/brand_profile_screen.dart';

class BrandShell extends StatefulWidget {
  const BrandShell({super.key});

  @override
  State<BrandShell> createState() => _BrandShellState();
}

class _BrandShellState extends State<BrandShell> {
  int _currentIndex = 0;

  static const _pages = [
    BrandDashboardScreen(),
    BrandExploreScreen(),
    BrandAnalyticsScreen(),
    BrandProfileScreen(),
  ];

  static const _icons = [
    Icons.dashboard_outlined,
    Icons.search_rounded,
    Icons.bar_chart_outlined,
    Icons.business_center_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: KonektaNavBar(
        currentIndex: _currentIndex,
        icons: _icons,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}
