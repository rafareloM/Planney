import 'package:flutter/material.dart';

abstract class ExpenseCategory {
  static List<Map<String, IconData>> categories = [
    {'Transporte': Icons.directions_car},
    {'Casa': Icons.home_filled},
    {'Lazer': Icons.mood_outlined},
    {'Outros': Icons.bar_chart},
  ];
  static addCategory({required String name, required IconData icon}) {
    categories.add({name: icon});
  }
}

abstract class ReceiptCategory {
  static List<Map<String, IconData>> categories = [
    {'Juros': Icons.local_atm},
    {'Presente': Icons.redeem},
    {'Salário': Icons.payments},
    {'Outros': Icons.bar_chart},
  ];

  static addCategory({required String name, required IconData icon}) {
    categories.add({name: icon});
  }
}
