import 'package:flutter/material.dart';
import 'package:planney/style/style.dart';
import 'package:planney/ui/pages/home/homepage.dart';
import 'package:planney/ui/pages/login/login_page.dart';
import 'package:planney/ui/pages/onboarding/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeData selectedAppTheme = AppStyle.appThemeDark;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: selectedAppTheme,
      initialRoute: '/welcomePage',
      routes: {
        '/': ((context) => const HomePage()),
        '/welcomePage': ((context) => const WelcomePage()),
        '/loginPage': ((context) => const LoginPage()),
      },
    );
  }
}
