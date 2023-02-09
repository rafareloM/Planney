import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/stores/planney_user.store.dart';
import 'package:planney/stores/transactions.store.dart';
import 'package:planney/style/style.dart';
import 'package:planney/ui/components/charts/bar_chart.dart';
import 'package:planney/ui/components/home/avatar.dart';
import 'package:planney/ui/components/home/info_card.dart';
import 'package:planney/ui/components/home/my_drawer.dart';
import 'package:planney/ui/components/home/planney_logo.dart';
import 'package:planney/ui/components/transaction/transaction_list_card.dart';
import 'package:planney/ui/controller/home.controller.dart';

class RelatoryPage extends StatelessWidget {
  RelatoryPage({Key? key}) : super(key: key);
  final _userStore = GetIt.instance.get<PlanneyUserStore>();
  final _controller = GetIt.instance.get<HomePageController>();
  final _transactionStore = GetIt.instance.get<TransactionsStore>();
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    Color textColor = colorScheme.brightness == Brightness.dark
        ? colorScheme.onSurface
        : colorScheme.primary;

    return Observer(builder: (context) {
      return Scaffold(
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
        body: ListView(
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
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Fluxo do Saldo',
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  deviceWidth * 0.015, 8, deviceWidth * 0.015, 0),
              child: Observer(builder: (_) {
                return _transactionStore.list.isEmpty
                    ? InfoCard(
                        height: deviceHeight * 0.48,
                        content: Center(
                          child: Stack(
                            children: [
                              Container(
                                height: deviceHeight * 0.3,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppStyle.initialchartcolor,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(36),
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    shape: CircleBorder(),
                                    child: Center(
                                      child: Text(
                                        'A categoria\nestá vazia!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onPressed: null,
                        buttonColor: textColor)
                    : InfoCard(
                        height: deviceHeight * 0.48,
                        content: BarChartSample3(
                          textColor: textColor,
                          transactions: _controller.finalListReceipt
                              .takeWhile((value) => value.date.isAfter(
                                  DateTime.now()
                                      .subtract(const Duration(days: 8))))
                              .toList(),
                        ),
                        onPressed: null,
                        buttonColor: textColor,
                      );
              }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Fluxo de Gasto',
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  deviceWidth * 0.015, 8, deviceWidth * 0.015, 0),
              child: Observer(builder: (_) {
                return _transactionStore.list.isEmpty
                    ? InfoCard(
                        height: deviceHeight * 0.48,
                        content: Center(
                          child: Stack(
                            children: [
                              Container(
                                height: deviceHeight * 0.3,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppStyle.initialchartcolor,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(36),
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    shape: CircleBorder(),
                                    child: Center(
                                      child: Text(
                                        'A categoria\nestá vazia!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onPressed: null,
                        buttonColor: textColor)
                    : InfoCard(
                        height: deviceHeight * 0.48,
                        content: BarChartSample3(
                          textColor: textColor,
                          transactions: _controller.finalListExpence
                              .takeWhile((value) => value.date.isAfter(
                                  DateTime.now()
                                      .subtract(const Duration(days: 8))))
                              .toList(),
                        ),
                        onPressed: null,
                        buttonColor: textColor,
                      );
              }),
            ),
            _transactionStore.list.isEmpty
                ? SizedBox(
                    height: deviceHeight * 0.02,
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('DETALHAMENTO',
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ),
                      ),
                      Card(
                        elevation: 10,
                        child: Column(
                          children: _transactionStore.list.map((e) {
                            return TransactionListCard(
                              showLeading: false,
                              transaction: e,
                              positiveAction: (e) async {
                                _controller.setLoading(true);
                                await _controller.remove(e);
                                _controller.setLoading(false);
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      );
    });
  }
}
