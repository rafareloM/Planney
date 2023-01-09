import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planney/ui/controller/transaction.controller.dart';

class DatePicker extends StatelessWidget {
  final TransactionController controller;
  final Color color;
  const DatePicker({
    Key? key,
    required this.controller,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        controller.selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(017, 9, 7, 17, 30),
              lastDate: DateTime.now().add(
                const Duration(days: 31),
              ),
            ) ??
            DateTime.now();
        controller.formattedDate =
            DateFormat('dd/MM/y').format(controller.selectedDate);
      },
      icon: Icon(
        Icons.calendar_today_outlined,
        color: color,
      ),
      iconSize: 40,
    );
  }
}
