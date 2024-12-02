import 'package:flutter_wallet/data/repositories/auth_repository.dart';
import 'package:flutter_wallet/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepository());
    Get.lazyPut(() => AuthController());
  }
}