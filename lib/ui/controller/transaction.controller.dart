import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:planney/infra/repositories/transaction.repository.dart';
import 'package:planney/model/api_response.model.dart';
import 'package:planney/model/category.model.dart';
import 'package:planney/model/transaction.model.dart';
import 'package:planney/stores/transactions.store.dart';
import 'package:planney/ui/controller/home.controller.dart';
part 'transaction.controller.g.dart';

class TransactionController = TransactionControllerBase
    with _$TransactionController;

abstract class TransactionControllerBase with Store {
  final TransactionRepository _repository;

  TransactionControllerBase(this._repository);

  final _store = GetIt.instance.get<TransactionsStore>();

  final _homeController = GetIt.instance.get<HomePageController>();

  Future<APIResponse<bool>> registerTransaction(bool isExpense) async {
    if (transactionValue == 0) {
      return APIResponse.error('O valor da Transição é obrigatório.');
    }

    if (selectedCategory == null) {
      return APIResponse.error('Selecione uma categoria.');
    }

    if (description == '') {
      return APIResponse.error('O campo de descrição é obrigatório.');
    }

    Transaction transaction = Transaction(
        date: selectedDate,
        description: description,
        value: transactionValue,
        category: selectedCategory!,
        type: isExpense ? TransactionType.expence : TransactionType.receipt,
        userAccount: selectedUserAccount);

    final response = await _repository.add(transaction);
    if (response.isSuccess) {
      _store.addTransaction(response.data!);
      if (isExpense) {
        _homeController.finalListExpence.add(transaction);
      } else {
        _homeController.finalListReceipt.add(transaction);
      }
      dispose();
      return APIResponse.success(true);
    } else {
      return APIResponse.error('Algo deu errado');
    }
  }

  Future<APIResponse<bool>> updateTransaction(Transaction transaction) async {
    Transaction newTransaction = transaction.copyWith(
        category: selectedCategory,
        date: selectedDate,
        description: description,
        userAccount: selectedUserAccount,
        value: transactionValue);
    final response = await _repository.update(transaction, newTransaction);
    if (response.isSuccess) {
      _store.list[_store.list
              .indexWhere((element) => element.uid == transaction.uid)] =
          newTransaction;
      dispose();
      return APIResponse.success(true);
    } else {
      return APIResponse.error('Algo deu errado');
    }
  }

  setTransaction(Transaction transaction) {
    description = transaction.description;
    transactionValue = double.parse(transaction.value.toString());
    selectedDate = transaction.date;
    selectedCategory = transaction.category;
    selectedUserAccount = transaction.userAccount;
  }

  dispose() {
    formattedDate = '';
    selectedDate = DateTime.now();
    transactionValue = 0;
    selectedUserAccount = UserAccounts.principal;
    description = '';
    formattedDate = '';
    selectedCategory = null;
  }

  @observable
  DateTime selectedDate = DateTime.now();

  @observable
  String formattedDate = '';

  @observable
  String description = '';

  @observable
  UserAccounts selectedUserAccount = UserAccounts.principal;

  @observable
  double transactionValue = 0;

  @observable
  Category? selectedCategory;
}
