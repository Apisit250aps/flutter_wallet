import 'package:flutter_wallet/data/models/transaction.dart';
import 'package:flutter_wallet/data/repositories/transaction_repository.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final TransactionRepository _repository = Get.find<TransactionRepository>();

  final RxList<Transaction> transactions = <Transaction>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;
      error.value = '';
      transactions.value = await _repository.getTransactions();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    try {
      isLoading.value = true;
      error.value = '';
      final newTransaction = await _repository.createTransaction(transaction);
      transactions.add(newTransaction);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTransaction(String id, Transaction transaction) async {
    try {
      isLoading.value = true;
      error.value = '';
      final updatedTransaction = await _repository.updateTransaction(id, transaction);
      final index = transactions.indexWhere((t) => t.id == id);
      if (index != -1) {
        transactions[index] = updatedTransaction;
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTransaction(String id) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _repository.deleteTransaction(id);
      transactions.removeWhere((t) => t.id == id);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}