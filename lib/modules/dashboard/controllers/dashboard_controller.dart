import 'package:flutter_wallet/data/enums/transaction_type.dart';
import 'package:flutter_wallet/data/models/transaction.dart';
import 'package:flutter_wallet/modules/dashboard/repositories/dashboard_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardController extends GetxController {
  final DashboardRepository _repository = Get.find<DashboardRepository>();

  // Observable variables
  final RxDouble totalIncome = 0.0.obs;
  final RxDouble totalExpense = 0.0.obs;
  final RxDouble balance = 0.0.obs;
  final RxMap<String, List<Transaction>> monthlyTransactions = <String, List<Transaction>>{}.obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  
  // Date filter
  final Rx<DateTime> selectedStartDate = DateTime.now().subtract(const Duration(days: 30)).obs;
  final Rx<DateTime> selectedEndDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    calculateSummary();
  }

  // เรียกข้อมูลและคำนวณสรุป
  Future<void> calculateSummary() async {
    try {
      isLoading.value = true;
      error.value = '';
      
      final transactions = await _repository.getTransactions(
        startDate: selectedStartDate.value,
        endDate: selectedEndDate.value,
      );
      
      // Reset values
      totalIncome.value = 0;
      totalExpense.value = 0;
      monthlyTransactions.clear();

      final DateFormat monthFormatter = DateFormat('MMM yyyy');

      // Group and calculate
      for (var transaction in transactions) {
        final monthKey = monthFormatter.format(transaction.createdAt);
        
        // Group by month
        if (!monthlyTransactions.containsKey(monthKey)) {
          monthlyTransactions[monthKey] = [];
        }
        monthlyTransactions[monthKey]!.add(transaction);

        // Calculate totals
        if (transaction.type == TransactionType.income) {
          totalIncome.value += transaction.amount;
        } else {
          totalExpense.value += transaction.amount;
        }
      }

      // Calculate balance
      balance.value = totalIncome.value - totalExpense.value;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // วิเคราะห์ข้อมูลรายเดือน
  List<Map<String, dynamic>> getMonthlyAnalytics() {
    final analytics = <Map<String, dynamic>>[];
    
    monthlyTransactions.forEach((month, transactions) {
      double monthlyIncome = 0;
      double monthlyExpense = 0;

      for (var transaction in transactions) {
        if (transaction.type == TransactionType.income) {
          monthlyIncome += transaction.amount;
        } else {
          monthlyExpense += transaction.amount;
        }
      }

      analytics.add({
        'month': month,
        'income': monthlyIncome,
        'expense': monthlyExpense,
        'balance': monthlyIncome - monthlyExpense,
        'transactionCount': transactions.length,
      });
    });

    // Sort by date (newest first)
    analytics.sort((a, b) {
      final DateFormat format = DateFormat('MMM yyyy');
      final DateTime dateA = format.parse(a['month']);
      final DateTime dateB = format.parse(b['month']);
      return dateB.compareTo(dateA);
    });

    return analytics;
  }

  // วิเคราะห์ตามหมวดหมู่
  Map<String, double> getCategoryAnalytics({TransactionType? type}) {
    final categoryTotals = <String, double>{};

    for (var transactions in monthlyTransactions.values) {
      for (var transaction in transactions) {
        // ถ้าระบุประเภท ให้กรองเฉพาะประเภทนั้น
        if (type != null && transaction.type != type) continue;

        if (!categoryTotals.containsKey(transaction.category)) {
          categoryTotals[transaction.category] = 0;
        }
        categoryTotals[transaction.category] = 
          categoryTotals[transaction.category]! + transaction.amount;
      }
    }

    return categoryTotals;
  }

  // อัพเดตช่วงเวลาที่เลือก
  void updateDateRange(DateTime start, DateTime end) {
    selectedStartDate.value = start;
    selectedEndDate.value = end;
    calculateSummary();
  }

  // คำนวณเปอร์เซ็นต์การเปลี่ยนแปลง
  double calculateGrowthPercentage(double current, double previous) {
    if (previous == 0) return 0;
    return ((current - previous) / previous) * 100;
  }

  // ดึงข้อมูลธุรกรรมล่าสุด
  List<Transaction> getRecentTransactions({int limit = 5}) {
    final allTransactions = monthlyTransactions.values.expand((e) => e).toList();
    allTransactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return allTransactions.take(limit).toList();
  }

  // รีเฟรชข้อมูล
  Future<void> refreshData() async {
    await calculateSummary();
  }

  // ฟอร์แมตจำนวนเงิน
  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      symbol: '฿',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  // ฟอร์แมตเปอร์เซ็นต์
  String formatPercentage(double percentage) {
    return '${percentage.toStringAsFixed(1)}%';
  }
}