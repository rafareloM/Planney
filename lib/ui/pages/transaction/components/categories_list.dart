import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/model/category.model.dart';
import 'package:planney/ui/controller/home.controller.dart';
import 'package:planney/ui/controller/transaction.controller.dart';
import 'package:planney/ui/pages/transaction/components/category_button.dart';

class CategoriesList extends StatelessWidget {
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
  Widget build(BuildContext context) {
    bool isExpense = GetIt.instance.get<HomePageController>().isExpence;
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: isExpense
            ? ExpenseCategory.categories.map((e) {
                return Observer(builder: (_) {
                  return CategoryButton(
                      name: e.entries.first.key.toUpperCase(),
                      color: controller.selectedKey == e.entries.first.key
                          ? selectedColor
                          : color,
                      icon: e.entries.first.value,
                      onPressed: () {
                        controller.selectedKey = e.entries
                            .firstWhere(
                              (element) => element.key == e.entries.first.key,
                            )
                            .key;
                        controller.selectedExpenceCategory =
                            ExpenseCategory.categories.firstWhere(
                          (element) =>
                              controller.selectedKey ==
                              element.entries.first.key,
                        );
                      });
                });
              }).toList()
            : ReceiptCategory.categories.map((e) {
                return Observer(builder: (_) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        e.entries.first.key.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      IconButton(
                          iconSize: 64,
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            e.entries.first.value,
                            color: controller.selectedKey == e.entries.first.key
                                ? selectedColor
                                : color,
                            semanticLabel: e.entries.first.key,
                          ),
                          onPressed: () {
                            controller.selectedKey = e.entries
                                .firstWhere(
                                  (element) =>
                                      element.key == e.entries.first.key,
                                )
                                .key;
                            controller.selectedReceiptCategory =
                                ReceiptCategory.categories.firstWhere(
                              (element) =>
                                  controller.selectedKey ==
                                  element.entries.first.key,
                            );
                          }),
                    ],
                  );
                });
              }).toList());
  }
}
