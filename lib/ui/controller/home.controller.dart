import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:planney/infra/repositories/auth.repository.dart';
import 'package:planney/infra/repositories/planney_user.repository.dart';
import 'package:planney/infra/repositories/transaction.repository.dart';
import 'package:planney/model/api_response.model.dart';
import 'package:planney/model/category.model.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/stores/category.store.dart';
import 'package:planney/stores/planney_user.store.dart';
import 'package:planney/stores/transactions.store.dart';
import 'package:planney/style/style.dart';
part 'home.controller.g.dart';

class HomePageController = HomePageControllerBase with _$HomePageController;

abstract class HomePageControllerBase with Store {
  final TransactionRepository _transactionRepository;
  final PlanneyUserRepository _planneyUserRepository;
  final AuthRepository _authRepository;

  HomePageControllerBase(
    this._transactionRepository,
    this._planneyUserRepository,
    this._authRepository,
  ) {
    _currentDateTime = DateTime.now();
    _currentDateTime = DateTime(
        _currentDateTime.year, _currentDateTime.month, _currentDateTime.day);
  }

  final _transactionStore = GetIt.instance.get<TransactionsStore>();

  final _planneyUserStore = GetIt.instance.get<PlanneyUserStore>();

  @readonly
  DateTime _currentDateTime = DateTime.now();

  @observable
  bool isExpence = true;

  @observable
  bool isLoading = false;

  @observable
  ObservableList<Transaction> finalListReceipt = ObservableList<Transaction>();

  @observable
  ObservableList<Transaction> finalListExpence = ObservableList<Transaction>();

  @observable
  List<Transaction> filteredList = ObservableList<Transaction>();

  @observable
  ThemeData selectedAppTheme = AppStyle.appThemeDark;

  Future<APIResponse<List<Transaction>>> getTransactionsList() async {
    final response = await _transactionRepository.getMonth(_currentDateTime);
    if (response.isSuccess) {
      final store = GetIt.instance.get<TransactionsStore>();
      store.replaceList(response.data!);
      for (var transaction in store.list) {
        if (transaction.type == TransactionType.expence) {
          finalListExpence.add(transaction);
        } else {
          finalListReceipt.add(transaction);
        }
      }
    }
    return response;
  }

  @action
  List<Transaction> getTransactionsByCategory(String category) {
    filteredList.clear();
    for (var item in _transactionStore.list) {
      if (item.category.name == category) {
        filteredList.add(item);
      }
    }
    return filteredList;
  }

  Future<APIResponse<List<Category>?>> getCategoriesList() async {
    final response = await _planneyUserRepository.getCategories();
    if (response.isSuccess) {
      final store = GetIt.instance.get<CategoryStore>();
      store.replaceList(response.data!);
    }
    return response;
  }

  @computed
  double get totalValue {
    double result = 0;
    for (var transaction in _transactionStore.list) {
      if (transaction.type == TransactionType.expence) {
        result -= transaction.value;
      } else if (transaction.type == TransactionType.receipt) {
        result += transaction.value;
      }
    }
    return result;
  }

  @action
  changeAppTheme() {
    if (selectedAppTheme.brightness == Brightness.dark) {
      selectedAppTheme = AppStyle.appThemeLight;
    } else {
      selectedAppTheme = AppStyle.appThemeDark;
    }
  }

  @action
  logout() async {
    _planneyUserStore.unloadPlanneyUser();

    await _authRepository.logout();
  }

  @action
  setLoading(bool status) {
    isLoading = status;
  }

  @action
  setIsExpence(bool status) {
    isExpence = status;
  }

  @action
  removeTransaction(Transaction transaction) {
    filteredList.removeWhere((e) => e.uid == transaction.uid);
    finalListExpence.removeWhere((e) => e.uid == transaction.uid);
    finalListReceipt.removeWhere((e) => e.uid == transaction.uid);
  }

  @action
  Future<void> remove(Transaction transaction) async {
    await _transactionRepository.remove(transaction);
    _transactionStore.removeTransaction(transaction);
    removeTransaction(transaction);
  }
}
