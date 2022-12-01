import 'package:flutter/material.dart';
import 'package:planney/model/transaction.model.dart';

List<Transaction> transactions = [
  Transaction(
    type: TransactionType.expence,
    value: 15,
    userAccount: UserAccounts.principal,
    category: {'Outros': Icons.bar_chart},
    description: 'Cerveja',
    date: DateTime.now(),
  ),
  Transaction(
    type: TransactionType.expence,
    value: 17,
    userAccount: UserAccounts.principal,
    category: {'Lazer': Icons.mood_outlined},
    description: 'Carne',
    date: DateTime.now(),
  ),
  Transaction(
    type: TransactionType.expence,
    value: 22,
    userAccount: UserAccounts.principal,
    category: {'Transporte': Icons.directions_car},
    description: 'Brrrauni',
    date: DateTime.now(),
  ),
  Transaction(
    type: TransactionType.expence,
    value: 4,
    userAccount: UserAccounts.principal,
    category: {'Transporte': Icons.directions_car},
    description: 'Biscoito',
    date: DateTime.now(),
  ),
  Transaction(
    type: TransactionType.expence,
    value: 20,
    userAccount: UserAccounts.principal,
    category: {'Lazer': Icons.mood_outlined},
    description: 'Cerveja',
    date: DateTime.now(),
  ),
];
