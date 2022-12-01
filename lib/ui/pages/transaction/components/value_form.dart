import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';

class ValueForm extends StatefulWidget {
  final TextEditingController controller;
  final IconData icon;

  const ValueForm({
    Key? key,
    required this.controller,
    required this.icon,
  }) : super(key: key);

  @override
  State<ValueForm> createState() => _ValueFormState();
}

class _ValueFormState extends State<ValueForm> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: deviceHeight * 0.1,
      width: deviceWidth * 0.5,
      child: TextField(
        inputFormatters: [
          TextInputMask(
              mask: 'R!\$! !9+,999.99',
              placeholder: '0',
              maxPlaceHolders: 3,
              reverse: true)
        ],
        textAlign: TextAlign.end,
        style: const TextStyle(
          fontSize: 24,
        ),
        textAlignVertical: TextAlignVertical.bottom,
        maxLines: null,
        expands: true,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: 'R\$0,00',
          hintStyle: TextStyle(
            color: Theme.of(context).hintColor,
          ),
          suffix: Icon(
            widget.icon,
            color: Theme.of(context).hintColor,
            size: 24,
          ),
        ),
        keyboardType: const TextInputType.numberWithOptions(),
      ),
    );
  }
}
