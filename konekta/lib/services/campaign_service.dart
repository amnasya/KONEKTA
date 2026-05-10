import 'package:dio/dio.dart';
import '../models/campaign_detail_model.dart';

class CampaignService {
  final Dio _dio;

  static const String _baseUrl = 'http://192.168.1.9:3000';

  CampaignService()
      : _dio = Dio(BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ));

  Future<CampaignDetail> fetchCampaignDetail(int id, {int userId = 1}) async {
    final response = await _dio.get(
      '/api/campaign/$id',
      queryParameters: {'userId': userId},
    );
    return CampaignDetail.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> applyToCampaign(int campaignId, {int userId = 1}) async {
    await _dio.post(
      '/api/campaign/$campaignId/apply',
      data: {'userId': userId},
    );
  }
}
