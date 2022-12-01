import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final TextEditingController textController;
  final String hint;
  final double hintFontSize;
  final double height;

  const TextForm(
      {Key? key,
      required this.textController,
      required this.hint,
      required this.height,
      required this.hintFontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: height,
        ),
        child: TextField(
          textAlignVertical: TextAlignVertical.bottom,
          style: TextStyle(fontSize: hintFontSize),
          expands: true,
          maxLines: null,
          controller: textController,
          decoration: InputDecoration(
            hintText: hint,
          ),
        ),
      ),
    );
  }
}
