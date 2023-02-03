import 'package:planney/model/category.model.dart';
import 'package:planney/model/transaction.model.dart';

class TransactionMock {
  static List<Transaction> transactionsMock = [
    Transaction(
      type: TransactionType.expence,
      value: 15,
      userAccount: UserAccounts.principal,
      category: CategoryHelper.defaultCategories.first,
      description: 'Cerveja',
      date: DateTime.now(),
    ),
    Transaction(
      type: TransactionType.expence,
      value: 17,
      userAccount: UserAccounts.principal,
      category: CategoryHelper.defaultCategories.first,
      description: 'Carne',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
        type: TransactionType.expence,
        value: 22,
        userAccount: UserAccounts.principal,
        category: CategoryHelper.defaultCategories.first,
        description: 'Brrrauni',
        date: DateTime.now().subtract(
          const Duration(days: 2),
        )),
    Transaction(
      type: TransactionType.expence,
      value: 4,
      userAccount: UserAccounts.principal,
      category: CategoryHelper.defaultCategories.first,
      description: 'Biscoito',
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      type: TransactionType.expence,
      value: 20,
      userAccount: UserAccounts.principal,
      category: CategoryHelper.defaultCategories.first,
      description: 'Cerveja',
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ];
}
