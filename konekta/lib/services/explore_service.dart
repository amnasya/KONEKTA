import 'package:dio/dio.dart';
import '../models/explore_model.dart';

class ExploreService {
  final Dio _dio;

  static const String _baseUrl = 'http://192.168.1.9:3000';

  ExploreService()
      : _dio = Dio(BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ));

  Future<ExploreData> fetchExplore() async {
    try {
      final response = await _dio.get('/api/explore');
      return ExploreData.fromJson(response.data as Map<String, dynamic>);
    } catch (_) {
      return _mockData;
    }
  }

  static final _mockData = ExploreData(
    campaigns: [
      ExploreCampaign(
        id: 1, title: 'Kopi Susu Summer Vibes', brand: 'Kopi Nusantara',
        category: 'Food', description: 'Create engaging content about our new summer kopi susu series.',
        budget: 2000000, deadlineDays: 3, minFollowers: 10000,
        platforms: ['TikTok'], isOpen: true,
      ),
      ExploreCampaign(
        id: 2, title: 'Glow Skincare Review', brand: 'Glow Skincare',
        category: 'Beauty', description: 'Honest review of our new vitamin C serum line for Gen Z audience.',
        budget: 1500000, deadlineDays: 7, minFollowers: 5000,
        platforms: ['Instagram'], isOpen: true,
      ),
      ExploreCampaign(
        id: 3, title: 'TechGear Unboxing', brand: 'TechGear ID',
        category: 'Tech', description: 'Unboxing and first impressions of our latest wireless earbuds.',
        budget: 3500000, deadlineDays: 10, minFollowers: 20000,
        platforms: ['TikTok'], isOpen: true,
      ),
      ExploreCampaign(
        id: 4, title: 'UrbanWear OOTD Challenge', brand: 'UrbanWear',
        category: 'Fashion', description: 'Style our new collection and share your OOTD with #UrbanVibes.',
        budget: 1000000, deadlineDays: 5, minFollowers: 3000,
        platforms: ['Instagram'], isOpen: true,
      ),
      ExploreCampaign(
        id: 5, title: 'FreshMart Healthy Living', brand: 'FreshMart',
        category: 'Lifestyle', description: 'Promote our organic grocery delivery with a healthy recipe video.',
        budget: 2500000, deadlineDays: 0, minFollowers: 8000,
        platforms: ['TikTok'], isOpen: false,
      ),
    ],
    brands: [
      const ExploreBrand(id: 1, name: 'Kopi Nusantara', category: 'F&B', verified: true),
      const ExploreBrand(id: 2, name: 'Glow Skincare', category: 'Beauty', verified: true),
      const ExploreBrand(id: 3, name: 'TechGear ID', category: 'Tech', verified: false),
      const ExploreBrand(id: 4, name: 'UrbanWear', category: 'Fashion', verified: true),
      const ExploreBrand(id: 5, name: 'FreshMart', category: 'Grocery', verified: true),
    ],
  );
}
