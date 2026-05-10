import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String username;
  const HeaderWidget({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, $username 👋',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF222222),
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Ready to grow today?',
              style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
            ),
          ],
        ),
        Row(
          children: [
            _IconBtn(
              icon: Icons.notifications_outlined,
              onTap: () {},
            ),
            const SizedBox(width: 8),
            _IconBtn(
              icon: Icons.menu_rounded,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: const Color(0xFF333333)),
      ),
    );
  }
}
