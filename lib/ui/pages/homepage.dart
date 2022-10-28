import 'package:flutter/material.dart';
import 'package:planney/style/style.dart';
import 'package:planney/ui/components/avatar.dart';
import 'package:planney/ui/components/info_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.backgroundColor,
      body: Column(
        children: [
          Avatar(
            userName: 'Marcus',
            userBalance: 2365.96,
          ),
          SingleChildScrollView(
            child: InfoCard(
                cardTitle: 'Fluxo de Gastos',
                textButtonCTA: 'Exibir Detalhes',
                imagePath:
                    'lib/style/assets/img/Colorful Flower Fashion Sale Presentation (3).png'),
          )
        ],
      ),
    );
  }
}
