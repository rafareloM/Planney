import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/infra/services/planney_user.service.dart';
import 'package:planney/model/category.model.dart';
import 'package:planney/stores/planney_user.store.dart';

class PlanneyUserServiceMock extends PlanneyUserService {
  @override
  Future<DocumentSnapshot> get() async {
    MockFirebaseAuth(
        signedIn: true,
        mockUser: MockUser(
          email: 'test@test.com',
          uid: 'mock_uid',
        ));

    final db = FakeFirebaseFirestore();
    await db.collection('users').doc('mock_uid').set({
      'fullName': 'test',
      'email': 'test@test.com',
      'categories': CategoryHelper.defaultCategoriesToMap()
    });

    final documentSnapshot = await db.collection('users').doc('mock_uid').get();
    return documentSnapshot;
  }

  @override
  Future<bool> update(Map<String, dynamic> map) async {
    final planneyUserStore = GetIt.instance.get<PlanneyUserStore>();

    final db = FakeFirebaseFirestore();

    await db.collection('users').doc(planneyUserStore.uid).update(map);

    return true;
  }
}
