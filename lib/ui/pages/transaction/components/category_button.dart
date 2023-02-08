// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:planney/style/style.dart';

class CategoryButton extends StatelessWidget {
  final String? name;
  final Color color;
  final IconData icon;
  final bool paintBackground;
  final void Function() onPressed;
  final double size;

  const CategoryButton({
    Key? key,
    required this.paintBackground,
    required this.name,
    required this.color,
    required this.icon,
    required this.onPressed,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).colorScheme.brightness;
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          name == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    name!.toUpperCase(),
                    style: TextStyle(
                      fontSize: 13,
                      color: brightness == Brightness.dark
                          ? AppStyle.fullWhite
                          : AppStyle.chartcolor1,
                    ),
                  ),
                ),
          paintBackground
              ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: brightness == Brightness.dark
                        ? AppStyle.fullWhite
                        : AppStyle.chartcolor1,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      iconSize: 48,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        icon,
                        color: color,
                        semanticLabel: name,
                      ),
                      onPressed: onPressed,
                    ),
                  ),
                )
              : IconButton(
                  iconSize: size,
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    icon,
                    color: color,
                    semanticLabel: name,
                  ),
                  onPressed: onPressed,
                ),
        ],
      ),
    );
  }
}
