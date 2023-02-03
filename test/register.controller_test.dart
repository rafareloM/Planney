import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/infra/repositories/auth.repository_impl.dart';
import 'package:planney/infra/services/auth.service_mock.dart';
import 'package:planney/stores/planney_user.store.dart';
import 'package:planney/ui/controller/register.controller.dart';

void main() {
  final getIt = GetIt.instance;

  getIt.registerSingleton(PlanneyUserStore());
  getIt.registerFactory(() => RegisterController(
        AuthRepositoryImpl(AuthServiceMock()),
      ));

  RegisterController controller = getIt.get();
  test(
    'register',
    () async {
      controller.changeEmail('test@test.com');
      controller.changeName('Test test');
      controller.changePassword('test123');
      controller.changeRepeatPassword('test123');

      final PlanneyUserStore userStore = getIt.get();

      await controller.doRegister();
      expect(userStore.planneyUser, isNotNull);
    },
  );
}
