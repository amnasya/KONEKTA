import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../influencer/influencer_dashboard_screen.dart';
import '../influencer/influencer_explore_screen.dart';
import '../influencer/influencer_profile_screen.dart';

class InfluencerShell extends StatefulWidget {
  const InfluencerShell({super.key});

  @override
  State<InfluencerShell> createState() => _InfluencerShellState();
}

class _InfluencerShellState extends State<InfluencerShell> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    InfluencerDashboardScreen(),
    InfluencerExploreScreen(),
    InfluencerProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 47,
            child: Row(
              children: [
                _NavItem(icon: LucideIcons.home, selected: _selectedIndex == 0, onTap: () => _onItemTapped(0)),
                _NavItem(icon: LucideIcons.search, selected: _selectedIndex == 1, onTap: () => _onItemTapped(1)),
                _NavItem(icon: LucideIcons.user, selected: _selectedIndex == 2, onTap: () => _onItemTapped(2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({required this.icon, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Icon(
            icon,
            size: 24,
            color: selected ? Colors.black : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}
