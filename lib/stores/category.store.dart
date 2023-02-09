import 'package:mobx/mobx.dart';
import 'package:planney/model/category.model.dart';
import 'package:planney/model/transaction.model.dart';
part 'category.store.g.dart';

class CategoryStore = CategoryStoreBase with _$CategoryStore;

abstract class CategoryStoreBase with Store {
  @observable
  ObservableList<Category> list = ObservableList();

  @action
  replaceList(List<Category> categories) {
    list.clear();
    list.addAll(categories);
  }

  @action
  addCategory(Category category) {
    list.add(category);
  }

  @action
  removeCategory(Category category) {
    list.removeWhere((e) => e.uid == category.uid);
  }

  @computed
  List<Category>? get getListExpence =>
      list.where((element) => element.type == TransactionType.expence).toList();

  @computed
  List<Category>? get getListReceipt =>
      list.where((element) => element.type == TransactionType.receipt).toList();

  @action
  List<Category> getCategoriesByType(bool isExpence) {
    List<Category> finalList = [];
    finalList.addAll(list);
    if (isExpence) {
      finalList
          .removeWhere((element) => element.type != TransactionType.expence);
    } else if (!isExpence) {
      finalList
          .removeWhere((element) => element.type != TransactionType.receipt);
    }
    return finalList;
  }
}
