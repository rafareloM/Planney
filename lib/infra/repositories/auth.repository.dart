import 'package:firebase_auth/firebase_auth.dart';
import 'package:planney/model/api_response.model.dart';

abstract class AuthRepository {
  Future<APIResponse<String?>> register(
      String fullName, String email, String password);
  bool isLogged();
  User getUser();
  Future<APIResponse<User?>> login(String email, String password);
  Future<APIResponse<bool>> logout();
}
