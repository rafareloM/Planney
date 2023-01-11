import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/infra/repositories/auth.repository_impl.dart';
import 'package:planney/infra/repositories/planney_user.repository_impl.dart';
import 'package:planney/infra/services/auth.service.dart';
import 'package:planney/infra/services/planney_user.service.dart';
import 'package:planney/navigator_key.dart';
import 'package:planney/stores/planney_user.store.dart';
import 'package:planney/ui/controller/home.controller.dart';
import 'package:planney/ui/controller/login.controller.dart';
import 'package:planney/ui/controller/register.controller.dart';
import 'package:planney/ui/controller/transaction.controller.dart';
import 'package:planney/ui/pages/home/home_page.dart';
import 'package:planney/ui/pages/login/login_page.dart';
import 'package:planney/ui/pages/onboarding/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:planney/ui/pages/register/register_page.dart';
import 'package:planney/ui/pages/splash/splash_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GetIt.instance.registerSingleton(PlanneyUserStore());

  GetIt getIt = GetIt.instance;
  getIt.registerLazySingleton(() => HomePageController());
  getIt.registerLazySingleton(() => TransactionController());

  GetIt.instance.registerFactory(
    () => LoginController(AuthRepositoryImpl(AuthService()),
        PlanneyUserRepositoryImpl(PlanneyUserService())),
  );
  GetIt.instance.registerFactory(() => RegisterController(
        AuthRepositoryImpl(AuthService()),
      ));

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
        navigatorKey: navigatorKey,
        initialRoute: '/loginPage',
        routes: {
          '/': (context) => const HomePage(),
          '/splashPage': (context) => const SplashPage(),
          '/welcomePage': (context) => const WelcomePage(),
          '/loginPage': (context) => LoginPage(),
          '/registerPage': (context) => RegisterPage(),
        },
      );
    });
  }
}
