import 'package:flutter_wallet/app/config/api_config.dart';
import 'package:flutter_wallet/data/models/transaction.dart';
import 'package:flutter_wallet/shared/network/api_provider.dart';
import 'package:get/get.dart';

class DashboardRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<List<Transaction>> getTransactions({DateTime? startDate, DateTime? endDate}) async {
    final queryParams = <String, dynamic>{};
    
    if (startDate != null) {
      queryParams['start_date'] = startDate.toIso8601String();
    }
    if (endDate != null) {
      queryParams['end_date'] = endDate.toIso8601String();
    }

    final response = await _apiProvider.get(
      ApiConfig.transactions,
      queryParameters: queryParams,
    );

    return (response.data['data'] as List)
        .map((json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Map<String, dynamic>> getSummary() async {
    final response = await _apiProvider.get('${ApiConfig.transactions}/summary');
    return response.data['data'];
  }
}