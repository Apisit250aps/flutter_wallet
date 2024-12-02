import 'package:flutter_wallet/data/enums/transaction_type.dart';

class Transaction {
  final String id;
  final String userId;
  final double amount;
  final TransactionType type;
  final String category;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.category,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    amount: (json['amount'] as num).toDouble(),
    type: json['type'] == 'income' ? TransactionType.income : TransactionType.expense,
    category: json['category'] as String,
    description: json['description'] as String,
    createdAt: DateTime.parse(json['created_at'] as String),
    updatedAt: DateTime.parse(json['updated_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'amount': amount,
    'type': type.value,
    'category': category,
    'description': description,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}