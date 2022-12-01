import 'package:flutter/cupertino.dart';

enum TransactionType {
  expence,
  receipt,
}

enum UserAccounts {
  principal,
  outra,
}

class Transaction {
  final TransactionType type;
  final double value;
  final UserAccounts userAccount;
  final Map<String, IconData> category;
  final String description;
  final DateTime date;

  Transaction({
    required this.type,
    required this.value,
    required this.userAccount,
    required this.category,
    required this.description,
    required this.date,
  });
}
