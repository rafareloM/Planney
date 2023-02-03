import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/ui/controller/home.controller.dart';

class ThemeSelect extends StatelessWidget {
  const ThemeSelect({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Brightness brightness = Theme.of(context).brightness;
    bool isDark = brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(isDark ? Icons.light_mode : Icons.dark_mode,
                color: isDark ? colorScheme.onSurface : colorScheme.primary),
          ),
          Text(
            isDark ? 'Modo Claro' : 'Modo Escuro',
            style: TextStyle(
                color: isDark ? colorScheme.onSurface : colorScheme.primary),
          )
        ]),
        onTap: () => GetIt.instance.get<HomePageController>().changeAppTheme(),
      ),
    );
  }
}
