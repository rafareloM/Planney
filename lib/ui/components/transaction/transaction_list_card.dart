import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/style/style.dart';
import 'package:planney/ui/components/custom_alert_dialog.dart';
import 'package:planney/ui/pages/transaction/view/transaction_update_page.dart';

class TransactionListCard extends StatelessWidget {
  final Transaction transaction;
  final bool showLeading;
  final void Function(Transaction) positiveAction;

  const TransactionListCard({
    Key? key,
    required this.transaction,
    required this.showLeading,
    required this.positiveAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomAlertDialog dialog = CustomAlertDialog();
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Card(
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                showModalBottomSheet(
                  isDismissible: true,
                  isScrollControlled: true,
                  context: context,
                  constraints: BoxConstraints(maxHeight: deviceHeight * 0.9),
                  builder: ((context) => TransactionUpdatePage(
                        transaction: transaction,
                        type: transaction.type,
                      )),
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(21))),
                );
              },
              backgroundColor: AppStyle.primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Editar',
            ),
            SlidableAction(
              onPressed: (context) {
                dialog.show(
                  title: 'Remover Transação',
                  message:
                      'Tem certeza que quer remover a transação? Isso não pode ser desfeito!',
                  positiveAction: () {
                    positiveAction(transaction);
                  },
                );
              },
              backgroundColor: AppStyle.errorDark,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Excluir',
            ),
          ],
        ),
        child: ListTile(
          tileColor: AppStyle.graytextbox.withAlpha(25),
          title: Text(
            transaction.description.toUpperCase(),
            style: TextStyle(color: colorScheme.onSurface, fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
          leading: showLeading
              ? CircleAvatar(
                  radius: 24,
                  backgroundColor: transaction.category.color,
                  child: Icon(
                    transaction.category.icon,
                    size: 16,
                  ),
                )
              : const SizedBox(),
          minLeadingWidth: 0,
          subtitle: Text(DateFormat('d MMM y').format(transaction.date)),
          trailing: Text(
            'R\$${transaction.value.toStringAsFixed(2).replaceAll('.', ',')}',
            style: TextStyle(
              color: transaction.type == TransactionType.expence
                  ? AppStyle.errorDark
                  : AppStyle.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
