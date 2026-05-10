import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'auth/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _translateAnim;
  late Animation<double> _spacingAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    // Fade: 0 → 1
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Geser dari kiri: -80px → 0px
    _translateAnim = Tween<double>(begin: -80.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    // Letter spacing: 0 → 8
    _spacingAnim = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.headerGradient,
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return Opacity(
                opacity: _fadeAnim.value,
                child: Transform.translate(
                  offset: Offset(_translateAnim.value, 0),
                  child: Text(
                    'KONEKTA',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 32,
                      letterSpacing: _spacingAnim.value,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
