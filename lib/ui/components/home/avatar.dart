import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String userName;
  final double userBalance;
  const Avatar({super.key, required this.userName, required this.userBalance});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Color spanTextColor = colorScheme.tertiary;

    return SizedBox(
      width: double.maxFinite,
      height: 160,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(21))),
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
                  const CircleAvatar(
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
                            style: const TextStyle(fontSize: 28),
                            children: [
                              TextSpan(
                                text: "$userName!",
                                style: TextStyle(
                                    color: spanTextColor, fontSize: 28),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'O seu balanço atual é:',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              "R\$ $userBalance",
              style: TextStyle(color: spanTextColor, fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
