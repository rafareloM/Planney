import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => preload());
  }

  Future preload() async {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.popAndPushNamed(context, '/welcomePage');
      } else {
        Navigator.popAndPushNamed(context, '/');
      }
    });
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
