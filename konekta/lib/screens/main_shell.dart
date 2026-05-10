import 'package:flutter/material.dart';
import '../models/user_role.dart';
import 'shells/influencer_shell.dart';
import 'shells/brand_shell.dart';

class MainShell extends StatelessWidget {
  final UserRole role;
  const MainShell({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return role == UserRole.influencer
        ? const InfluencerShell()
        : const BrandShell();
  }
}
