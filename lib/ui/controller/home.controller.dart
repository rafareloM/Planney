import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:planney/style/style.dart';
part 'home.controller.g.dart';

class HomePageController = HomePageControllerBase with _$HomePageController;

abstract class HomePageControllerBase with Store {
  @observable
  bool isExpence = true;

  @observable
  ThemeData selectedAppTheme = AppStyle.appThemeDark;

  @action
  changeAppTheme() {
    if (selectedAppTheme.brightness == Brightness.dark) {
      selectedAppTheme = AppStyle.appThemeLight;
    } else {
      selectedAppTheme = AppStyle.appThemeDark;
    }
  }
}
