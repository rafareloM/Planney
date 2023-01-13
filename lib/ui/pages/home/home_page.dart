import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/stores/category.store.dart';
import 'package:planney/stores/planney_user.store.dart';
import 'package:planney/stores/transactions.store.dart';
import 'package:planney/ui/components/custom_alert_dialog.dart';
import 'package:planney/ui/components/home/avatar.dart';
import 'package:planney/ui/components/home/bottom_navigation_bar.dart';
import 'package:planney/ui/components/home/my_drawer.dart';
import 'package:planney/ui/components/home/planney_logo.dart';
import 'package:planney/ui/components/progress_dialog.dart';
import 'package:planney/ui/components/transaction/transaction_chart_card.dart';
import 'package:planney/ui/controller/home.controller.dart';
import 'package:planney/ui/pages/transaction/view/transaction_add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = GetIt.instance.get<HomePageController>();
  final _userStore = GetIt.instance.get<PlanneyUserStore>();
  final _transactionsStore = GetIt.instance.get<TransactionsStore>();
  final CategoryStore _categoryStore = GetIt.instance.get<CategoryStore>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => preload());
  }

  Future preload() async {
    await _controller.getTransactionsList();
    await _controller.getCategoriesList();
  }

  @override
  Widget build(BuildContext context) {
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
                    type: _controller.isExpence
                        ? TransactionType.expence
                        : TransactionType.receipt,
                    isExpense: _controller.isExpence,
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
          title: LayoutBuilder(
            builder: (context, constraints) => SizedBox(
              width: constraints.maxWidth,
              child: const PlanneyLogo(size: 24),
            ),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: const HomeBottomNavigationBar(),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 6),
              child: Avatar(
                userName: 'Marilene',
                userBalance: 2365.96,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Observer(builder: (_) {
                return TransactionChartCard(
                  isExpence: _controller.isExpence,
                  controller: _controller,
                  colorScheme: colorScheme,
                  transactionList: getCategoriesByType(
                      _controller.isExpence, _transactionsStore.list),
                );
              }),
            ),
          ],
        ),
      );
    });
  }

  List<Transaction> getCategoriesByType(
      bool isExpence, List<Transaction> list) {
    List<Transaction> finalList = [];
    finalList.addAll(list);
    if (isExpence) {
      finalList
          .removeWhere((element) => element.type != TransactionType.expence);
    } else if (!isExpence) {
      finalList
          .removeWhere((element) => element.type != TransactionType.receipt);
    }
    return finalList;
  }
}
