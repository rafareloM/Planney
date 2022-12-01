import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/ui/controller/transaction.controller.dart';

class AccountSelectRadio extends StatelessWidget {
  final double height;
  final double width;
  final TransactionController controller;
  final Color color;
  const AccountSelectRadio(
      {Key? key,
      required this.height,
      required this.width,
      required this.controller,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: UserAccounts.values.map((e) {
        return SizedBox(
          height: height,
          width: width,
          child: Observer(builder: (_) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 4,
              minLeadingWidth: 20,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              onTap: () => controller.selectedUserAccount = UserAccounts.values
                  .firstWhere((element) => element.index == e.index),
              dense: true,
              title: Text(
                UserAccounts.values
                    .firstWhere((element) => element.index == e.index)
                    .name
                    .toUpperCase(),
                style: const TextStyle(fontSize: 16),
              ),
              leading: Radio<UserAccounts>(
                activeColor: color,
                value: UserAccounts.values
                    .firstWhere((element) => element.index == e.index),
                groupValue: controller.selectedUserAccount,
                onChanged: ((value) {
                  controller.selectedUserAccount = value!;
                }),
              ),
            );
          }),
        );
      }).toList(),
    );
  }
}
