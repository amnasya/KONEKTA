import 'package:flutter/material.dart';
import '../../widgets/profile/profile_widgets.dart';

class InfluencerProfileScreen extends StatelessWidget {
  const InfluencerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8E4F5), Color(0xFFF5F5F5), Color(0xFFFFFFFF)],
            stops: [0.0, 0.35, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(height: 8),
                ProfileHeader(),
                SizedBox(height: 24),
                StatsSection(),
                SizedBox(height: 20),
                PayoutCard(),
                SizedBox(height: 20),
                SettingsMenu(),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
