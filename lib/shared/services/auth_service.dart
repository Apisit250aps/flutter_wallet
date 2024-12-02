import 'dart:convert';

import 'package:flutter_wallet/data/models/user.dart';
import 'package:flutter_wallet/shared/storage/storage_service.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final StorageService _storage = Get.find<StorageService>();

  final Rx<User?> currentUser = Rx<User?>(null);
  final RxBool isAuthenticated = false.obs;

  Future<AuthService> init() async {
    await _loadUser();
    return this;
  }

  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final userStr = await _storage.getUser();
    if (userStr != null) {
      currentUser.value = User.fromJson(json.decode(userStr));
      isAuthenticated.value = true;
    }
  }

  Future<void> saveUserAndToken(User user, String token) async {
    await _storage.saveToken(token);
    await _storage.saveUser(json.encode(user.toJson()));
    currentUser.value = user;
    isAuthenticated.value = true;
  }

  Future<void> logout() async {
    await _storage.clearAll();
    currentUser.value = null;
    isAuthenticated.value = false;
    Get.offAllNamed('/login');
  }
}
