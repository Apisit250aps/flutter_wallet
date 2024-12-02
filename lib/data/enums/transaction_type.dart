enum TransactionType {
  income,
  expense;

  String get value => toString().split('.').last;
}