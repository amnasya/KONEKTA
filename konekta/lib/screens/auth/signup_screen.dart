import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/or_divider.dart';
import 'role_selection_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  String get _passwordStrength {
    final p = _passwordController.text;
    if (p.length >= 10 &&
        p.contains(RegExp(r'[A-Z]')) &&
        p.contains(RegExp(r'[0-9]')) &&
        p.contains(RegExp(r'[!@#\$%^&*]'))) { return 'Strong'; }
    if (p.length >= 6) { return 'Medium'; }
    if (p.isNotEmpty) { return 'Weak'; }
    return '';
  }

  Color get _strengthColor {
    switch (_passwordStrength) {
      case 'Strong':
        return Colors.green;
      case 'Medium':
        return Colors.orange;
      case 'Weak':
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }

  double get _strengthValue {
    switch (_passwordStrength) {
      case 'Strong':
        return 1.0;
      case 'Medium':
        return 0.6;
      case 'Weak':
        return 0.25;
      default:
        return 0;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          // Gradient header
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(gradient: AppColors.headerGradient),
            padding: const EdgeInsets.only(top: 52, bottom: 48, left: 20, right: 20),
            child: Column(
              children: [
                // Top nav row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white, size: 16),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: const [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 12),
                            ),
                            Text(
                              'Sign in',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Konekta',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // Card
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF7F7F7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(28, 36, 28, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Get started free.',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkText,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Free forever. No credit card needed.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.grayText,
                      ),
                    ),
                    const SizedBox(height: 28),

                    _buildLabel('Email Address'),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _emailController,
                      hint: 'your@email.com',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 18),

                    _buildLabel('Your name'),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _nameController,
                      hint: 'Full name',
                    ),
                    const SizedBox(height: 18),

                    _buildLabel('Password'),
                    const SizedBox(height: 6),
                    _buildPasswordField(),
                    const SizedBox(height: 28),

                    GradientButton(
                      label: 'Sign up',
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RoleSelectionScreen(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    const OrDivider(text: 'Or sign up with'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        color: AppColors.grayText,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.darkText, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.lightGray, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: AppColors.borderGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: AppColors.borderGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      onChanged: (_) => setState(() {}),
      style: const TextStyle(color: AppColors.darkText, fontSize: 14),
      decoration: InputDecoration(
        hintText: '••••••••',
        hintStyle: const TextStyle(color: AppColors.lightGray, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_passwordStrength.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 36,
                      child: LinearProgressIndicator(
                        value: _strengthValue,
                        backgroundColor: Colors.grey.shade200,
                        color: _strengthColor,
                        minHeight: 4,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _passwordStrength,
                      style: TextStyle(
                        fontSize: 9,
                        color: _strengthColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.grayText,
                size: 20,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: AppColors.borderGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: AppColors.borderGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
