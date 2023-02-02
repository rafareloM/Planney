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
    final TransactionController controller =
        GetIt.instance.get<TransactionController>();
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: deviceHeight * 0.12,
      width: deviceWidth * 0.8,
      child: TextFormField(
        onChanged: (value) => controller.transactionValue = double.parse(value
            .replaceAll('R\$', '')
            .replaceAll(',', '.')
            .replaceAll('.', '')),
        inputFormatters: [Mask.money()],
        textAlign: TextAlign.end,
        style: const TextStyle(
          fontSize: 36,
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
            size: 36,
          ),
        ),
        keyboardType: const TextInputType.numberWithOptions(),
      ),
    );
  }
}
