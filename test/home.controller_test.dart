import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
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
import 'package:planney/style/style.dart';
import 'package:planney/ui/controller/home.controller.dart';
import 'package:planney/ui/controller/transaction.controller.dart';

void main() {
  final getIt = GetIt.instance;

  getIt.registerSingleton(PlanneyUserStore());

  getIt.registerSingleton(TransactionsStore());

  getIt.registerSingleton(CategoryStore());

  getIt.registerSingleton(HomePageController(
      TransactionRepositoryImpl(TransactionServiceMock()),
      PlanneyUserRepositoryImpl(PlanneyUserServiceMock()),
      AuthRepositoryImpl(AuthServiceMock())));

  getIt.registerSingleton(TransactionController(
      TransactionRepositoryImpl(TransactionServiceMock())));

  final HomePageController controller = getIt.get();

  final transactionController = TransactionController(
    TransactionRepositoryImpl(TransactionServiceMock()),
  );
  final instance = FakeFirebaseFirestore();

  setUp(
    () {
      final TransactionsStore store = getIt.get();
      store.list.clear();
      controller.filteredList.clear();
      controller.finalListExpence.clear();
      controller.finalListReceipt.clear();
    },
  );

  test(
    'homepage logout',
    () {
      final PlanneyUserStore userStore = getIt.get();

      final service = AuthServiceMock();
      service.login('test@test.com', 'test123');

      controller.logout();
      expect(userStore.planneyUser, null);
    },
  );
  test(
    'setLoading function',
    () {
      controller.setLoading(true);
      expect(controller.isLoading, true);
    },
  );

  test(
    'setIsExpence function',
    () {
      controller.setIsExpence(false);
      expect(controller.isExpence, false);
    },
  );

  test(
    'changeAppTheme function',
    () {
      controller.changeAppTheme();
      expect(controller.selectedAppTheme, AppStyle.appThemeLight);

      controller.changeAppTheme();
      expect(controller.selectedAppTheme, AppStyle.appThemeDark);
    },
  );
  test(
    'get Transactions',
    () async {
      final PlanneyUserStore userStore = getIt.get();

      userStore.setUser('asdasd', 'test@test.com');

      await controller.getTransactionsList();
      expect(controller.finalListExpence.length, 1);
      expect(controller.finalListReceipt.length, 1);

      instance.dump();
    },
  );

  test(
    'delete transaction',
    () async {
      final PlanneyUserStore userStore = getIt.get();
      final TransactionsStore store = getIt.get();
      userStore.setUser('asdasd', 'test@test.com');

      await controller.getTransactionsList();
      final uid = store.list.first.uid;
      await controller
          .remove(store.list.firstWhere((element) => element.uid == uid));

      expect(store.list.any((element) => element.uid == uid), false);
    },
  );

  test(
    'get Categories',
    () async {
      final CategoryStore store = getIt.get();

      await controller.getCategoriesList();
      expect(store.list.isNotEmpty, true);
    },
  );

  test(
    'get transactions by Category',
    () {
      controller.getTransactionsByCategory('transporte');
      expect(
          controller.filteredList
              .every((element) => element.category.name == 'transporte'),
          true);
    },
  );

  test(
    'get totalValue',
    () async {
      transactionController.description = 'test2';
      transactionController.selectedDate = DateTime.now();
      transactionController.transactionValue = 220;
      transactionController.selectedCategory =
          CategoryHelper.defaultCategories[1];
      await transactionController.registerTransaction(false);

      transactionController.description = 'test2';
      transactionController.selectedDate = DateTime.now();
      transactionController.transactionValue = 110;
      transactionController.selectedCategory =
          CategoryHelper.defaultCategories[1];
      await transactionController.registerTransaction(true);
      expect(controller.totalValue, 110);
    },
  );
}
