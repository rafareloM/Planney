import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import 'package:planney/model/transaction.model.dart';
import 'package:planney/style/style.dart';

class Category {
  String? uid;
  final String name;
  final TransactionType type;
  final int codePoint;
  final Color color;
  Category({
    this.uid,
    required this.name,
    required this.type,
    required this.codePoint,
    required this.color,
  });

  get keys => null;

  Category copyWith({
    String? name,
    TransactionType? type,
    int? codePoint,
    Color? color,
  }) {
    return Category(
      name: name ?? this.name,
      type: type ?? this.type,
      codePoint: codePoint ?? this.codePoint,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type.name,
      'code_point': codePoint,
      'color': color.value,
    };
  }

  factory Category.fromFirestore(Map<String, dynamic> map) {
    return Category(
      name: map['name'] as String,
      type: EnumToString.fromString(
              [TransactionType.expence, TransactionType.receipt], map['type'])
          as TransactionType,
      codePoint: map['code_point'] as int,
      color: Color(map['color'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Category(name: $name, type: $type, codePoint: $codePoint, color: $color)';
  }
}

abstract class CategoryHelper {
  static List<Category> defaultCategories = [
    Category(
        name: 'Transporte',
        codePoint: Icons.directions_car.codePoint,
        color: AppStyle.chartcolor1,
        type: TransactionType.expence),
    Category(
        name: 'Casa',
        codePoint: Icons.home_filled.codePoint,
        color: AppStyle.chartcolor2,
        type: TransactionType.expence),
    Category(
        name: 'Lazer',
        codePoint: Icons.mood_outlined.codePoint,
        color: AppStyle.chartcolor3,
        type: TransactionType.expence),
    Category(
        name: 'Outros',
        codePoint: Icons.bar_chart.codePoint,
        color: AppStyle.chartcolor4,
        type: TransactionType.expence),
    Category(
        name: 'Juros',
        codePoint: Icons.local_atm.codePoint,
        color: AppStyle.chartcolor1,
        type: TransactionType.receipt),
    Category(
        name: 'Presente',
        codePoint: Icons.redeem.codePoint,
        color: AppStyle.chartcolor2,
        type: TransactionType.receipt),
    Category(
        name: 'Salário',
        codePoint: Icons.payments.codePoint,
        color: AppStyle.chartcolor3,
        type: TransactionType.receipt),
    Category(
        name: 'Outros',
        codePoint: Icons.bar_chart.codePoint,
        color: AppStyle.chartcolor4,
        type: TransactionType.receipt),
  ];

  static List<Map<String, dynamic>> defaultCategoriesToMap() {
    return defaultCategories.map((e) => e.toMap()).toList();
  }
}
