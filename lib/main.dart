import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/infra/repositories/auth.repository_impl.dart';
import 'package:planney/infra/repositories/planney_user.repository_impl.dart';
import 'package:planney/infra/repositories/transaction.repository_impl.dart';
import 'package:planney/infra/services/auth.service.dart';
import 'package:planney/infra/services/planney_user.service.dart';
import 'package:planney/infra/services/transaction.service.dart';
import 'package:planney/navigator_key.dart';
import 'package:planney/stores/category.store.dart';
import 'package:planney/stores/planney_user.store.dart';
import 'package:planney/stores/transactions.store.dart';
import 'package:planney/ui/controller/home.controller.dart';
import 'package:planney/ui/controller/login.controller.dart';
import 'package:planney/ui/controller/register.controller.dart';
import 'package:planney/ui/controller/splash.controller.dart';
import 'package:planney/ui/controller/transaction.controller.dart';
import 'package:planney/ui/pages/home/home_page.dart';
import 'package:planney/ui/pages/login/login_page.dart';
import 'package:planney/ui/pages/category_charts/views/detail.category.dart';
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

  GetIt.instance.registerSingleton(TransactionsStore());

  GetIt.instance.registerSingleton(CategoryStore());

  GetIt getIt = GetIt.instance;
  getIt.registerLazySingleton(
    () => HomePageController(
      TransactionRepositoryImpl(TransactionService()),
      PlanneyUserRepositoryImpl(PlanneyUserService()),
      AuthRepositoryImpl(AuthService()),
    ),
  );
  getIt.registerLazySingleton(() =>
      TransactionController(TransactionRepositoryImpl(TransactionService())));

  getIt.registerFactory(
    () => LoginController(AuthRepositoryImpl(AuthService()),
        PlanneyUserRepositoryImpl(PlanneyUserService())),
  );
  getIt.registerFactory(() => RegisterController(
        AuthRepositoryImpl(AuthService()),
      ));
  getIt.registerFactory(() => SplashController(getIt.get(param1: getIt.get())));

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
        initialRoute: '/splashPage',
        routes: {
          '/': ((context) => const HomePage()),
          '/welcomePage': ((context) => const WelcomePage()),
          '/splashPage': (context) => const SplashPage(),
          '/loginPage': (context) => LoginPage(),
          '/registerPage': (context) => RegisterPage(),
          '/detailPage': ((context) => const DetailCategoryPage()),
        },
      );
    });
  }
}
