import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:planney/style/style.dart';

class PieChartSample3 extends StatefulWidget {
  const PieChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample3State();
}

class PieChartSample3State extends State {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: AppStyle.fullWhite,
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
              sections: showingSections(),
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppStyle.chartcolor1,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppStyle.fullWhite,
            ),
            badgeWidget: _Badge(
              size: widgetSize,
              borderColor: AppStyle.chartcolor1,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: AppStyle.chartcolor2,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppStyle.fullWhite,
            ),
            badgeWidget: _Badge(
              size: widgetSize,
              borderColor: AppStyle.chartcolor2,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: AppStyle.chartcolor3,
            value: 16,
            title: '16%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppStyle.fullWhite,
            ),
            badgeWidget: _Badge(
              size: widgetSize,
              borderColor: AppStyle.chartcolor3,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: AppStyle.chartcolor4,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppStyle.fullWhite,
            ),
            badgeWidget: _Badge(
              size: widgetSize,
              borderColor: AppStyle.chartcolor4,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Ih, deu ruim');
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.size,
    required this.borderColor,
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
      child: const Center(
        child: Icon(
          Icons.touch_app,
          color: Colors.deepPurpleAccent,
        ),
      ),
    );
  }
}
