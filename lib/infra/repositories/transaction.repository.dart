import 'package:planney/model/api_response.model.dart';
import 'package:planney/model/transaction.model.dart';

abstract class TransactionRepository {
  Future<APIResponse<List<Transaction>>> getMonth(DateTime dateSelected);
  Future<APIResponse<Transaction>> add(Transaction item);
  Future<APIResponse<bool>> update(Transaction item, Transaction newItem);
  Future<APIResponse<bool>> remove(Transaction item);
}
