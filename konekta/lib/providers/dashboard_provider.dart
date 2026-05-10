import 'package:flutter/foundation.dart';
import '../models/dashboard_model.dart';
import '../services/dashboard_service.dart';

enum DashboardStatus { idle, loading, success, error }

class DashboardProvider extends ChangeNotifier {
  final DashboardService _service;

  DashboardProvider(this._service);

  DashboardStatus _status = DashboardStatus.idle;
  DashboardData? _data;
  String _errorMessage = '';
  String _searchQuery = '';

  DashboardStatus get status => _status;
  DashboardData? get data => _data;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;

  List<Campaign> get filteredCampaigns {
    if (_data == null) return [];
    if (_searchQuery.isEmpty) return _data!.campaigns;
    return _data!.campaigns
        .where((c) =>
            c.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  Future<void> load(String userId) async {
    _status = DashboardStatus.loading;
    notifyListeners();

    try {
      _data = await _service.fetchDashboard(userId);
      _status = DashboardStatus.success;
    } catch (e) {
      _errorMessage = e.toString();
      _status = DashboardStatus.error;
    }

    notifyListeners();
  }

  void setSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> refresh(String userId) => load(userId);
}
