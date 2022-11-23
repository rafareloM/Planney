import 'package:flutter/material.dart';
import 'package:planney/ui/components/avatar.dart';
import 'package:planney/ui/components/bottom_navigation_bar.dart';
import 'package:planney/ui/components/info_card.dart';
import 'package:planney/ui/components/planney_logo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text(
          'Nova Transição',
        ),
      ),
      appBar: AppBar(
        title: ConstrainedBox(
          constraints: BoxConstraints.tight(
            const Size(150, 32),
          ),
          child: const PlanneyLogo(size: 24),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
          ),
        ),
      ),
      bottomNavigationBar: const HomeBottomNavigationBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const Avatar(
                  userName: 'Marilene',
                  userBalance: 2365.96,
                ),
                const InfoCard(
                    cardTitle: 'Fluxo do Saldo',
                    textButtonCTA: 'Mais Detalhes',
                    imagePath:
                        'lib/style/assets/img/Colorful Flower Fashion Sale Presentation (3).png'),
                const InfoCard(
                    cardTitle: 'Despesas Semanais',
                    textButtonCTA: 'Exibir Transações',
                    imagePath:
                        'lib/style/assets/img/Green and Orange Budget Pie Chart Graph (1).png'),
                const InfoCard(
                    cardTitle: 'Despesas Pendentes',
                    textButtonCTA: 'Mostrar Despesas',
                    imagePath:
                        'lib/style/assets/img/Green Minimalist 4 Points Donut Chart Graph (2).png'),
                SizedBox(
                  height: deviceHeight * 0.1,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
