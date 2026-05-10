import 'package:dio/dio.dart';
import '../models/dashboard_model.dart';

class DashboardService {
  final Dio _dio;

  // Change to your machine's local IP when running on a real device
  // e.g. 'http://192.168.1.x:3000'
  static const String _baseUrl = 'http://192.168.1.9:3000';

  DashboardService()
      : _dio = Dio(BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ));

  Future<DashboardData> fetchDashboard(String userId) async {
    try {
      final response = await _dio.get('/api/dashboard/$userId');
      return DashboardData.fromJson(response.data as Map<String, dynamic>);
    } catch (_) {
      // Fallback to mock data when backend is unavailable
      return _mockDashboard;
    }
  }

  static final _mockDashboard = DashboardData(
    user: const UserStats(
      username: 'Amna',
      thisMonthEarnings: 3467420,
      pendingBalance: 1250000,
      totalViews: 24800,
      engagement: 2300,
    ),
    campaigns: [
      Campaign(
        id: 1,
        title: 'Kopi Susu Summer Vibes',
        daysLeft: 5,
        progress: 75,
        targetViews: 50000,
        targetEngagement: 5000,
        status: 'IN PROGRESS',
      ),
      Campaign(
        id: 2,
        title: 'Skincare Glow',
        daysLeft: 10,
        progress: 40,
        targetViews: 30000,
        targetEngagement: 3000,
        status: 'IN PROGRESS',
      ),
    ],
  );
}
