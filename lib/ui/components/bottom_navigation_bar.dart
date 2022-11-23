import 'package:flutter/material.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(currentIndex: 0, items: const [
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
