import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/style/style.dart';
import 'package:planney/ui/components/charts/charts_helper.dart';

class PieChartPlaney extends StatefulWidget {
  final List<Transaction> transactionsList;
  const PieChartPlaney({super.key, required this.transactionsList});

  @override
  State<StatefulWidget> createState() => PieChartPlaneyState();
}

class PieChartPlaneyState extends State<PieChartPlaney> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 0,
              sections: showingSections(widget.transactionsList),
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(
      List<Transaction> transactionsList) {
    List<String> categoryList = ChartsHelper.getCategoryNames(transactionsList);
    List<PieChartSectionData> sectionsList = [];
    int i = 0;

    for (var category in categoryList) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 107.0 : 100.0;
      final widgetSize = isTouched ? 46.0 : 40.0;

      sectionsList.add(PieChartSectionData(
        color: ChartsHelper.setColorByIndex(i),
        value: ChartsHelper.totalCategoryValue(transactionsList, category),
        title: category,
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppStyle.fullWhite,
        ),
        badgeWidget: _Badge(
          codePoint: transactionsList
              .firstWhere((element) => element.category.keys.first == category)
              .category
              .values
              .first
              .codePoint,
          size: widgetSize,
          borderColor: AppStyle.chartcolor1,
        ),
        badgePositionPercentageOffset: .98,
      ));
      i++;
    }
    return sectionsList;
  }
}

class _Badge extends StatelessWidget {
  final int codePoint;

  const _Badge({
    required this.size,
    required this.borderColor,
    required this.codePoint,
  });
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppStyle.fullWhite,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.6),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Icon(
          IconData(codePoint, fontFamily: 'MaterialIcons'),
          color: AppStyle.primaryColor,
        ),
      ),
    );
  }
}
