import 'package:flutter/material.dart';
import 'package:planney/style/style.dart';
import 'package:planney/ui/components/avatar.dart';
import 'package:planney/ui/components/bottomNavigationBar.dart';
import 'package:planney/ui/components/info_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppStyle.button1Color,
        label: Text(
          'Nova Transição',
          style: TextStyle(
            color: AppStyle.backgroundBuyColor,
          ),
        ),
      ),
      backgroundColor: AppStyle.homepageColor,
      appBar: AppBar(
          title: Text(
            'Planney',
            style: TextStyle(
              color: AppStyle.button1Color,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppStyle.backgroundBuyColor,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: AppStyle.button1Color,
            ),
          )),
      bottomNavigationBar: const HomeBottomNavigationBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                Avatar(
                  userName: 'Marcus',
                  userBalance: 2365.96,
                ),
                InfoCard(
                    cardTitle: 'Fluxo do Saldo',
                    textButtonCTA: 'Mais Detalhes',
                    imagePath:
                        'lib/style/assets/img/Colorful Flower Fashion Sale Presentation (3).png'),
                InfoCard(
                    cardTitle: 'Despesas Semanais',
                    textButtonCTA: 'Exibir Transações',
                    imagePath:
                        'lib/style/assets/img/Green and Orange Budget Pie Chart Graph (1).png'),
                InfoCard(
                    cardTitle: 'Despesas Pendentes',
                    textButtonCTA: 'Mostrar Despesas',
                    imagePath:
                        'lib/style/assets/img/Green Minimalist 4 Points Donut Chart Graph (2).png'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
