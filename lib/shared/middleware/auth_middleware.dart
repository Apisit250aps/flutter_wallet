import 'package:flutter/material.dart';
import 'package:flutter_wallet/shared/services/auth_service.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();
    
    if (!authService.isAuthenticated.value) {
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}