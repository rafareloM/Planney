import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String cardTitle;
  final String textButtonCTA;
  final IconData? textButtonIcon;
  const InfoCard(
      {Key? key,
      required this.cardTitle,
      required this.textButtonCTA,
      required this.textButtonIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 280,
      child: Card(
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 0, 0),
              child: Text(
                cardTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 184,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                'https://cdn.discordapp.com/attachments/1018978765327585392/1034263072635891712/Colorful_Flower_Fashion_Sale_Presentation_3.png',
                fit: BoxFit.fill,
              ),
            ),
            const Divider(
              height: 0,
              thickness: 1,
              color: Colors.black,
            ),
            SizedBox(
              height: 40,
              child: TextButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.black)),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          textButtonCTA,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Icon(
                        textButtonIcon,
                        size: 16,
                        color: Colors.orange,
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
