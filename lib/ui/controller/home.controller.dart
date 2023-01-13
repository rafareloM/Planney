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

  @readonly
  DateTime _currentDateTime = DateTime.now();

  @observable
  bool isExpence = true;

  @observable
  ThemeData selectedAppTheme = AppStyle.appThemeDark;

  Future<APIResponse<List<Transaction>>> getTransactionsList() async {
    final response = await _transactionRepository.getMonth(_currentDateTime);
    if (response.isSuccess) {
      final store = GetIt.instance.get<TransactionsStore>();
      store.replaceList(response.data!);
    }
    return response;
  }

  Future<APIResponse<List<Category>?>> getCategoriesList() async {
    final response = await _planneyUserRepository.getCategories();
    if (response.isSuccess) {
      final store = GetIt.instance.get<CategoryStore>();
      store.replaceList(response.data!);
    }
    return response;
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
    await _authRepository.logout();
  }
}
