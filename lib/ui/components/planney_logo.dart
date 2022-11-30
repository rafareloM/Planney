import 'package:flutter/material.dart';
import 'package:planney/style/style.dart';

class PlanneyLogo extends StatelessWidget {

  final double size;
  const PlanneyLogo({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double circleSize = size + 8;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Planney',
          style: TextStyle(
              color: Color.fromARGB(255, 247, 247, 247),
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
                  color: Theme.of(context).colorScheme.primary,
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
