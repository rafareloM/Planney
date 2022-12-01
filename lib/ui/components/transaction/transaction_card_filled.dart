import 'package:flutter/material.dart';
import 'package:planney/ui/components/charts/pie_chart.dart';

class TransactionCardFilled extends StatelessWidget {
  final double deviceHeight;
  final bool isExpence;

  const TransactionCardFilled({
    Key? key,
    required this.deviceHeight,
    required this.isExpence,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(21))),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: PieChartSample3(),
        ),
      ),
    );
  }
}
