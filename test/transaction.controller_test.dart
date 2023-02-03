import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/infra/repositories/auth.repository_impl.dart';
import 'package:planney/infra/repositories/planney_user.repository_impl.dart';
import 'package:planney/infra/repositories/transaction.repository_impl.dart';
import 'package:planney/infra/services/auth.service_mock.dart';
import 'package:planney/infra/services/planney_user.service_mock.dart';
import 'package:planney/infra/services/transaction.service_mock.dart';
import 'package:planney/model/category.model.dart';
import 'package:planney/stores/category.store.dart';
import 'package:planney/stores/planney_user.store.dart';
import 'package:planney/stores/transactions.store.dart';
import 'package:planney/ui/controller/home.controller.dart';
import 'package:planney/ui/controller/transaction.controller.dart';

void main() {
  GetIt.instance.registerSingleton(PlanneyUserStore());

  GetIt.instance.registerSingleton(TransactionsStore());

  GetIt.instance.registerSingleton(CategoryStore());

  GetIt.instance.registerSingleton(HomePageController(
      TransactionRepositoryImpl(TransactionServiceMock()),
      PlanneyUserRepositoryImpl(PlanneyUserServiceMock()),
      AuthRepositoryImpl(AuthServiceMock())));

  final controller = TransactionController(
    TransactionRepositoryImpl(TransactionServiceMock()),
  );

  test(
    'add transaction',
    () async {
      controller.description = 'test';
      controller.selectedDate = DateTime.now();
      controller.transactionValue = 100;
      controller.selectedCategory = CategoryHelper.defaultCategories.first;
      await controller.registerTransaction(true);
      controller.description = 'test';
      controller.selectedDate = DateTime.now();
      controller.transactionValue = 100;
      controller.selectedCategory = CategoryHelper.defaultCategories.first;
      await controller.registerTransaction(false);
      expect(GetIt.instance.get<TransactionsStore>().count, 2);
    },
  );

  test(
    'test dispose',
    () async {
      controller.description = 'test';
      controller.selectedDate = DateTime.now();
      controller.transactionValue = 100;
      controller.selectedCategory = CategoryHelper.defaultCategories.first;
      controller.dispose();
      expect(controller.description, '');
      expect(controller.formattedDate, '');
      expect(controller.transactionValue, 0);
    },
  );
}
