import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const KonektaApp());
}

class KonektaApp extends StatelessWidget {
  const KonektaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konekta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
