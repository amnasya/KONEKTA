import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/dashboard_provider.dart';
import '../../services/dashboard_service.dart';
import '../../models/dashboard_model.dart';
import '../../widgets/dashboard/skeleton_loader.dart';

const _navy = Color(0xFF170C79);
const _green = Color(0xFF1B4332);

class InfluencerDashboardScreen extends StatelessWidget {
  const InfluencerDashboardScreen({super.key});
  static const _userId = '1';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider(DashboardService())..load(_userId),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final provider = context.watch<DashboardProvider>();

    if (provider.status == DashboardStatus.loading) {
      return const Scaffold(
        backgroundColor: _navy,
        body: DashboardSkeletonLoader(),
      );
    }

    if (provider.status == DashboardStatus.error) {
      return Scaffold(
        backgroundColor: _navy,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                size: 56,
                color: Colors.white38,
              ),
              const SizedBox(height: 16),
              const Text(
                'Something went wrong.',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () =>
                    provider.refresh(InfluencerDashboardScreen._userId),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: _navy,
                  shape: const StadiumBorder(),
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final data = provider.data;
    if (data == null) return const SizedBox.shrink();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: RefreshIndicator(
        color: _navy,
        onRefresh: () => provider.refresh(InfluencerDashboardScreen._userId),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Curved navy header ──
              Stack(
                children: [
                  Container(height: 250, width: double.infinity, color: _navy),
                  // Decorative circle
                  Positioned(
                    top: -50,
                    right: -50,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Hi ${data.user.username}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              _ToggleSwitch(),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Welcome to Konekta Dashboard',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 35),
                          const Text(
                            'Summary',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _SummaryCard(data: data),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ── Analytics Section ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Analytics',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Your content performance',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),

                    // Chart card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Views (7 Days)',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _Bar(height: 55, label: 'Mon'),
                              _Bar(height: 80, label: 'Tue'),
                              _Bar(height: 65, label: 'Wed'),
                              _Bar(height: 100, label: 'Thu', highlighted: true),
                              _Bar(height: 85, label: 'Fri'),
                              _Bar(height: 70, label: 'Sat'),
                              _Bar(height: 90, label: 'Sun'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Metrics grid
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 1.6,
                      children: const [
                        _MetricCard(
                          label: 'Total Views',
                          value: '24.8K',
                          delta: '+12%',
                          positive: true,
                        ),
                        _MetricCard(
                          label: 'Engagement',
                          value: '2.3K',
                          delta: '+8%',
                          positive: true,
                        ),
                        _MetricCard(
                          label: 'Followers',
                          value: '18.4K',
                          delta: '+3%',
                          positive: true,
                        ),
                        _MetricCard(
                          label: 'Avg. Watch',
                          value: '1m 42s',
                          delta: '-2%',
                          positive: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ── Campaign list ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        print("Lihat semua campaign");
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Your Active Campaigns',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: Colors.grey,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...List.generate(provider.filteredCampaigns.length, (i) {
                      final c = provider.filteredCampaigns[i];
                      return Column(
                        children: [
                          _CampaignItem(campaign: c),
                          if (i < provider.filteredCampaigns.length - 1)
                            const Divider(height: 1, thickness: 1),
                        ],
                      );
                    }),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Header Clipper ───────────────────────────────────────────────────────────

class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// ─── Toggle Switch ────────────────────────────────────────────────────────────

class _ToggleSwitch extends StatefulWidget {
  @override
  State<_ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<_ToggleSwitch> {
  bool _on = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _on = !_on),
      child: Container(
        width: 55,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: _on ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: CircleAvatar(
              radius: 11,
              backgroundColor: _navy,
              child: const Icon(Icons.flash_on, size: 14, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Summary Card ─────────────────────────────────────────────────────────────

class _SummaryCard extends StatelessWidget {
  final DashboardData data;
  const _SummaryCard({required this.data});

  // Pakai thisMonthEarnings dari UserStats karena Campaign tidak punya field price
  double get _totalEarnings => data.user.thisMonthEarnings;

  String get _formatted {
    final n = _totalEarnings.toStringAsFixed(0);
    return n.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: _navy.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'Total Earnings',
              style: TextStyle(
                  color: _navy, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'IDR $_formatted',
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.check_circle_outline,
                  color: Colors.green, size: 16),
              const SizedBox(width: 6),
              Text(
                'From ${data.campaigns.length} active campaigns',
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Campaign Item ────────────────────────────────────────────────────────────

class _CampaignItem extends StatelessWidget {
  final Campaign campaign;
  const _CampaignItem({required this.campaign});

  static const _avatarColors = [
    Color(0xFF1A1A1A),
    Color(0xFFCC0000),
    Color(0xFF0057B8),
    Color(0xFF1B4332),
    Color(0xFF8B4513),
    Color(0xFF4B0082),
  ];

  Color get _avatarColor => _avatarColors[campaign.id % _avatarColors.length];

  String get _timeLeft =>
      campaign.daysLeft > 0 ? '${campaign.daysLeft} hari lagi' : 'Hari ini';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: [
          // Logo circle
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _avatarColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200, width: 1.5),
            ),
            child: Center(
              child: Text(
                campaign.title.length >= 2
                    ? campaign.title.substring(0, 2).toUpperCase()
                    : campaign.title[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  campaign.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _green,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: campaign.progress / 100,
                    minHeight: 5,
                    backgroundColor: Colors.grey.shade200,
                    color: _navy,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${campaign.progress}%',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _navy,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '• $_timeLeft',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 1),
          // Status button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              'In progress',
              style: TextStyle(
                color: _green,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Analytics Bar ────────────────────────────────────────────────────────────

class _Bar extends StatelessWidget {
  final double height;
  final String label;
  final bool highlighted;
  const _Bar({
    required this.height,
    required this.label,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 26,
          height: height,
          decoration: BoxDecoration(
            gradient: highlighted
                ? const LinearGradient(
                    colors: [Color(0xFF170C79), Color(0xFF4A3AFF)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
            color: highlighted ? null : _navy.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }
}

// ─── Analytics Metric Card ────────────────────────────────────────────────────

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String delta;
  final bool positive;
  const _MetricCard({
    required this.label,
    required this.value,
    required this.delta,
    required this.positive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              Text(
                delta,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: positive ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
