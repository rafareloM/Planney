import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/ui/components/transaction/transaction_card_empty.dart';
import 'package:planney/ui/components/transaction/list_view_button.dart';
import 'package:planney/ui/components/transaction/transaction_card_filled.dart';
import 'package:planney/ui/controller/home.controller.dart';

class TransactionChartCard extends StatelessWidget {
  final HomePageController controller;
  final List<Transaction> transactionList;
  final bool isExpence;
  final ColorScheme colorScheme;
  const TransactionChartCard(
      {Key? key,
      required this.controller,
      required this.colorScheme,
      required this.isExpence,
      required this.transactionList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    Color activeColor = Theme.of(context).brightness == Brightness.dark
        ? colorScheme.tertiary
        : colorScheme.primary;

    return Observer(builder: (context) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(14))),
              elevation: 1,
              margin: EdgeInsets.zero,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ListViewButton(
                    onPressed: () {
                      if (controller.isExpence = true) {
                        return;
                      }
                      controller.setIsExpence(true);
                    },
                    buttonLabel: 'Despesa',
                    buttonColor: controller.isExpence
                        ? activeColor
                        : colorScheme.brightness == Brightness.dark
                            ? colorScheme.onSurface
                            : colorScheme.tertiary,
                    dividerColor: controller.isExpence
                        ? colorScheme.brightness == Brightness.dark
                            ? colorScheme.tertiary
                            : colorScheme.primary
                        : Colors.transparent,
                  ),
                  ListViewButton(
                    onPressed: () {
                      if (controller.isExpence = false) {
                        return;
                      }
                      controller.setIsExpence(false);
                    },
                    buttonLabel: 'Receita',
                    buttonColor: !controller.isExpence
                        ? activeColor
                        : colorScheme.brightness == Brightness.dark
                            ? colorScheme.onSurface
                            : colorScheme.tertiary,
                    dividerColor: !controller.isExpence
                        ? colorScheme.brightness == Brightness.dark
                            ? colorScheme.tertiary
                            : colorScheme.primary
                        : Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
          transactionList.isEmpty
              ? TransactionCardEmpty(
                  deviceHeight: deviceHeight,
                  isExpence: isExpence,
                )
              : TransactionCardFilled(
                  deviceHeight: deviceHeight,
                  isExpence: isExpence,
                  transactionList: transactionList,
                ),
        ],
      );
    });
  }
}
