import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/stores/planney_user.store.dart';

class TransactionService {
  Future<DocumentReference> add(Map<String, dynamic> map) async {
    final userStore = GetIt.instance.get<PlanneyUserStore>();

    final db = FirebaseFirestore.instance;

    final docRef = await db
        .collection("users")
        .doc(userStore.uid)
        .collection("transactions")
        .add(map);

    return docRef;
  }

  Future<bool> update(String uid, Map<String, dynamic> map) async {
    final userStore = GetIt.instance.get<PlanneyUserStore>();

    final db = FirebaseFirestore.instance;

    await db
        .collection("users")
        .doc(userStore.uid)
        .collection("transactions")
        .doc(uid)
        .update(map);

    return true;
  }

  Future<bool> remove(String uid) async {
    final userStore = GetIt.instance.get<PlanneyUserStore>();

    final db = FirebaseFirestore.instance;

    await db
        .collection("users")
        .doc(userStore.uid)
        .collection("transactions")
        .doc(uid)
        .delete();

    return true;
  }

  Future<QuerySnapshot> getByMonth(DateTime dateSelected) async {
    final userStore = GetIt.instance.get<PlanneyUserStore>();

    final db = FirebaseFirestore.instance;

    final beginMonth = DateTime(dateSelected.year, dateSelected.month, 1)
        .millisecondsSinceEpoch;
    final nextMonth = DateTime(dateSelected.year, dateSelected.month + 1)
        .millisecondsSinceEpoch;

    final querySnapshot = await db
        .collection("users")
        .doc(userStore.uid)
        .collection("transactions")
        .where("date",
            isGreaterThanOrEqualTo: beginMonth, isLessThan: nextMonth)
        .get();

    return querySnapshot;
  }
}
