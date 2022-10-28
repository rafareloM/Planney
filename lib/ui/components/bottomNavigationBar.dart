import 'package:flutter/material.dart';
import 'package:planney/style/style.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: AppStyle.backgroundBuyColor,
        fixedColor: AppStyle.button1Color,
        unselectedItemColor: AppStyle.cardBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_rounded),
            label: 'Relatórios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Perfil',
          ),
        ]);
  }
}
