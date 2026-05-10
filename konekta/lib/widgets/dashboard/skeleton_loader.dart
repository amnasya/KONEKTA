import 'package:flutter/material.dart';

class DashboardSkeletonLoader extends StatefulWidget {
  const DashboardSkeletonLoader({super.key});

  @override
  State<DashboardSkeletonLoader> createState() => _DashboardSkeletonLoaderState();
}

class _DashboardSkeletonLoaderState extends State<DashboardSkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Opacity(
        opacity: _animation.value,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header skeleton
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Bone(width: 160, height: 22),
                      const SizedBox(height: 6),
                      _Bone(width: 120, height: 14),
                    ],
                  ),
                  Row(children: [
                    _Bone(width: 40, height: 40, radius: 12),
                    const SizedBox(width: 8),
                    _Bone(width: 40, height: 40, radius: 12),
                  ]),
                ],
              ),
              const SizedBox(height: 20),
              _Bone(width: double.infinity, height: 48, radius: 14),
              const SizedBox(height: 20),
              _Bone(width: double.infinity, height: 140, radius: 20),
              const SizedBox(height: 20),
              Row(children: [
                Expanded(child: _Bone(width: double.infinity, height: 80, radius: 18)),
                const SizedBox(width: 14),
                Expanded(child: _Bone(width: double.infinity, height: 80, radius: 18)),
              ]),
              const SizedBox(height: 24),
              _Bone(width: 140, height: 18),
              const SizedBox(height: 12),
              _Bone(width: double.infinity, height: 130, radius: 18),
              const SizedBox(height: 14),
              _Bone(width: double.infinity, height: 130, radius: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bone extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const _Bone({
    required this.width,
    required this.height,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
