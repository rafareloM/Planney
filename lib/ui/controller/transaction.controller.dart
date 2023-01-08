import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:planney/model/transaction.model.dart';
part 'transaction.controller.g.dart';

class TransactionController = TransactionControllerBase
    with _$TransactionController;

abstract class TransactionControllerBase with Store {
  @observable
  ObservableList<Transaction> transactionList = ObservableList<Transaction>();

  @action
  addTransaction(
    bool isExpence,
  ) {
    transactionList.add(
      Transaction(
          type: isExpence ? TransactionType.expence : TransactionType.receipt,
          value: transactionValue,
          category:
              isExpence ? selectedExpenceCategory : selectedReceiptCategory,
          date: selectedDate,
          description: textController.text,
          userAccount: selectedUserAccount),
    );
    selectedUserAccount = UserAccounts.principal;
    selectedKey = '';
    valueController.text = '';
    textController.text = '';
    selectedDate = DateTime.now();
    selectedExpenceCategory = {};
    selectedReceiptCategory = {};
    formattedDate = DateFormat('dd/MM/y').format(DateTime.now());
  }

  @observable
  DateTime selectedDate = DateTime.now();

  @observable
  String formattedDate = '';

  @observable
  String selectedKey = '';

  @observable
  UserAccounts selectedUserAccount = UserAccounts.principal;

  @observable
  TextEditingController valueController = TextEditingController();

  @observable
  double transactionValue = 0;

  @observable
  TextEditingController textController = TextEditingController();

  @observable
  Map<String, IconData> selectedExpenceCategory = {};

  @observable
  Map<String, IconData> selectedReceiptCategory = {};
}
