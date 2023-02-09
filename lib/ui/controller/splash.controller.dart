import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/infra/repositories/planney_user.repository.dart';
import 'package:planney/stores/planney_user.store.dart';

class SplashController {
  final PlanneyUserRepository _planneyUserRepository;

  SplashController(this._planneyUserRepository);

  final planneyUserStore = GetIt.instance.get<PlanneyUserStore>();
  final db = FirebaseAuth.instance;

  loadUser() async {
    planneyUserStore.setUser(db.currentUser!.uid, db.currentUser!.email!);
    final planneyUserResponse = await _planneyUserRepository.get();
    planneyUserStore.setPlanneyUser(planneyUserResponse.data!);
  }
}
