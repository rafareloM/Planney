import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/infra/services/transaction.service.dart';
import 'package:planney/model/category.model.dart';
import 'package:planney/model/transaction.model.dart' as planney;
import 'package:planney/stores/planney_user.store.dart';

class TransactionServiceMock extends TransactionService {
  @override
  Future<DocumentReference> add(Map<String, dynamic> map) async {
    final userStore = GetIt.instance.get<PlanneyUserStore>();

    final db = FakeFirebaseFirestore();

    final docRef = await db
        .collection("users")
        .doc(userStore.uid)
        .collection("transactions")
        .add(map);
    return docRef;
  }

  @override
  Future<bool> update(String uid, Map<String, dynamic> map) async {
    final userStore = GetIt.instance.get<PlanneyUserStore>();

    final db = FakeFirebaseFirestore();

    await db
        .collection("users")
        .doc(userStore.uid)
        .collection("transactions")
        .doc(uid)
        .update(map);

    return true;
  }

  @override
  Future<bool> remove(String uid) async {
    final userStore = GetIt.instance.get<PlanneyUserStore>();

    final db = FakeFirebaseFirestore();

    await db
        .collection("users")
        .doc(userStore.uid)
        .collection("transactions")
        .doc(uid)
        .delete();

    return true;
  }

  @override
  Future<QuerySnapshot> getByMonth(DateTime dateSelected) async {
    final userStore = GetIt.instance.get<PlanneyUserStore>();

    final db = FakeFirebaseFirestore();

    var map = planney.Transaction(
            type: planney.TransactionType.expence,
            value: 100,
            userAccount: planney.UserAccounts.principal,
            category: CategoryHelper.defaultCategories.first,
            description: 'test',
            date: DateTime.now())
        .toMap();
    var map2 = planney.Transaction(
            type: planney.TransactionType.receipt,
            value: 100,
            userAccount: planney.UserAccounts.principal,
            category: CategoryHelper.defaultCategories.first,
            description: 'test',
            date: DateTime.now())
        .toMap();
    await db
        .collection("users")
        .doc(userStore.uid)
        .collection("transactions")
        .add(map);
    await db
        .collection("users")
        .doc(userStore.uid)
        .collection("transactions")
        .add(map2);

    final beginMonth =
        Timestamp.fromDate(DateTime(dateSelected.year, dateSelected.month, 1));
    final nextMonth =
        Timestamp.fromDate(DateTime(dateSelected.year, dateSelected.month + 1));
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
