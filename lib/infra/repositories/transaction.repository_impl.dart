import 'package:planney/infra/repositories/transaction.repository.dart';
import 'package:planney/infra/services/transaction.service.dart';
import 'package:planney/model/api_response.model.dart';
import 'package:planney/model/transaction.model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionService _service;

  TransactionRepositoryImpl(this._service);

  @override
  Future<APIResponse<Transaction>> add(Transaction item) async {
    final docRef = await _service.add(item.toMap());
    item.uid = docRef.id;
    if (item.uid != null) {
      return APIResponse.success(item);
    } else {
      return APIResponse.error("Operação falhou!");
    }
  }

  @override
  Future<APIResponse<List<Transaction>>> getMonth(DateTime dateSelected) async {
    final querySnapshot = await _service.getByMonth(dateSelected);
    List<Transaction> listTransactions = [];
    for (var doc in querySnapshot.docs) {
      Transaction item =
          Transaction.fromFirestore(doc.data() as Map<String, dynamic>);
      item.uid = doc.id;
      listTransactions.add(item);
    }
    return APIResponse.success(listTransactions);
  }

  @override
  Future<APIResponse<bool>> remove(Transaction item) async {
    final result = await _service.remove(item.uid!);
    if (result) {
      return APIResponse.success(result);
    } else {
      return APIResponse.error("Operação falhou!");
    }
  }

  @override
  Future<APIResponse<bool>> update(Transaction item) async {
    final result = await _service.update(item.uid!, item.toMap());
    if (result) {
      return APIResponse.success(result);
    } else {
      return APIResponse.error("Operação falhou!");
    }
  }
}
