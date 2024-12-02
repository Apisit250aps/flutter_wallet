
import 'package:flutter_wallet/modules/auth/bindings/auth_binding.dart';
import 'package:flutter_wallet/sample_view.dart';
import 'package:flutter_wallet/shared/middleware/auth_middleware.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL = '/login';

  static final routes = [
    GetPage(
      name: '/login',
      page: () => SampleView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/register',
      page: () => SampleView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/dashboard',
      page: () => SampleView(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
    // Add other protected routes with AuthMiddleware
  ];
}