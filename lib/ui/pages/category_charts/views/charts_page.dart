import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/navigator_key.dart';
import 'package:planney/style/style.dart';
import 'package:planney/ui/components/adaptative/adaptative_app_bar.dart';
import 'package:planney/ui/components/charts/bar_chart.dart';
import 'package:planney/ui/components/charts/pie_chart_category.dart';
import 'package:planney/ui/components/home/info_card.dart';
import 'package:planney/ui/controller/home.controller.dart';
import 'package:planney/ui/pages/category_charts/views/category_details_page.dart';

class CategoryChartsPage extends StatelessWidget {
  final String categoryName;
  final List<Transaction> list;
  const CategoryChartsPage({
    super.key,
    required this.categoryName,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    final HomePageController controller = GetIt.instance.get<HomePageController>();

    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Color textColor =
        colorScheme.brightness == Brightness.dark ? colorScheme.onSurface : colorScheme.primary;

    TransactionType? type = controller.finalListExpence.isEmpty
        ? TransactionType.expence
        : controller.finalListExpence.first.type;

    Widget pieChart = Observer(builder: (context) {
      return PieChartCategory(
        titleColor: textColor,
        transactionsList: controller.filteredList
            .takeWhile(
                (value) => value.date.isAfter(DateTime.now().subtract(const Duration(days: 8))))
            .toList(),
      );
    });

    Widget barChart = Observer(builder: (context) {
      return BarChartSample3(
        textColor: textColor,
        transactions: list
            .takeWhile(
                (value) => value.date.isAfter(DateTime.now().subtract(const Duration(days: 8))))
            .toList(),
      );
    });

    String pieChartTitle = type == TransactionType.expence ? 'Despesa Semanal' : 'Receita Semanal';

    String barChartTitle = type == TransactionType.expence ? 'Fluxo de gasto' : 'Fluxo do saldo';

    double deviceHeight = MediaQuery.of(context).size.height;
    return Observer(builder: (context) {
      return Scaffold(
        appBar: AdaptativeAppBar.fromBrightness(
          colorScheme.brightness,
          title: categoryName.toUpperCase(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    pieChartTitle,
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: list.isEmpty
                    ? InfoCard(
                        height: deviceHeight * 0.48,
                        textButtonCTA: 'Mais detalhes',
                        content: Center(
                          child: Stack(
                            children: [
                              Container(
                                height: deviceHeight * 0.3,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppStyle.initialchartcolor,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(36),
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    shape: CircleBorder(),
                                    child: Center(
                                      child: Text(
                                        'A categoria\nestá vazia!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
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
                        onPressed: null,
                        buttonColor: textColor)
                    : InfoCard(
                        height: deviceHeight * 0.48,
                        textButtonCTA: 'Mais detalhes',
                        content: pieChart,
                        onPressed: () {
                          controller.getTransactionsByCategory(categoryName);
                          Navigator.push(
                            navigatorKey.currentContext!,
                            MaterialPageRoute(
                              builder: (context) => CategoryDetailsPage(
                                transactionList: controller.filteredList,
                                chart: pieChart,
                                title: pieChartTitle,
                              ),
                            ),
                          );
                        },
                        buttonColor: textColor),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    barChartTitle,
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              list.isEmpty
                  ? InfoCard(
                      height: deviceHeight * 0.48,
                      textButtonCTA: 'Mais detalhes',
                      content: Center(
                        child: Stack(
                          children: [
                            Container(
                              height: deviceHeight * 0.3,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppStyle.initialchartcolor,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(36),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  shape: CircleBorder(),
                                  child: Center(
                                    child: Text(
                                      'A categoria\nestá vazia!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
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
                      onPressed: null,
                      buttonColor: textColor)
                  : InfoCard(
                      height: deviceHeight * 0.48,
                      textButtonCTA: 'Mais detalhes',
                      content: barChart,
                      onPressed: () {
                        Navigator.push(
                          navigatorKey.currentContext!,
                          MaterialPageRoute(
                            builder: (context) => CategoryDetailsPage(
                              chart: barChart,
                              title: barChartTitle,
                              transactionList: list,
                            ),
                          ),
                        );
                      },
                      buttonColor: textColor),
              SizedBox(
                height: deviceHeight * 0.025,
              )
            ],
          ),
        ),
      );
    });
  }
}
