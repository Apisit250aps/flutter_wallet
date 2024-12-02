import 'package:flutter_wallet/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter_wallet/modules/dashboard/repositories/dashboard_repository.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardRepository());
    Get.lazyPut(() => DashboardController());
  }
}