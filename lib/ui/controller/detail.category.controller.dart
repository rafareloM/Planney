import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'detail.category.controller.g.dart';

class DetailCategoryPageController = _DetailCategoryPageControllerBase
    with _$DetailCategoryPageController;

abstract class _DetailCategoryPageControllerBase with Store {
  @observable
  bool isExpence = true;

  @observable
  String selectedKey = '';
}
