import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Data Slide dengan warna yang sangat kontras
  final List<Map<String, dynamic>> _onboardingData = [
    {
      "color": const Color(0xFF004D40), // 1. GREEN (Hijau Botol)
      "title": "The #1 Most Loved\nInfluencer Platform",
      "desc": "Connect with brands, manage campaigns, and grow your influence.",
    },
    {
      "color": const Color(0xFF1A237E), // 2. NAVY (Biru Dongker)
      "title": "Track Your\nGrowth Daily",
      "desc":
          "Get detailed analytics about your audience and campaign performance.",
    },
    {
      "color": const Color(0xFFF57F17), // 3. DARK YELLOW (Kuning Kunyit)
      "title": "Secure Payments\nDirectly",
      "desc":
          "Receive your earnings safely and quickly with our integrated system.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold dibuat putih agar bagian bawah tetap bersih
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Bagian Atas & Tengah (PageView)
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) => setState(() => _currentPage = value),
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // --- BAGIAN VISUAL BERWARNA ---
                    Container(
                      height:
                          MediaQuery.of(context).size.height *
                          0.53, // 50% tinggi layar
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: _onboardingData[index]['color'], // WARNA DI SINI
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Positioned(
                            top: 80,
                            child: Text(
                              'konekta',
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Ilustrasi Kartu Sederhana
                          Positioned(
                            bottom: 70,
                            child: Transform.rotate(
                              angle: -0.2,
                              child: Container(
                                width: 250,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.white30),
                                ),
                                child: const Icon(
                                  Icons.credit_card,
                                  size: 80,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // --- BAGIAN TEKS ---
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _onboardingData[index]['title']!,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _onboardingData[index]['desc']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(135, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // --- BAGIAN STATIS (Indicator & Button) ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                // Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_onboardingData.length, (i) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == i ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: _currentPage == i
                            ? _onboardingData[i]['color']
                            : Colors.grey[300],
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                // Tombol Sign Up
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const WelcomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF24D17E),
                      foregroundColor: const Color(0xFF0B2D24),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Tombol Log in
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          // Sangat Penting: opaque harus false agar background transparan terlihat
                          opaque: false,
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(
                            0.5,
                          ), // Efek gelap pada sisa 10% layar
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const LoginScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                const begin = Offset(0.0, 1.0);
                                const end = Offset.zero;
                                const curve = Curves.easeOutCubic;

                                var tween = Tween(
                                  begin: begin,
                                  end: end,
                                ).chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFF2F2F2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        color: Color(0xFF0B2D24),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
