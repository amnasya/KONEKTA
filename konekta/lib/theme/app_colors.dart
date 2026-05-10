import 'package:flutter/material.dart';

class AppColors {
  // ─── Brand Palette ───────────────────────────────────────────────────────────
  static const Color primary    = Color(0xFF241A7A); // Deep Indigo
  static const Color secondary  = Color(0xFF5BA6B0); // Muted Teal
  static const Color accent     = Color(0xFF4DD0E1); // Soft Aqua
  static const Color beige      = Color(0xFFF5F0E8); // Warm Beige

  // ─── Legacy aliases (keep for backward compat) ───────────────────────────────
  static const Color purple     = primary;
  static const Color blue       = secondary;

  // ─── Text ────────────────────────────────────────────────────────────────────
  static const Color darkText   = Color(0xFF333333);
  static const Color grayText   = Color(0xFF888888);
  static const Color lightGray  = Color(0xFFAAAAAA);

  // ─── Surfaces ────────────────────────────────────────────────────────────────
  static const Color background = Color(0xFFF5F5F5);
  static const Color cardBg     = Color(0xFFFFFFFF);
  static const Color white      = Colors.white;

  // ─── Borders & Dividers ──────────────────────────────────────────────────────
  static const Color borderGray   = Color(0xFFE0E0E0);
  static const Color dividerGray  = Color(0xFFCCCCCC);
  static const Color accentBorder = accent; // Soft Aqua for inputs

  // ─── Field ───────────────────────────────────────────────────────────────────
  static const Color fieldBg     = Color(0x1A241A7A); // primary @ 10%
  static const Color fieldBorder = Color(0x4D5BA6B0); // secondary @ 30%

  // ─── Gradients ───────────────────────────────────────────────────────────────
  /// Main header / primary button gradient: Deep Indigo → slightly lighter indigo
  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF241A7A), Color(0xFF3D2FA8)],
  );

  /// Teal gradient for secondary surfaces
  static const LinearGradient tealGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5BA6B0), AppColors.accent],
  );

  // ─── Status Colors ───────────────────────────────────────────────────────────
  static const Color statusOpen       = secondary;  // Muted Teal
  static const Color statusInProgress = primary;    // Deep Indigo
  static const Color statusCompleted  = Color(0xFF888888); // Neutral gray
  static const Color statusClosed     = Color(0xFFAAAAAA);

  // ─── Utility ─────────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF3DAA6E);
  static const Color error   = Color(0xFFD94F4F);
  static const Color warning = Color(0xFFE09B3D);
}
