import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/ui/components/home/info_card.dart';
import 'package:planney/ui/components/transaction/transaction_list_card.dart';
import 'package:planney/ui/controller/home.controller.dart';

class CategoryDetailsPage extends StatelessWidget {
  final String title;
  final Widget chart;
  final List<Transaction> transactionList;

  const CategoryDetailsPage(
      {super.key,
      required this.title,
      required this.chart,
      required this.transactionList});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Color textColor = colorScheme.brightness == Brightness.dark
        ? colorScheme.onSurface
        : colorScheme.primary;
    double deviceHeight = MediaQuery.of(context).size.height;
    TextStyle textStyle =
        TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18);
    final HomePageController controller =
        GetIt.instance.get<HomePageController>();

    return Observer(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: colorScheme.brightness == Brightness.dark
                ? colorScheme.background
                : colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            title: ConstrainedBox(
              constraints: BoxConstraints.tight(
                const Size(150, 32),
              ),
              child: const Text('DETALHES'),
            ),
            centerTitle: true,
          ),
          body: controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(title, style: textStyle),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InfoCard(
                            height: deviceHeight * 0.48,
                            content: chart,
                            onPressed: () {},
                            buttonColor: textColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('DETALHAMENTO', style: textStyle),
                        ),
                      ),
                      Card(
                        elevation: 10,
                        child: Column(
                          children: transactionList.map((e) {
                            return TransactionListCard(
                              showLeading: false,
                              transaction: e,
                              positiveAction: (e) async {
                                controller.setLoading(true);
                                await controller.remove(e);
                                controller.setLoading(false);
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ));
    });
  }
}
