import 'package:flutter_wallet/data/repositories/transaction_repository.dart';
import 'package:flutter_wallet/modules/transactions/controllers/transaction_controller.dart';
import 'package:get/get.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionRepository());
    Get.lazyPut(() => TransactionController());
  }
}