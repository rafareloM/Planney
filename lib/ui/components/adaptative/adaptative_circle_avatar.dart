import 'package:flutter/material.dart';
import 'package:planney/style/style.dart';
import 'package:planney/ui/components/home/planney_logo.dart';

abstract class AdaptatveCircleAvatar extends CircleAvatar {
  factory AdaptatveCircleAvatar.fromBrightness(Brightness brightness, {String? title}) {
    if (brightness == Brightness.dark) {
      return DarkCircleAvatar(
        title: title,
      );
    } else {
      return LightCircleAvatar(
        title: title,
      );
    }
  }
}

class LightCircleAvatar extends CircleAvatar implements AdaptatveCircleAvatar {
  const LightCircleAvatar({String? title, super.key}) : super();
}

class DarkCircleAvatar extends CircleAvatar implements AdaptatveCircleAvatar {
  const DarkCircleAvatar({String? title, super.key}) : super();
}
