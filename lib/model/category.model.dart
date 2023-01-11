import 'package:flutter/material.dart';

class TransactionCategories {
  static List<Map<String, int>> expenseCategoriesList = [
    {'Transporte': Icons.directions_car.codePoint},
    {'Casa': Icons.home_filled.codePoint},
    {'Lazer': Icons.mood_outlined.codePoint},
    {'Outros': Icons.bar_chart.codePoint},
  ];

  static List<Map<String, int>> receiptCategoriesList = [
    {'Juros': Icons.local_atm.codePoint},
    {'Presente': Icons.redeem.codePoint},
    {'Salário': Icons.payments.codePoint},
    {'Outros': Icons.bar_chart.codePoint},
  ];

  static addExpenseCategory(
      {required String name, required int iconCodePoint}) {
    expenseCategoriesList.add({name: iconCodePoint});
  }

  static addReceiptCategory({required String name, required int iconHash}) {
    receiptCategoriesList.add({name: iconHash});
  }
}
