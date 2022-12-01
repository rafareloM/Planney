import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/ui/components/avatar.dart';
import 'package:planney/ui/components/bottom_navigation_bar.dart';
import 'package:planney/ui/components/my_drawer.dart';
import 'package:planney/ui/components/planney_logo.dart';
import 'package:planney/ui/components/transaction_chart_card.dart';
import 'package:planney/ui/controller/home.controller.dart';
import 'package:planney/ui/pages/transaction/view/transaction_add_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.instance.get<HomePageController>();

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Observer(builder: (context) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: colorScheme.brightness == Brightness.dark
              ? colorScheme.primary
              : colorScheme.tertiary,
          foregroundColor: colorScheme.onPrimary,
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: ((context) => TransactionAddPage(
                    type: controller.isExpence
                        ? TransactionType.expence
                        : TransactionType.receipt,
                    isExpense: controller.isExpence,
                  )),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(21))),
            );
          },
          child: const Icon(
            Icons.add,
            size: 35,
          ),
        ),
        drawer: const MyDrawer(),
        appBar: AppBar(
          backgroundColor: colorScheme.brightness == Brightness.dark
              ? colorScheme.background
              : colorScheme.primary,
          title: ConstrainedBox(
            constraints: BoxConstraints.tight(
              const Size(150, 32),
            ),
            child: const PlanneyLogo(size: 24),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: const HomeBottomNavigationBar(),
        body: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            const Avatar(
              userName: 'Marilene',
              userBalance: 2365.96,
            ),
            const SizedBox(
              height: 16,
            ),
            TransactionChartCard(
              isExpence: controller.isExpence,
              controller: controller,
              colorScheme: colorScheme,
            )
          ],
        ),
      );
    });
  }
}
