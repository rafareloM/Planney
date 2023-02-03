import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:planney/infra/services/auth.service.dart';

class AuthServiceMock extends AuthService {
  final db = FakeFirebaseFirestore();
  final auth = MockFirebaseAuth();

  @override
  Future<String?> register(
      String fullName, String email, String password, List list) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    final uid = userCredential.user!.uid;
    await db.collection("users").doc(uid).set({
      'full_name': fullName,
      'email': email,
      'categories': list,
      'created_at': FieldValue.serverTimestamp(),
    });

    return uid;
  }

  @override
  bool isLogged() {
    return auth.currentUser != null;
  }

  @override
  Future<User?> login(String email, String password) async {
    var userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user!;
  }

  @override
  Future<bool> logout() async {
    await auth.signOut();
    return true;
  }

  @override
  User? getUser() {
    return MockUser(
        email: 'test@test.com', displayName: 'test test', uid: 'mock_uid');
  }
}
