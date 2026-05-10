import 'package:flutter/material.dart';
import 'package:konekta/screens/auth/email_login_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Kita pakai Align untuk menaruh konten di bawah
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        // Mengambil 90% tinggi layar, menyisakan 10% di atas
        height: MediaQuery.of(context).size.height * 0.9,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: Scaffold(
            // Memberikan lengkungan pada bagian atas Scaffold
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  // Handle bar kecil (garis abu-abu) supaya terlihat seperti modal
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Header: Tombol Cancel
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Judul Utama
                  const Text(
                    'Sign in to continue',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 23),

                  // Daftar Tombol Login
                  // Di dalam LoginScreen, pada tombol Email:
                  _socialButton(
                    label: 'Continue with Email',
                    color: const Color(0xFF0052FF),
                    icon: Icons.email,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          // Penting agar layar di bawahnya tetap terlihat sedikit di celah 10%
                          opaque: false,
                          transitionDuration: const Duration(
                            milliseconds: 300,
                          ), // Durasi sedikit lebih lama agar halus
                          reverseTransitionDuration: const Duration(
                            milliseconds: 300,
                          ),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const EmailLoginScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                // Gunakan Offset dari kanan (1,0) ke tengah (0,0)
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;

                                // Curve 'easeInOutQuart' atau 'cubicBezier' memberikan feel yang sangat premium dan smooth
                                const curve = Curves.easeInOutQuart;

                                var tween = Tween(
                                  begin: begin,
                                  end: end,
                                ).chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);

                                // Tambahkan FadeTransition juga agar transisinya tidak kaku (optional tapi disarankan)
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                );
                              },
                        ),
                      );
                    },
                  ),
                  _socialButton(
                    label: 'Continue with Google',
                    color: Colors.white,
                    icon: Icons.g_mobiledata,
                    textColor: Colors.black,
                    hasBorder: true,
                    onPressed: () {},
                  ),
                  _socialButton(
                    label: 'Continue with Apple',
                    color: Colors.black,
                    icon: Icons.apple,
                    textColor: Colors.white,
                    onPressed: () {},
                  ),
                  _socialButton(
                    label: 'Continue with Facebook',
                    color: const Color(0xFF1877F2),
                    icon: Icons.facebook,
                    textColor: Colors.white,
                    onPressed: () {},
                  ),
                  _socialButton(
                    label: 'Continue with KakaoTalk',
                    color: const Color(0xFFFFE812),
                    icon: Icons.chat_bubble,
                    textColor: Colors.black,
                    onPressed: () {},
                  ),
                  _socialButton(
                    label: 'Continue with LINE',
                    color: const Color(0xFF00C300),
                    icon: Icons.line_weight,
                    textColor: Colors.white,
                    onPressed: () {},
                  ),

                  const Spacer(),

                  // Footer: Link Sign Up
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Sign up diklik");
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: Color(0xFF0052FF),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    required String label,
    required Color color,
    required IconData icon,
    required Color textColor,
    bool hasBorder = false,
    VoidCallback? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: textColor,
            elevation: 0,
            side: hasBorder ? const BorderSide(color: Colors.black12) : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 24),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
