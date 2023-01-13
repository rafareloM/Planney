import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:planney/infra/repositories/auth.repository.dart';
import 'package:planney/model/api_response.model.dart';
import 'package:planney/model/category.model.dart';
import 'package:planney/model/planney_user.dart';
import 'package:planney/stores/planney_user.store.dart';
part 'register.controller.g.dart';

class RegisterController = RegisterControllerBase with _$RegisterController;

abstract class RegisterControllerBase with Store {
  final AuthRepository _authRepository;

  RegisterControllerBase(
    this._authRepository,
  );

  final planneyUserStore = GetIt.instance.get<PlanneyUserStore>();

  @observable
  bool canShowPassword = false;
  @observable
  bool canShowRepeatPassword = false;

  String _email = '';
  String _fullName = '';
  String _password = '';
  String _repeatPassword = '';

  void changeEmail(String value) {
    _email = value;
  }

  void changeName(String value) {
    _fullName = value;
  }

  void changePassword(String value) {
    _password = value;
  }

  void changeRepeatPassword(String value) {
    _repeatPassword = value;
  }

  Future<APIResponse<bool>> doRegister() async {
    if (_fullName.isEmpty) {
      return APIResponse.error("É necessário informar um nome.");
    }

    if (_fullName.split(' ').length == 1) {
      return APIResponse.error("É necessário ao menos um sobrenome.");
    }
    if (_password != _repeatPassword) {
      return APIResponse.error("Senhas precisam ser iguais.");
    }
    final result = await _authRepository.register(
        _fullName, _email, _password, CategoryHelper.defaultCategoriesToMap());
    if (result.data != null) {
      planneyUserStore.setUser(result.data!, _email);
      final planneyUser = PlanneyUser(
        fullName: _fullName,
        email: _email,
      );
      planneyUserStore.setPlanneyUser(planneyUser);

      return APIResponse.success(true);
    } else {
      return APIResponse.error("Ops! Algum problema aconteceu!");
    }
  }
}
