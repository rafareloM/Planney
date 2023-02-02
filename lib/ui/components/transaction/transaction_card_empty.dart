import 'package:flutter/material.dart';
import 'package:planney/style/style.dart';

class TransactionCardEmpty extends StatelessWidget {
  const TransactionCardEmpty(
      {Key? key, required this.deviceHeight, required this.isExpence})
      : super(key: key);

  final double deviceHeight;
  final bool isExpence;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(21))),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Container(
                height: deviceHeight * 0.326,
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
    );
  }
}
