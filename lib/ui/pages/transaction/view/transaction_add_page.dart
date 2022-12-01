import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/ui/components/transaction/date_picker.dart';
import 'package:planney/ui/controller/transaction.controller.dart';
import 'package:planney/ui/pages/transaction/components/account_select_radio.dart';
import 'package:planney/ui/pages/transaction/components/text_form.dart';
import 'package:planney/ui/pages/transaction/components/value_form.dart';

import '../components/categories_list.dart';

class TransactionAddPage extends StatelessWidget {
  final TransactionType type;
  final bool isExpense;
  const TransactionAddPage(
      {Key? key, required this.type, required this.isExpense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.instance.get<TransactionController>();

    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Color onSurface = Theme.of(context).brightness == Brightness.dark
        ? colorScheme.onPrimary
        : colorScheme.primary;

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: deviceHeight * 0.95),
      child: Observer(
        builder: (context) {
          return SafeArea(
            child: Column(
              children: [
                Container(
                  height: deviceHeight * 0.15,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(21)),
                    color: colorScheme.brightness == Brightness.dark
                        ? colorScheme.background
                        : colorScheme.primary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        isExpense ? 'ADICIONAR DESPESA' : 'ADICIONAR RECEITA',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(
                        width: 52,
                      ),
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Icon(
                            Icons.close,
                            size: 32,
                            color: colorScheme.background,
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: Scaffold(
                    body: SingleChildScrollView(
                      primary: false,
                      child: Form(
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: Column(
                            children: [
                              ValueForm(
                                controller: controller.valueController,
                                icon: isExpense
                                    ? Icons.arrow_downward_rounded
                                    : Icons.arrow_upward_rounded,
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(14, 17, 0, 14),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'CONTA',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              AccountSelectRadio(
                                controller: controller,
                                width: deviceWidth * 0.3,
                                height: deviceHeight * 0.05,
                                color: colorScheme.primary,
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(14, 17, 0, 14),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'CATEGORIA',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              CategoriesList(
                                color: colorScheme.brightness == Brightness.dark
                                    ? onSurface
                                    : colorScheme.tertiary,
                                selectedColor: colorScheme.primary,
                                controller: controller,
                                height: deviceHeight * 1,
                                width: deviceWidth * 1,
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(32, 17, 0, 0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'COMENTÁRIO',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    28, 10, deviceWidth * 0.1, 0),
                                child: TextForm(
                                  textController: controller.textController,
                                  height: deviceHeight * 0.08,
                                  hint: 'Escreva um comentário',
                                  hintFontSize: 16,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(28, 21, 0, 0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'DATA DA TRANSAÇÃO',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: DatePicker(
                                        controller: controller,
                                        color: colorScheme.tertiary,
                                      ),
                                    ),
                                    Text(controller.formattedDate),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 25, 16),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            const StadiumBorder())),
                                    onPressed: () {
                                      controller.transactionValue =
                                          double.tryParse(controller
                                                  .valueController.value
                                                  .toString()) ??
                                              0;
                                      controller.addTransaction(isExpense);
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 9),
                                      child: Text(isExpense
                                          ? 'Adicionar Despesa'
                                          : 'Adicionar Renda'),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}