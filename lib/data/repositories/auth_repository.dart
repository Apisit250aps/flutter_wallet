import 'package:flutter_wallet/app/config/api_config.dart';
import 'package:flutter_wallet/data/models/response/api_response.dart';
import 'package:flutter_wallet/data/models/response/auth_response.dart';
import 'package:flutter_wallet/shared/network/api_provider.dart';
import 'package:get/get.dart';

class AuthRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<AuthResponse> login(String username, String password) async {
    final response = await _apiProvider.post(
      ApiConfig.login,
      data: {
        'username': username,
        'password': password,
      },
    );

    return ApiResponse.fromJson(
      response.data,
      (json) => AuthResponse.fromJson(json),
    ).data!;
  }

  Future<AuthResponse> register(String username, String email, String password) async {
    final response = await _apiProvider.post(
      ApiConfig.register,
      data: {
        'username': username,
        'email': email,
        'password': password,
      },
    );

    return ApiResponse.fromJson(
      response.data,
      (json) => AuthResponse.fromJson(json),
    ).data!;
  }
}