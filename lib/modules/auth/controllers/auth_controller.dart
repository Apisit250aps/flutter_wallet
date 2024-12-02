import 'package:flutter_wallet/data/repositories/auth_repository.dart';
import 'package:flutter_wallet/shared/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final AuthService _authService = Get.find<AuthService>();

  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await _authRepository.login(username, password);
      await _authService.saveUserAndToken(response.user, response.token);

      Get.offAllNamed('/dashboard');
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String username, String email, String password) async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await _authRepository.register(username, email, password);
      await _authService.saveUserAndToken(response.user, response.token);

      Get.offAllNamed('/dashboard');
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    _authService.logout();
  }
}