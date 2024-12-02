import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  late final SharedPreferences _prefs;
  
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // Token Management
  Future<bool> saveToken(String token) async {
    return await _prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    return _prefs.getString('token');
  }

  Future<bool> clearToken() async {
    return await _prefs.remove('token');
  }

  // User Data
  Future<bool> saveUser(String userData) async {
    return await _prefs.setString('user', userData);
  }

  Future<String?> getUser() async {
    return _prefs.getString('user');
  }

  // Clear All Data
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}