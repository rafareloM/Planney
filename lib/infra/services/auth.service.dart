import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<String?> register(
      String fullName, String email, String password, List list) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    final uid = userCredential.user!.uid;

    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      'full_name': fullName,
      'email': email,
      'categories': list,
      'created_at': FieldValue.serverTimestamp(),
    });
    return uid;
  }

  bool isLogged() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<User?> login(String email, String password) async {
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user!;
  }

  Future<bool> logout() async {
    await FirebaseAuth.instance.signOut();
    return true;
  }

  User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
