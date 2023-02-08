import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:planney/infra/repositories/planney_user.repository.dart';
import 'package:planney/model/api_response.model.dart';
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
  String categoryName = '';

  @observable
  IconData? selectedIconData;

  @observable
  Icon? selectedIcon;

  Future<APIResponse<bool>> registerCategory(bool isExpense) async {
    if (selectedIcon == null || selectedIconData == null) {
      return APIResponse.error('Escolha um ícone');
    }

    if (categoryName == '') {
      return APIResponse.error('O nome é obrigatório');
    }
    List<Category> userCategories = List.from(_store.list);
    Category category = Category(
        name: categoryName,
        type: isExpense ? TransactionType.expence : TransactionType.receipt,
        icon: selectedIcon!.icon!,
        color: color);
    userCategories.add(category);
    final response = await _repository
        .update(_userStore.planneyUser!.copyWith(categories: userCategories));
    if (response.isSuccess) {
      _store.addCategory(category);
      return APIResponse.success(true);
    } else {
      return APIResponse.error('Ops, algo deu errado!');
    }
  }

  @action
  selectIcon(Icon icon) {
    selectedIcon = icon;
    selectedIconData = icon.icon;
  }

  @action
  selectColor(Color newColor) {
    color = newColor;
  }

  @action
  changeCategoryName(String value) {
    categoryName = value;
  }
}
