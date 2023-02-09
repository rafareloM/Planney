import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/infra/repositories/auth.repository_impl.dart';
import 'package:planney/infra/repositories/planney_user.repository_impl.dart';
import 'package:planney/infra/services/auth.service_mock.dart';
import 'package:planney/infra/services/planney_user.service_mock.dart';
import 'package:planney/stores/planney_user.store.dart';
import 'package:planney/ui/controller/login.controller.dart';

void main() {
  final getIt = GetIt.instance;

  getIt.registerSingleton(PlanneyUserStore());
  getIt.registerFactory(() => LoginController(
      AuthRepositoryImpl(AuthServiceMock()),
      PlanneyUserRepositoryImpl(PlanneyUserServiceMock())));

  final LoginController controller = getIt.get();
  test(
    'Login',
    () async {
      controller.changeEmail('test@test.com');
      controller.changePassword('test123');
      final PlanneyUserStore userStore = getIt.get();
      await controller.login();

      expect(userStore.planneyUser, isNotNull);
    },
  );
}
