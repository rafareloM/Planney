import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String cardTitle;
  final String textButtonCTA;
  final String imagePath;
  const InfoCard(
      {Key? key,
      required this.cardTitle,
      required this.textButtonCTA,
      required this.imagePath})
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
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 184,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                imagePath,
                fit: BoxFit.fill,
              ),
            ),
            const Divider(
              height: 0,
              thickness: 1,
            ),
            SizedBox(
              height: 40,
              child: TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          textButtonCTA,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        size: 16,
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
