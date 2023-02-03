import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:planney/infra/repositories/transaction.repository.dart';
import 'package:planney/model/category.model.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/stores/transactions.store.dart';
import 'package:planney/ui/controller/home.controller.dart';
part 'transaction.controller.g.dart';

class TransactionController = TransactionControllerBase
    with _$TransactionController;

abstract class TransactionControllerBase with Store {
  final TransactionRepository _repository;

  TransactionControllerBase(this._repository);

  final _store = GetIt.instance.get<TransactionsStore>();

  final _homeController = GetIt.instance.get<HomePageController>();

  Future<bool> registerTransaction(bool isExpense) async {
    Transaction transaction = Transaction(
        date: selectedDate,
        description: description,
        value: transactionValue,
        category: selectedCategory,
        type: isExpense ? TransactionType.expence : TransactionType.receipt,
        userAccount: selectedUserAccount);

    final response = await _repository.add(transaction);
    if (response.isSuccess) {
      _store.addTransaction(response.data!);
      if (isExpense) {
        _homeController.finalListExpence.add(transaction);
      } else {
        _homeController.finalListReceipt.add(transaction);
      }
      dispose();
      return true;
    } else {
      return false;
    }
  }

  dispose() {
    formattedDate = '';
    selectedDate = DateTime.now();
    transactionValue = 0;
    selectedUserAccount = UserAccounts.principal;
    description = '';
    formattedDate = '';
    selectedCategory = Category(
        name: '',
        type: TransactionType.expence,
        codePoint: 0,
        color: Colors.black);
  }

  @observable
  DateTime selectedDate = DateTime.now();

  @observable
  String formattedDate = '';

  @observable
  String description = '';

  @observable
  UserAccounts selectedUserAccount = UserAccounts.principal;

  @observable
  double transactionValue = 0;

  @observable
  Category selectedCategory = Category(
      name: '',
      type: TransactionType.expence,
      codePoint: 0,
      color: Colors.black);
}
