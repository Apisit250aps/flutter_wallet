import 'package:flutter_wallet/app/config/api_config.dart';
import 'package:flutter_wallet/data/models/response/api_response.dart';
import 'package:flutter_wallet/data/models/transaction.dart';
import 'package:flutter_wallet/shared/network/api_provider.dart';
import 'package:get/get.dart';

class TransactionRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<List<Transaction>> getTransactions() async {
    final response = await _apiProvider.get(ApiConfig.transactions);
    
    return ApiResponse.fromJson(
      response.data,
      (json) => (json as List)
          .map((item) => Transaction.fromJson(item))
          .toList(),
    ).data!;
  }

  Future<Transaction> createTransaction(Transaction transaction) async {
    final response = await _apiProvider.post(
      ApiConfig.transactions,
      data: transaction.toJson(),
    );

    return ApiResponse.fromJson(
      response.data,
      (json) => Transaction.fromJson(json),
    ).data!;
  }

  Future<Transaction> updateTransaction(String id, Transaction transaction) async {
    final response = await _apiProvider.put(
      '${ApiConfig.transactions}/$id',
      data: transaction.toJson(),
    );

    return ApiResponse.fromJson(
      response.data,
      (json) => Transaction.fromJson(json),
    ).data!;
  }

  Future<void> deleteTransaction(String id) async {
    await _apiProvider.delete('${ApiConfig.transactions}/$id');
  }
}