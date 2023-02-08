import 'package:mobx/mobx.dart';
part 'detail_category.controller.g.dart';

class DetailCategoryController = DetailCategoryControllerBase
    with _$DetailCategoryController;

abstract class DetailCategoryControllerBase with Store {
  @observable
  ObservableList widgets = ObservableList();
}
