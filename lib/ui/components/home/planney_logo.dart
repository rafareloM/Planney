import 'package:flutter/material.dart';
import 'package:planney/style/style.dart';

class PlanneyLogo extends StatelessWidget {
  final double size;
  const PlanneyLogo({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double circleSize = size + 8;

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Planney',
          style: TextStyle(
              color: colorScheme.brightness == Brightness.dark
                  ? colorScheme.onPrimary
                  : colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: size),
        ),
        const SizedBox(
          width: 6,
        ),
        Stack(
          children: [
            Container(
              height: circleSize,
              width: circleSize,
              decoration: BoxDecoration(
                color: AppStyle.fullWhite,
                borderRadius: const BorderRadius.all(Radius.circular(100)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: size),
              child: Container(
                height: circleSize,
                width: circleSize,
                decoration: BoxDecoration(
                  color: colorScheme.brightness == Brightness.dark
                      ? colorScheme.primary
                      : colorScheme.tertiary,
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
