import 'package:planney/model/transaction.model.dart';
import 'package:planney/style/style.dart';

abstract class ChartsHelper {
  static double totalCategoryValue(List<Transaction> lista, String category) {
    double totalValue = 0;

    for (var item in lista) {
      if (item.category.name == category) {
        totalValue += item.value;
      }
    }
    return totalValue;
  }

  static List<Transaction> getTransactionsByCategory(
      List<Transaction> lista, String category) {
    List<Transaction> filteredList = [];

    for (var item in lista) {
      if (item.category.name == category) {
        filteredList.add(item);
      }
    }
    return filteredList;
  }

  static List<String> getCategoryNames(List<Transaction> transactionsList) {
    transactionsList
        .sort(((a, b) => a.category.name.compareTo(b.category.name)));
    var firstTransaction = transactionsList.first;
    List<String> categoryNames = [];
    String previewCategory = firstTransaction.category.name;

    categoryNames.add(firstTransaction.category.name);
    for (var item in transactionsList) {
      if (item != firstTransaction && item.category.name != previewCategory) {
        previewCategory = item.category.name;
        categoryNames.add(previewCategory);
      }
    }
    return categoryNames;
  }

  static setColorByIndex(int index) {
    switch (index) {
      case 0:
        return AppStyle.chartcolor1;
      case 1:
        return AppStyle.chartcolor2;
      case 2:
        return AppStyle.chartcolor3;
      case 3:
        return AppStyle.chartcolor4;
      default:
        return AppStyle.primaryColor;
    }
  }
}
