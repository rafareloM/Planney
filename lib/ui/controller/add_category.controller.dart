import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:planney/infra/repositories/planney_user.repository.dart';
import 'package:planney/model/category.model.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/stores/category.store.dart';
import 'package:planney/stores/planney_user.store.dart';
import 'package:planney/style/style.dart';
part 'add_category.controller.g.dart';

class AddCategoryPageController = AddCategoryPageControllerBase
    with _$AddCategoryPageController;

abstract class AddCategoryPageControllerBase with Store {
  final PlanneyUserRepository _repository;

  AddCategoryPageControllerBase(this._repository);

  final _store = GetIt.instance.get<CategoryStore>();
  final _userStore = GetIt.instance.get<PlanneyUserStore>();

  @observable
  Color color = AppStyle.primaryColor;

  @observable
  String categoryName = 'teste';

  @observable
  int codePoint = Icons.abc.codePoint;

  @observable
  Icon selectedIcon = const Icon(Icons.abc);

  Future<bool> registerCategory(bool isExpense) async {
    List<Category> userCategories = List.from(CategoryHelper.defaultCategories);
    Category category = Category(
        name: categoryName,
        type: isExpense ? TransactionType.expence : TransactionType.receipt,
        codePoint: codePoint,
        color: color);
    userCategories.add(category);
    final response = await _repository
        .update(_userStore.planneyUser!.copyWith(categories: userCategories));
    if (response.isSuccess) {
      _store.addCategory(category);
      return true;
    } else {
      return false;
    }
  }

  @action
  selectIcon(Icon icon) {
    selectedIcon = icon;
  }

  @action
  selectColor(Color newColor) {
    color = newColor;
  }
}
