import 'package:flutter/material.dart';
import 'package:planney/ui/pages/homepage.dart';
import 'package:planney/ui/pages/login_page.dart';
import 'package:planney/ui/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/welcomePage',
      routes: {
        '/': ((context) => const HomePage()),
        '/welcomePage': ((context) => const WelcomePage()),
        '/loginPage': ((context) => const LoginPage()),
      },
    );
  }
}
