import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/stores/planney_user.store.dart';
import 'package:planney/ui/components/home/avatar.dart';
import 'package:planney/ui/components/home/my_drawer.dart';
import 'package:planney/ui/components/home/planney_logo.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => preload());
  }

  Future preload() async {
    _controller.setLoading(true);
    await _controller.getTransactionsList();
    await _controller.getCategoriesList();
    _controller.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    double deviceHeight = MediaQuery.of(context).size.height;
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
              isDismissible: true,
              isScrollControlled: true,
              constraints: BoxConstraints(maxHeight: deviceHeight * 0.9),
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
        body: _controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Avatar(
                      userName: _userStore.planneyUser != null
                          ? _userStore.planneyUser?.fullName.split(' ').first
                          : '',
                      userBalance: _controller.totalValue,
                      path: _userStore.user?.photoURL,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Observer(builder: (_) {
                      return TransactionChartCard(
                        isExpence: _controller.isExpence,
                        controller: _controller,
                        colorScheme: colorScheme,
                        transactionList: _controller.isExpence
                            ? _controller.finalListExpence
                            : _controller.finalListReceipt,
                      );
                    }),
                  ),
                ],
              ),
      );
    });
  }
}
