import 'package:planney/model/category.model.dart';
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

  static double totalDayValue(List<Transaction> list, int weekday) {
    double totalValue = 0;

    for (var item in list) {
      if (item.date.weekday == weekday) {
        totalValue += item.value;
      }
    }
    return totalValue;
  }

  static double dayBalance(List<Transaction> list, int weekday) {
    double result = 0;
    for (var transaction in list) {
      if (transaction.date.weekday == weekday) {
        if (transaction.type == TransactionType.expence) {
          result -= transaction.value;
        } else if (transaction.type == TransactionType.receipt) {
          result += transaction.value;
        }
      }
    }
    return result;
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

  static List<Category> getCategories(List<Transaction> transactionsList) {
    transactionsList.sort((a, b) => a.category.name.compareTo(b.category.name));
    var firstTransaction = transactionsList.first;
    List<Category> categories = [];
    Category previewCategory = firstTransaction.category;
    categories.add(firstTransaction.category);
    for (var transaction in transactionsList) {
      if (transaction != firstTransaction &&
          transaction.category.name != previewCategory.name) {
        previewCategory = transaction.category;
        categories.add(previewCategory);
      }
    }
    return categories;
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
      case 4:
        return AppStyle.primaryColor;
      case 5:
        return AppStyle.chartcolor5;
      case 6:
        return AppStyle.chartcolor6;
      default:
        return AppStyle.primaryColor;
    }
  }

  static double getHighestDayValue(List<Transaction> transactionsList) {
    double result = 0;
    for (var weekday = 1; weekday < 8; weekday++) {
      double actualDayValue = totalDayValue(transactionsList, weekday);
      actualDayValue > result ? result = actualDayValue : result;
    }
    return result;
  }

  static double getLowestDayValue(List<Transaction> transactionsList) {
    double result = 0;
    for (var weekday = 1; weekday < 8; weekday++) {
      double actualDayValue = dayBalance(transactionsList, weekday);
      actualDayValue > result ? result = actualDayValue : result;
    }
    return result;
  }

  static double getTotalValue(List<Transaction> transactionsList) {
    double result = 0;
    for (var transaction in transactionsList) {
      result += transaction.value;
    }
    return result;
  }

  static weekdayToString(int weekday) {
    switch (weekday) {
      case 1:
        return 'SEG';
      case 2:
        return 'TER';
      case 3:
        return 'QUA';
      case 4:
        return 'QUI';
      case 5:
        return 'SEX';
      case 6:
        return 'SAB';
      case 7:
        return 'DOM';
      default:
        null;
    }
  }
}
