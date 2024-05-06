import 'package:flutter/material.dart';
import 'package:planney/style/style.dart';
import 'package:planney/ui/components/home/planney_logo.dart';

abstract class AdaptativeAppBar extends AppBar {
  factory AdaptativeAppBar.fromBrightness(Brightness brightness, {String? title}) {
    if (brightness == Brightness.dark) {
      return DarkAppBar(
        title: title,
      );
    } else {
      return LightAppBar(
        title: title,
      );
    }
  }
}

class LightAppBar extends AppBar implements AdaptativeAppBar {
  LightAppBar({String? title, super.key})
      : super(
          backgroundColor: AppStyle.lightColorScheme.primary,
          title: title != null
              ? ConstrainedBox(
                  constraints: BoxConstraints.tight(
                    const Size(150, 32),
                  ),
                  child: Text(title),
                )
              : LayoutBuilder(
                  builder: (context, constraints) => SizedBox(
                    width: constraints.maxWidth,
                    child: const PlanneyLogo(size: 24),
                  ),
                ),
          centerTitle: true,
        );
}

class DarkAppBar extends AppBar implements AdaptativeAppBar {
  DarkAppBar({String? title, super.key})
      : super(
          backgroundColor: AppStyle.darkColorScheme.background,
          title: title != null
              ? ConstrainedBox(
                  constraints: BoxConstraints.tight(
                    const Size(150, 32),
                  ),
                  child: Text(title),
                )
              : LayoutBuilder(
                  builder: (context, constraints) => SizedBox(
                    width: constraints.maxWidth,
                    child: const PlanneyLogo(size: 24),
                  ),
                ),
          centerTitle: true,
        );
}
