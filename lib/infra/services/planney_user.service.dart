import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/stores/planney_user.store.dart';

class PlanneyUserService {
  Future<DocumentSnapshot> get() async {
    final planneyUserStore = GetIt.instance.get<PlanneyUserStore>();

    final db = FirebaseFirestore.instance;

    final documentSnapshot =
        await db.collection('users').doc(planneyUserStore.uid).get();

    return documentSnapshot;
  }

  Future<bool> update(Map<String, dynamic> map) async {
    final planneyUserStore = GetIt.instance.get<PlanneyUserStore>();

    final db = FirebaseFirestore.instance;

    await db.collection('users').doc(planneyUserStore.uid).set(map);

    return true;
  }
}
