enum TransactionType {
  expence,
  receipt,
}

enum UserAccounts {
  principal,
  others,
}

class Transaction {
  final TransactionType type;
  final double value;
  final UserAccounts userAccount;
  final Map<String, int> category;
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.name,
      'value': value,
      'userAccount': userAccount.name,
      'category': category,
      'description': description,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Transaction.fromFirestore(Map<String, dynamic> map) {
    return Transaction(
      type: map['type'] as TransactionType..name,
      value: map['value'] as double,
      userAccount: map['user_account'] as UserAccounts..name,
      category: map['category'] as Map<String, int>,
      description: map['description'] as String,
      date: DateTime.fromMicrosecondsSinceEpoch(map['date'] as int),
    );
  }
}
