import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:planney/infra/repositories/auth.repository.dart';
import 'package:planney/infra/repositories/planney_user.repository.dart';
import 'package:planney/model/api_response.model.dart';
import 'package:planney/stores/planney_user.store.dart';
part 'login.controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  @observable
  bool canShowPassword = false;
  String _email = '';
  String _password = '';

  final AuthRepository _authRepository;
  final PlanneyUserRepository _planneyUserRepository;

  final planneyUserStore = GetIt.instance.get<PlanneyUserStore>();

  LoginControllerBase(this._authRepository, this._planneyUserRepository);

  void changeEmail(String value) {
    _email = value;
  }

  void changePassword(String value) {
    _password = value;
  }

  Future<APIResponse<bool>> login() async {
    final userResponse = await _authRepository.login(_email, _password);
    _email = '';
    _password = '';
    if (userResponse.isSuccess) {
      planneyUserStore.setUser(
          userResponse.data!.uid, userResponse.data!.email!);
      final planneyUserResponse = await _planneyUserRepository.get();
      planneyUserStore.setPlanneyUser(planneyUserResponse.data!);
      return APIResponse.success(true);
    } else {
      if (_authRepository.isLogged()) {
        await _authRepository.logout();
      }
      return APIResponse.error('Ops! Falha no login!');
    }
  }
}
