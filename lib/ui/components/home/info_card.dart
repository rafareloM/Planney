import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String? textButtonCTA;
  final Widget content;

  final void Function()? onPressed;

  final Color buttonColor;
  final double height;
  const InfoCard(
      {Key? key,
      this.textButtonCTA,
      required this.onPressed,
      required this.content,
      required this.buttonColor,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.maxFinite,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: content),
            textButtonCTA != null
                ? const Divider(
                    height: 0,
                    thickness: 1,
                  )
                : const SizedBox(),
            textButtonCTA != null
                ? SizedBox(
                    height: 36,
                    child: TextButton(
                      onPressed: onPressed,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Text(
                              textButtonCTA!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: buttonColor),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: buttonColor,
                          )
                        ],
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
