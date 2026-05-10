import 'package:flutter/material.dart';

/// Animated progress bar untuk signup flow.
/// [step] dimulai dari 1, [total] adalah jumlah total step.
class SignupProgressBar extends StatefulWidget {
  final int step;
  final int total;

  const SignupProgressBar({super.key, required this.step, this.total = 6});

  @override
  State<SignupProgressBar> createState() => _SignupProgressBarState();
}

class _SignupProgressBarState extends State<SignupProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _anim = Tween<double>(
      begin: (widget.step - 1) / widget.total,
      end: widget.step / widget.total,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: _anim.value,
          minHeight: 5,
          backgroundColor: Colors.grey.shade200,
          valueColor:
              const AlwaysStoppedAnimation<Color>(Color(0xFF2ECC71)),
        ),
      ),
    );
  }
}
