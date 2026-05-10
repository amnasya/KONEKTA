class UserStats {
  final String username;
  final double thisMonthEarnings;
  final double pendingBalance;
  final int totalViews;
  final int engagement;

  const UserStats({
    required this.username,
    required this.thisMonthEarnings,
    required this.pendingBalance,
    required this.totalViews,
    required this.engagement,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) => UserStats(
        username: json['username'] as String,
        thisMonthEarnings: (json['thisMonthEarnings'] as num).toDouble(),
        pendingBalance: (json['pendingBalance'] as num).toDouble(),
        totalViews: (json['totalViews'] as num).toInt(),
        engagement: (json['engagement'] as num).toInt(),
      );
}

class Campaign {
  final int id;
  final String title;
  final int daysLeft;
  final int progress;
  final int targetViews;
  final int targetEngagement;
  final String status;

  const Campaign({
    required this.id,
    required this.title,
    required this.daysLeft,
    required this.progress,
    required this.targetViews,
    required this.targetEngagement,
    required this.status,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
        id: json['id'] as int,
        title: json['title'] as String,
        daysLeft: (json['daysLeft'] as num).toInt(),
        progress: (json['progress'] as num).toInt(),
        targetViews: (json['targetViews'] as num).toInt(),
        targetEngagement: (json['targetEngagement'] as num).toInt(),
        status: json['status'] as String,
      );
}

class DashboardData {
  final UserStats user;
  final List<Campaign> campaigns;

  const DashboardData({required this.user, required this.campaigns});

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
        user: UserStats.fromJson(json['user'] as Map<String, dynamic>),
        campaigns: (json['campaigns'] as List)
            .map((c) => Campaign.fromJson(c as Map<String, dynamic>))
            .toList(),
      );
}
