import 'package:flutter/material.dart';
import 'package:planney/mocks/transaction_mock.model.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/navigator_key.dart';
import 'package:planney/ui/components/charts/bar_chart.dart';
import 'package:planney/ui/components/charts/pie_chart_category.dart';
import 'package:planney/ui/components/home/info_card.dart';
import 'package:planney/ui/pages/category_charts/views/category_details_page.dart';

class CategoryChartsPage extends StatelessWidget {
  final List<Transaction> transactions;
  final String categoryName;
  const CategoryChartsPage({
    super.key,
    required this.transactions,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Color textColor = colorScheme.brightness == Brightness.dark
        ? colorScheme.onSurface
        : colorScheme.primary;

    TransactionType? type = transactions.isEmpty
        ? TransactionType.expence
        : transactions.first.type;

    Widget pieChart = PieChartCategory(
        titleColor: textColor,
        transactionsList: TransactionMock.transactionsMock
        //TODO: Implement reactive transactions.

        // transactions
        //     .takeWhile((value) => value.date.isAfter(
        //         DateTime.now().subtract(const Duration(days: 8))))
        //     .toList(),
        );

    Widget barChart = BarChartSample3(
      textColor: textColor,
      //TODO: Implement reactive transactions.

      // transactions
      //     .takeWhile((value) => value.date.isAfter(
      //         DateTime.now().subtract(const Duration(days: 8))))
      //     .toList(),
    );

    String pieChartTitle =
        type == TransactionType.expence ? 'Despesa Semanal' : 'Receita Semanal';

    String barChartTitle =
        type == TransactionType.expence ? 'Fluxo de gasto' : 'Fluxo do saldo';

    double deviceHeight = MediaQuery.of(context).size.height;
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
          child: Text(categoryName.toUpperCase()),
        ),
        centerTitle: true,
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
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: InfoCard(
                  height: deviceHeight * 0.48,
                  textButtonCTA: 'Mais detalhes',
                  content: pieChart,
                  onPressed: () {
                    Navigator.push(
                      navigatorKey.currentContext!,
                      MaterialPageRoute(
                        builder: (context) => CategoryDetailsPage(
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
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            InfoCard(
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
  }
}
