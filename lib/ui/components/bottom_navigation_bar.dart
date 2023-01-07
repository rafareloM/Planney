import 'package:flutter/material.dart';
import 'package:planney/style/style.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: colorScheme.brightness == Brightness.dark
            ? colorScheme.background
            : AppStyle.chartcolor4,
        selectedItemColor: colorScheme.brightness == Brightness.dark
            ? colorScheme.primary
            : colorScheme.tertiary,
        items: const [
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
