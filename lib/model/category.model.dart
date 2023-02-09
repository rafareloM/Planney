import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import 'package:planney/model/transaction.model.dart';
import 'package:planney/style/style.dart';

class Category {
  String? uid;
  final String name;
  final TransactionType type;
  final IconData icon;
  final Color color;
  Category({
    this.uid,
    required this.name,
    required this.type,
    required this.icon,
    required this.color,
  });

  get keys => null;

  Category copyWith({
    String? name,
    TransactionType? type,
    IconData? icon,
    Color? color,
  }) {
    return Category(
      name: name ?? this.name,
      type: type ?? this.type,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type.name,
      'icon': icon.codePoint,
      'color': color.value,
    };
  }

  factory Category.fromFirestore(Map<String, dynamic> map) {
    return Category(
      name: map['name'] as String,
      type: EnumToString.fromString(
              [TransactionType.expence, TransactionType.receipt], map['type'])
          as TransactionType,
      icon: IconData(map['icon'] as int, fontFamily: 'MaterialIcons'),
      color: Color(map['color'] as int),
    );
  }

  @override
  String toString() {
    return 'Category(name: $name, type: $type, icon: $icon, color: $color)';
  }
}

abstract class CategoryHelper {
  static List<Category> defaultCategories = [
    Category(
        name: 'Transporte',
        icon: Icons.directions_car,
        color: AppStyle.chartcolor1,
        type: TransactionType.expence),
    Category(
        name: 'Casa',
        icon: Icons.home_filled,
        color: AppStyle.chartcolor2,
        type: TransactionType.expence),
    Category(
        name: 'Lazer',
        icon: Icons.mood_outlined,
        color: AppStyle.chartcolor3,
        type: TransactionType.expence),
    Category(
        name: 'Outros',
        icon: Icons.bar_chart,
        color: AppStyle.chartcolor4,
        type: TransactionType.expence),
    Category(
        name: 'Juros',
        icon: Icons.local_atm,
        color: AppStyle.chartcolor1,
        type: TransactionType.receipt),
    Category(
        name: 'Presente',
        icon: Icons.redeem,
        color: AppStyle.chartcolor2,
        type: TransactionType.receipt),
    Category(
        name: 'Salário',
        icon: Icons.payments,
        color: AppStyle.chartcolor3,
        type: TransactionType.receipt),
    Category(
        name: 'Outros',
        icon: Icons.bar_chart,
        color: AppStyle.chartcolor4,
        type: TransactionType.receipt),
  ];
  static List<Icon> icons = const [
    Icon(Icons.percent),
    Icon(Icons.account_balance_wallet),
    Icon(Icons.card_giftcard),
    Icon(Icons.favorite),
    Icon(Icons.attach_money),
    Icon(Icons.restaurant),
    Icon(Icons.shopping_cart),
    Icon(Icons.flight_takeoff),
    Icon(Icons.directions_car),
    Icon(Icons.home_filled),
    Icon(Icons.build),
    Icon(Icons.store),
    Icon(Icons.videogame_asset),
    Icon(Icons.more_horiz),
    Icon(Icons.face),
    Icon(Icons.theater_comedy),
    Icon(Icons.laptop),
    Icon(Icons.palette),
    Icon(Icons.content_cut),
    Icon(Icons.volunteer_activism),
    Icon(Icons.music_note),
    Icon(Icons.local_hotel),
    Icon(Icons.medical_services),
    Icon(Icons.school),
  ];

  static List<Map<String, dynamic>> defaultCategoriesToMap() {
    return defaultCategories.map((e) => e.toMap()).toList();
  }
}
