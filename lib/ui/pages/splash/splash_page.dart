import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/navigator_key.dart';
import 'package:planney/ui/controller/splash.controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _controller = GetIt.instance.get<SplashController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => preload());
  }

  Future preload() async {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      await _controller.loadUser();
      Navigator.pushReplacementNamed(navigatorKey.currentContext!, '/');
    } else {
      Navigator.pushReplacementNamed(
          navigatorKey.currentContext!, '/welcomePage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Card(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
