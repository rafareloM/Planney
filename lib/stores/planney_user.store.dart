import 'package:mobx/mobx.dart';
import 'package:planney/model/planney_user.dart';
part 'planney_user.store.g.dart';

class PlanneyUserStore = PlanneyUserStoreBase with _$PlanneyUserStore;

abstract class PlanneyUserStoreBase with Store {
  @readonly
  String? _uid;

  @readonly
  String? _email;

  @readonly
  PlanneyUser? _planneyUser;

  @action
  void setUser(String uid, String email) {
    _uid = uid;
    _email = email;
  }

  @action
  void setPlanneyUser(PlanneyUser planneyUser) {
    _planneyUser = planneyUser;
  }

  @action
  void unloadPlanneyUser() {
    _uid = null;
    _email = null;
    _planneyUser = null;
  }
}
