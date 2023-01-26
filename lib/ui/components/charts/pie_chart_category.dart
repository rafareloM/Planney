import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/ui/components/charts/charts_helper.dart';

class PieChartCategory extends StatefulWidget {
  final List<Transaction> transactionsList;

  final Color titleColor;
  const PieChartCategory(
      {super.key, required this.transactionsList, required this.titleColor});

  @override
  State<StatefulWidget> createState() => PieChartCategoryState();
}

class PieChartCategoryState extends State<PieChartCategory> {
  int touchedIndex = 8;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: SizedBox(
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
    int weekday = 1;
    List<PieChartSectionData> sectionsList = [];
    int i = 0;

    double totalValue = ChartsHelper.totalCategoryValue(
        transactionsList, transactionsList.first.category.name);

    transactionsList.sort(
      (a, b) => a.date.weekday.compareTo(b.date.weekday),
    );

    do {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 107.0 : 100.0;
      final widgetSize = isTouched ? 46.0 : 40.0;
      if (transactionsList.any((element) => element.date.weekday == weekday)) {
        sectionsList.add(
          PieChartSectionData(
            color: ChartsHelper.setColorByIndex(i),
            value: ChartsHelper.totalDayValue(transactionsList, weekday),
            radius: radius,
            badgeWidget: Padding(
              padding: const EdgeInsets.fromLTRB(8, 36, 4, 8),
              child: _Badge(
                fontSize: fontSize,
                size: widgetSize,
                buttonColor: widget.titleColor,
                day: ChartsHelper.weekdayToString(weekday)!,
                isTouched: isTouched,
                value: ((ChartsHelper.totalDayValue(transactionsList, weekday) /
                            totalValue) *
                        100)
                    .toStringAsFixed(1),
              ),
            ),
            badgePositionPercentageOffset: 1.33,
            showTitle: false,
          ),
        );
        i++;
      }
      weekday++;
    } while (weekday <= 7);

    return sectionsList;
  }
}

class _Badge extends StatelessWidget {
  final String day;
  final double size;
  final Color buttonColor;
  final double fontSize;
  final bool isTouched;

  final String value;
  const _Badge({
    required this.size,
    required this.buttonColor,
    required this.day,
    required this.isTouched,
    required this.value,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.square(size + 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          day,
          style: TextStyle(
            color: buttonColor,
            fontSize: fontSize,
          ),
        ),
        isTouched
            ? Text(
                '$value%',
                style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize),
              )
            : const SizedBox(),
      ]),
    );
  }
}
