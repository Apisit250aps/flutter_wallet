
import 'package:flutter_wallet/modules/auth/bindings/auth_binding.dart';
import 'package:flutter_wallet/modules/auth/views/forgot_password_screen.dart';
import 'package:flutter_wallet/modules/auth/views/login_screen.dart';
import 'package:flutter_wallet/modules/auth/views/register_screen.dart';
import 'package:flutter_wallet/sample_view.dart';
import 'package:flutter_wallet/shared/middleware/auth_middleware.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL = '/login';

  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/forgot-password',
      page: () => ForgotPasswordScreen(),
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