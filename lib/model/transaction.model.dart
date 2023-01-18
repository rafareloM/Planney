import 'package:enum_to_string/enum_to_string.dart';
import 'package:planney/model/category.model.dart';

enum TransactionType {
  expence,
  receipt,
}

enum UserAccounts {
  principal,
  others,
}

class Transaction {
  String? uid;
  final TransactionType type;
  final double value;
  final UserAccounts userAccount;
  final Category category;
  final String description;
  final DateTime date;

  Transaction({
    this.uid,
    required this.type,
    required this.value,
    required this.userAccount,
    required this.category,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.name,
      'value': value,
      'userAccount': userAccount.name,
      'category': category.toMap(),
      'description': description,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Transaction.fromFirestore(Map<String, dynamic> map) {
    return Transaction(
      type: EnumToString.fromString(
              [TransactionType.expence, TransactionType.receipt], map['type'])
          as TransactionType,
      value: map['value'] as double,
      userAccount: EnumToString.fromString(
              [UserAccounts.principal, UserAccounts.others], map['type'])
          as UserAccounts,
      category: Category.fromFirestore(map['category']),
      description: map['description'] as String,
      date: DateTime.fromMicrosecondsSinceEpoch(map['date'] as int),
    );
  }

  Transaction copyWith({
    String? uid,
    TransactionType? type,
    double? value,
    UserAccounts? userAccount,
    Category? category,
    String? description,
    DateTime? date,
  }) {
    return Transaction(
      uid: uid ?? this.uid,
      type: type ?? this.type,
      value: value ?? this.value,
      userAccount: userAccount ?? this.userAccount,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}
