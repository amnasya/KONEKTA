import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../widgets/signup_progress_bar.dart';
import 'account_created_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;

  void _next() {
    if (_selectedRole == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => const AccountCreatedScreen(name: '')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Welcome',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: const SizedBox.shrink(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const SignupProgressBar(step: 4),
              const SizedBox(height: 40),
              Text(
                'How are you planning\nto use Konekta?',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: -0.5,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose the role that fits you best.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              // Influencer card
              _RoleCard(
                role: 'influencer',
                selectedRole: _selectedRole,
                icon: Icons.person_outline_rounded,
                title: "I'm an Influencer",
                description:
                    'Connect with brands, manage collaborations, and grow your audience through meaningful partnerships.',
                onTap: () => setState(() => _selectedRole = 'influencer'),
              ),
              const SizedBox(height: 16),
              // Brand card
              _RoleCard(
                role: 'brand',
                selectedRole: _selectedRole,
                icon: Icons.business_center_outlined,
                title: "I'm a Brand",
                description:
                    'Discover influencers, launch campaigns, and track performance to grow your brand reach.',
                onTap: () => setState(() => _selectedRole = 'brand'),
              ),
              const SizedBox(height: 8),
              Text(
                'You can always change your role in account settings.',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEBF5FF),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Color(0xFF007AFF)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _selectedRole != null ? _next : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007AFF),
                          disabledBackgroundColor:
                              Colors.grey.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Next',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Role Card ────────────────────────────────────────────────────────────────

class _RoleCard extends StatelessWidget {
  final String role;
  final String? selectedRole;
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _RoleCard({
    required this.role,
    required this.selectedRole,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  bool get _isSelected => selectedRole == role;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _isSelected
              ? AppColors.primary.withOpacity(0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isSelected
                ? AppColors.primary
                : Colors.grey.withOpacity(0.3),
            width: _isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _isSelected
                    ? AppColors.primary.withOpacity(0.1)
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: _isSelected ? AppColors.primary : Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _isSelected
                          ? AppColors.primary
                          : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              _isSelected
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked,
              color: _isSelected ? AppColors.primary : Colors.grey.shade300,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
