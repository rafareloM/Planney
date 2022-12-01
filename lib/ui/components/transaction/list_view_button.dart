import 'package:flutter/material.dart';

class ListViewButton extends StatelessWidget {
  final void Function() onPressed;

  final String buttonLabel;

  final Color buttonColor;

  final Color dividerColor;

  const ListViewButton({
    Key? key,
    required this.onPressed,
    required this.buttonLabel,
    required this.buttonColor,
    required this.dividerColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: onPressed,
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(buttonColor),
                  ),
                  child: Text(
                    buttonLabel,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    color: dividerColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
