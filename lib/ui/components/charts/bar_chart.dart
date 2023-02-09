// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/ui/components/charts/charts_helper.dart';

class _BarChart extends StatelessWidget {
  final List<Transaction> transactionsList;
  final Color textColor;
  const _BarChart({
    Key? key,
    required this.transactionsList,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
      baselineY: 0,
      barTouchData: barTouchData,
      titlesData: titlesData,
      borderData: borderData,
      barGroups: barGroups,
      gridData: FlGridData(
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(color: textColor, strokeWidth: 0);
        },
      ),
      alignment: BarChartAlignment.spaceEvenly,
      maxY: ChartsHelper.getHighestDayValue(transactionsList),
    ));
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 2,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyle(
                color: textColor,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: textColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = ChartsHelper.weekdayToString(value.toInt() + 1) ?? '';
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 3,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(sideTitles: sideTitles),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  SideTitles get sideTitles {
    return SideTitles(
      showTitles: false,
      interval: 5,
    );
  }

  FlBorderData get borderData => FlBorderData(
        show: false, // adiciona uma borda na base das barras do gráfico
      );
  List<BarChartGroupData> get barGroups {
    List<BarChartGroupData> barChartGroupDataList = [];
    for (var x = 0; x < 7; x++) {
      if (ChartsHelper.totalDayValue(transactionsList, x + 1) > 0) {
        barChartGroupDataList.add(BarChartGroupData(
          x: x,
          barRods: [
            BarChartRodData(
                width: 42,
                toY: ChartsHelper.totalDayValue(transactionsList, x + 1),
                color: ChartsHelper.setColorByIndex(x),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)))
          ],
          showingTooltipIndicators: [0],
        ));
      }
    }
    return barChartGroupDataList;
  }
}

class BarChartSample3 extends StatefulWidget {
  final Color textColor;
  final List<Transaction> transactions;
  const BarChartSample3(
      {super.key, required this.textColor, required this.transactions});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: SizedBox(
        child: AspectRatio(
          aspectRatio: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
            child: _BarChart(
              transactionsList: widget.transactions,
              textColor: widget.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
