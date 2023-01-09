import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/ui/controller/home.controller.dart';
import 'package:planney/ui/controller/transaction.controller.dart';
import 'package:planney/ui/pages/home/homepage.dart';
import 'package:planney/ui/pages/login/login_page.dart';
import 'package:planney/ui/pages/onboarding/welcome_page.dart';

void main() {
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton(HomePageController());

  getIt.registerSingleton(TransactionController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = GetIt.instance.get<HomePageController>();

    return Observer(builder: (context) {
      return MaterialApp(
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [Locale('pt', 'BR')],
        debugShowCheckedModeBanner: false,
        title: 'Planney',
        theme: controller.selectedAppTheme,
        initialRoute: '/welcomePage',
        routes: {
          '/': ((context) => const HomePage()),
          '/welcomePage': ((context) => const WelcomePage()),
          '/loginPage': ((context) => const LoginPage()),
        },
      );
    });
  }
}
