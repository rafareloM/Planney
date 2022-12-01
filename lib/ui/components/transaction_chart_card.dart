import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/style/style.dart';
import 'package:planney/ui/components/list_view_button.dart';
import 'package:planney/ui/controller/home.controller.dart';
import 'package:planney/ui/controller/transaction.controller.dart';

class TransactionChartCard extends StatelessWidget {
  final HomePageController controller;
  final bool isExpence;
  final ColorScheme colorScheme;
  const TransactionChartCard(
      {Key? key,
      required this.controller,
      required this.colorScheme,
      required this.isExpence})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    final transactionList =
        GetIt.instance.get<TransactionController>().transactionList;
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
                      controller.isExpence = true;
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
                      controller.isExpence = false;
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
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(21))),
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            height: deviceHeight * 0.3,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppStyle.initialchartcolor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(36),
                              child: Card(
                                margin: EdgeInsets.zero,
                                shape: const CircleBorder(),
                                child: Center(
                                  child: Text(
                                    isExpence
                                        ? 'Adicione\nsua Despesa'
                                        : 'Adicione\nsua Renda',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      );
    });
  }
}
