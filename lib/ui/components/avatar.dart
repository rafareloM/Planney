import 'package:flutter/material.dart';
import 'package:planney/style/style.dart';

class Avatar extends StatelessWidget {
  final String userName;
  final double userBalance;
  const Avatar({super.key, required this.userName, required this.userBalance});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 200,
      child: Card(
        color: AppStyle.backgroundBuyColor,
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 32,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xffeff1f5),
                    radius: 40,
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: Color(0xffc1cdda),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text.rich(
                          TextSpan(
                            text: "Olá, ",
                            style: TextStyle(color: AppStyle.cardBackgroundColor, fontSize: 28),
                            children: [
                              TextSpan(
                                text: "$userName!",
                                style: TextStyle(color: AppStyle.button1Color, fontSize: 28),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'O seu balanço atual é:',
                          style: TextStyle(color: AppStyle.cardBackgroundColor, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              "R\$ $userBalance",
              style: TextStyle(color: AppStyle.button1Color, fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
