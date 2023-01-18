import 'package:flutter/material.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/ui/components/charts/pie_chart.dart';

class TransactionCardFilled extends StatelessWidget {
  final double deviceHeight;
  final List<Transaction> transactionList;
  final bool isExpence;

  const TransactionCardFilled({
    Key? key,
    required this.deviceHeight,
    required this.isExpence,
    required this.transactionList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(21))),
        margin: EdgeInsets.zero,
        child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: deviceHeight * 0.35,
              minWidth: double.maxFinite,
            ),
            child: PieChartPlaney(transactionsList: transactionList)),
      ),
    );
  }
}
