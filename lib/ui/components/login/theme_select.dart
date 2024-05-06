import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/style/style.dart';
import 'package:planney/ui/controller/home.controller.dart';

abstract class ThemeSelect extends StatelessWidget {
  const ThemeSelect({super.key});

  factory ThemeSelect.fromBrightness(Brightness brightness) {
    if (brightness != Brightness.dark) {
      return const ThemeDarkMode();
    } else {
      return const ThemeLightMode();
    }
  }
}

class ThemeDarkMode extends ThemeSelect {
  const ThemeDarkMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.dark_mode, color: AppStyle.darkColorScheme.onSurface),
          ),
          Text(
            'Modo Escuro',
            style: TextStyle(color: AppStyle.darkColorScheme.onSurface),
          )
        ]),
        onTap: () => GetIt.instance.get<HomePageController>().changeAppTheme(),
      ),
    );
  }
}

class ThemeLightMode extends ThemeSelect {
  const ThemeLightMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.light_mode, color: AppStyle.lightColorScheme.primary),
          ),
          Text(
            'Modo Claro',
            style: TextStyle(color: AppStyle.lightColorScheme.primary),
          )
        ]),
        onTap: () => GetIt.instance.get<HomePageController>().changeAppTheme(),
      ),
    );
  }
}
