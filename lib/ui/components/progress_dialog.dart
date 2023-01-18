import 'package:flutter/material.dart';
import 'package:planney/navigator_key.dart';

class ProgressDialog {
  bool _isShowing = false;

  final Color? color;
  final Color? onSurface;

  ProgressDialog({
    required this.color,
    required this.onSurface,
  });

  show(String message) {
    if (_isShowing) return;
    _isShowing = true;
    showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              backgroundColor: color,
              content: SizedBox(
                height: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: onSurface,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      message,
                      style: TextStyle(color: onSurface),
                    )
                  ],
                ),
              ),
            ));
  }

  hide() {
    if (!_isShowing) return;
    _isShowing = false;
    navigatorKey.currentState!.pop();
  }
}
