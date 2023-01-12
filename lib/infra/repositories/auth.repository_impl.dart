import 'package:firebase_auth/firebase_auth.dart';
import 'package:planney/infra/repositories/auth.repository.dart';
import 'package:planney/infra/services/auth.service.dart';
import 'package:planney/model/api_response.model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _service;

  AuthRepositoryImpl(this._service);

  @override
  User getUser() {
    final user = _service.getUser();
    if (user != null) {
      return user;
    } else {
      throw Exception('Usuário não logado!');
    }
  }

  @override
  bool isLogged() {
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<APIResponse<User?>> login(String email, String password) async {
    final response = await _service.login(email, password);
    return APIResponse.success(response);
  }

  @override
  Future<APIResponse<bool>> logout() async {
    final result = await _service.logout();
    return APIResponse.success(result);
  }

  @override
  Future<APIResponse<String?>> register(
      String fullName, String email, String password) async {
    final response = await _service.register(fullName, email, password);
    return APIResponse.success(response);
  }
}
