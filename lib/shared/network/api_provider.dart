import 'package:dio/dio.dart';
import 'package:flutter_wallet/app/config/api_config.dart';
import 'package:flutter_wallet/shared/network/api_exception.dart';
import 'package:flutter_wallet/shared/network/interceptors/auth_interceptor.dart';
import 'package:flutter_wallet/shared/storage/storage_service.dart';
import 'package:get/get.dart' hide Response;

class ApiProvider {
  late final Dio _dio;
  final StorageService _storage = Get.find<StorageService>();

  ApiProvider() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        headers: ApiConfig.headers,
        connectTimeout: Duration(milliseconds: ApiConfig.connectionTimeout),
        receiveTimeout: Duration(milliseconds: ApiConfig.receiveTimeout),
      ),
    );
    _initializeInterceptors();
  }

  void _initializeInterceptors() {
    _dio.interceptors.add(AuthInterceptor(_storage));
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(String path, {dynamic data}) async {
    try {
      final response = await _dio.delete(path, data: data);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Add other methods (put, delete, etc.)

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ApiException('Connection timeout');
        case DioExceptionType.receiveTimeout:
          return ApiException('Server not responding');
        case DioExceptionType.badResponse:
          return _handleBadResponse(error.response);
        default:
          return ApiException('Something went wrong');
      }
    }
    return ApiException('Unknown error occurred');
  }

  ApiException _handleBadResponse(Response? response) {
    switch (response?.statusCode) {
      case 400:
        return ApiException('Bad request');
      case 401:
        return UnauthorizedException();
      case 403:
        return ApiException('Forbidden');
      case 404:
        return ApiException('Not found');
      case 500:
        return ApiException('Internal server error');
      default:
        return ApiException('Something went wrong');
    }
  }
}