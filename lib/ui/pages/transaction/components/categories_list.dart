import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/model/category.model.dart';
import 'package:planney/navigator_key.dart';
import 'package:planney/stores/category.store.dart';
import 'package:planney/ui/controller/home.controller.dart';
import 'package:planney/ui/controller/transaction.controller.dart';
import 'package:planney/ui/pages/transaction/components/category_button.dart';

class CategoriesList extends StatelessWidget {
  final double height;
  final double width;
  final TransactionController controller;
  final Color color;
  final Color selectedColor;
  final bool paintBackground;

  const CategoriesList({
    Key? key,
    required this.paintBackground,
    required this.height,
    required this.width,
    required this.controller,
    required this.color,
    required this.selectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryStore categoryStore = GetIt.instance.get<CategoryStore>();
    final bool isExpense = GetIt.instance.get<HomePageController>().isExpence;
    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Observer(builder: (_) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
                  createList(categoryStore.getCategoriesByType(isExpense)),
            );
          }),
        ),
      ),
    );
  }

  List<Widget> createList(List<Category> list) {
    List<Widget> widgets = [];

    for (var category in list) {
      widgets.add(CategoryButton(
          size: 42,
          paintBackground: paintBackground,
          name: category.name.toUpperCase(),
          color:
              controller.selectedCategory == category ? selectedColor : color,
          icon: category.icon,
          onPressed: () {
            controller.selectedCategory = category;
          }));
    }
    widgets.add(CategoryButton(
      size: 42,
      paintBackground: false,
      name: 'Nova Categoria',
      color: color,
      icon: Icons.add_box_outlined,
      onPressed: () {
        Navigator.pushNamed(navigatorKey.currentContext!, 'addCategoryPage');
      },
    ));
    return widgets;
  }
}
