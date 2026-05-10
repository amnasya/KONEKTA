import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../shells/influencer_shell.dart';

class AccountCreatedScreen extends StatefulWidget {
  final String name;
  const AccountCreatedScreen({super.key, required this.name});

  @override
  State<AccountCreatedScreen> createState() => _AccountCreatedScreenState();
}

class _AccountCreatedScreenState extends State<AccountCreatedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _progress;

  final _checks = [
    'Keep me on track with reminders.',
    'Use my phone to track my steps.',
    'Would you like to receive our emails?',
  ];
  final List<bool> _checked = [true, true, true];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    // Full bar (6/6)
    _progress = Tween<double>(begin: 5 / 6, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.name.isEmpty ? 'Alex' : widget.name;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Account Created',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: const SizedBox.shrink(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade200),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Animated progress bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: AnimatedBuilder(
                animation: _progress,
                builder: (_, __) => ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _progress.value,
                    minHeight: 5,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF2ECC71)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 36),
                    // Title
                    Center(
                      child: Text(
                        'Congratulations, $name!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        "Your account is ready and you're one step\ncloser to your first campaign.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Your profile status:',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '100%',
                          style: GoogleFonts.poppins(
                            fontSize: 52,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF007AFF),
                            height: 1,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Complete',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This can help you get:',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'More campaign matches faster',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xFF007AFF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(Icons.info_outline,
                              size: 16, color: Colors.grey.shade400),
                          const SizedBox(width: 6),
                          Text(
                            'How we match you with brands',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Divider(color: Colors.grey.shade200),
                    const SizedBox(height: 16),
                    // Checklist
                    ...List.generate(_checks.length, (i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _checked[i] = !_checked[i]),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: _checked[i]
                                      ? const Color(0xFF007AFF)
                                      : Colors.grey.shade200,
                                  shape: BoxShape.circle,
                                ),
                                child: _checked[i]
                                    ? const Icon(Icons.check,
                                        color: Colors.white, size: 16)
                                    : null,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  _checks[i],
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            // Next button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const InfluencerShell()),
                    (route) => false,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007AFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Finish',
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
      ),
    );
  }
}
