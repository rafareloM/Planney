import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mask/mask/mask.dart';
import 'package:planney/ui/controller/transaction.controller.dart';

class ValueForm extends StatefulWidget {
  final IconData icon;
  const ValueForm({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  State<ValueForm> createState() => _ValueFormState();
}

class _ValueFormState extends State<ValueForm> {
  @override
  Widget build(BuildContext context) {
    final TransactionController _controller =
        GetIt.instance.get<TransactionController>();
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: deviceHeight * 0.1,
      width: deviceWidth * 0.5,
      child: TextFormField(
        validator: ((value) {
          if (value == null) {
            return 'Insira um valor!';
          }
        }),
        onChanged: (value) => _controller.transactionValue =
            double.parse(value.replaceAll('R\$', '').replaceAll(',', '.')),
        inputFormatters: [Mask.money()],
        textAlign: TextAlign.end,
        style: const TextStyle(
          fontSize: 24,
        ),
        textAlignVertical: TextAlignVertical.bottom,
        maxLines: null,
        expands: true,
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
