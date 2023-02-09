import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/ui/controller/transaction.controller.dart';

class TextForm extends StatelessWidget {
  final String hint;
  final double hintFontSize;
  final double height;

  const TextForm(
      {Key? key,
      required this.hint,
      required this.height,
      required this.hintFontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionController controller =
        GetIt.instance.get<TransactionController>();
    return SizedBox(
      height: height,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: height,
        ),
        child: TextFormField(
          onChanged: (value) => controller.description = value,
          validator: (value) {
            if (value == '') {
              return 'O campo não pode ser vazio!';
            }
            return null;
          },
          textAlignVertical: TextAlignVertical.bottom,
          style: TextStyle(fontSize: hintFontSize),
          expands: true,
          maxLines: null,
          decoration: InputDecoration(
              hintText: hint, hintStyle: TextStyle(fontSize: hintFontSize)),
        ),
      ),
    );
  }
}
