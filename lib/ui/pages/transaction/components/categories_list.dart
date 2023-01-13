import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/stores/category.store.dart';
import 'package:planney/ui/controller/home.controller.dart';
import 'package:planney/ui/controller/transaction.controller.dart';
import 'package:planney/ui/pages/transaction/components/category_button.dart';

class CategoriesList extends StatefulWidget {
  final double height;
  final double width;
  final TransactionController controller;
  final Color color;
  final Color selectedColor;

  const CategoriesList({
    Key? key,
    required this.height,
    required this.width,
    required this.controller,
    required this.color,
    required this.selectedColor,
  }) : super(key: key);

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  final CategoryStore _categoryStore = GetIt.instance.get<CategoryStore>();
  final bool isExpense = GetIt.instance.get<HomePageController>().isExpence;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        primary: false,
        scrollDirection: Axis.horizontal,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _categoryStore.getCategoriesByType(isExpense).map((e) {
              return Observer(builder: (_) {
                return CategoryButton(
                    name: e.name.toUpperCase(),
                    color: widget.controller.selectedCategory == e
                        ? widget.selectedColor
                        : widget.color,
                    icon: IconData(e.codePoint, fontFamily: 'MaterialIcons'),
                    onPressed: () {
                      widget.controller.selectedCategory = e;
                    });
              });
            }).toList()));
  }
}
