// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String name;
  final Color color;
  final IconData icon;
  final void Function() onPressed;
  const CategoryButton({
    Key? key,
    required this.name,
    required this.color,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name.toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        IconButton(
          iconSize: 64,
          padding: EdgeInsets.zero,
          icon: Icon(
            icon,
            color: color,
            semanticLabel: name,
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
